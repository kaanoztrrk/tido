import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task_model/task_model.dart';

class HiveBackupService {
  // Yedekleme işlemi
  Future<void> backupTaskBox() async {
    try {
      final boxName = 'allTasksBox';

      // Check if the box is already open
      Box<TaskModel>? box;
      if (Hive.isBoxOpen(boxName)) {
        box = Hive.box<TaskModel>(boxName);
      } else {
        box = await Hive.openBox<TaskModel>(boxName);
      }

      final directory = await getApplicationDocumentsDirectory();
      final backupDirectory = Directory('${directory.path}/backup');
      if (!backupDirectory.existsSync()) {
        backupDirectory.createSync();
      }

      final timestamp = DateTime.now().toIso8601String();
      final backupFile =
          File('${backupDirectory.path}/$boxName/$timestamp.json');

      final Map<String, dynamic> data = {};
      for (var key in box.keys) {
        final task = box.get(key) as TaskModel;
        data[key.toString()] = task.toJson();
      }

      final jsonString = jsonEncode(data);
      await backupFile.writeAsString(jsonString);

      print('Backup created: ${backupFile.path}');
    } catch (e) {
      print('Error during backup: $e');
      rethrow;
    }
  }

  // Yedekleme dosyasını silme
  Future<void> deleteBackupFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        print('Backup file deleted: $filePath');
      }
    } catch (e) {
      print('Error deleting backup file: $e');
    }
  }

  // Yedekleme dosyalarını listeleme
  Future<List<File>> getBackupFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final backupDirectory = Directory('${directory.path}/backup');
      if (await backupDirectory.exists()) {
        final files = backupDirectory.listSync().whereType<File>().toList();
        return files;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting backup files: $e');
      return [];
    }
  }

  // Son yedekleme tarihini almak
  Future<String> getLastBackupDate() async {
    try {
      final backupFiles = await getBackupFiles();
      if (backupFiles.isNotEmpty) {
        final latestFile = backupFiles.reduce((a, b) =>
            a.statSync().modified.isAfter(b.statSync().modified) ? a : b);
        return latestFile.statSync().modified.toIso8601String();
      } else {
        return 'Yedekleme yapılmadı';
      }
    } catch (e) {
      print('Error getting last backup date: $e');
      return 'Hata';
    }
  }

  // Dosya boyutunu almak
  Future<String> getFileSize(File file) async {
    try {
      final sizeInBytes = await file.length();
      return (sizeInBytes / (1024 * 1024)).toStringAsFixed(2) + ' MB';
    } catch (e) {
      print('Error getting file size: $e');
      return 'Hata';
    }
  }

  // Dosyanın son değiştirilme tarihini almak
  Future<String> getFileModificationDate(File file) async {
    try {
      final stat = await file.stat();
      return stat.modified.toIso8601String();
    } catch (e) {
      print('Error getting file modification date: $e');
      return 'Hata';
    }
  }
}
