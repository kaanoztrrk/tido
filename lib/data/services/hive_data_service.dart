// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HiveDataService {
  Future<String> getDatabaseSize() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = directory.path;
      final directorySize = await _getDirectorySize(Directory(dbPath));
      return (directorySize / (1024 * 1024)).toStringAsFixed(2); // MB cinsinden
    } catch (e) {
      print('Error while getting database size: $e');
      return 'Error';
    }
  }

  Future<int> getNumberOfRecords(String boxName) async {
    try {
      final box = await Hive.openBox(boxName);
      return box.length;
    } catch (e) {
      print('Error while getting number of records: $e');
      return 0;
    }
  }

  Future<String> getLastBackupDate() async {
    // Yedekleme tarihini almak için uygun bir yöntem ekleyin
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = directory.path;
      final backupFile = File('$dbPath/backup.timestamp');
      if (await backupFile.exists()) {
        final timestamp = await backupFile.readAsString();
        return timestamp;
      } else {
        return 'No backup found';
      }
    } catch (e) {
      print('Error while getting last backup date: $e');
      return 'Error';
    }
  }

  Future<String> getDatabaseStatus() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = directory.path;
      final directoryExists = await Directory(dbPath).exists();
      return directoryExists ? 'Healthy' : 'Not Found';
    } catch (e) {
      print('Error while getting database status: $e');
      return 'Error';
    }
  }

  Future<String> getDatabaseHealth() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = directory.path;
      final dbDirectory = Directory(dbPath);
      final integrity = await _checkDatabaseIntegrity(dbDirectory);
      return integrity ? 'Good' : 'Corrupted';
    } catch (e) {
      print('Error while checking database health: $e');
      return 'Error';
    }
  }

  Future<String> getLastModificationDate() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = directory.path;
      final dbDirectory = Directory(dbPath);
      final modificationDate = await _getLastModificationDate(dbDirectory);
      return modificationDate;
    } catch (e) {
      print('Error while getting last modification date: $e');
      return 'N/A';
    }
  }

  Future<int> _getDirectorySize(Directory directory) async {
    int totalSize = 0;
    try {
      final List<FileSystemEntity> entities =
          directory.listSync(recursive: true);
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          final File file = entity;
          totalSize += await file.length();
        }
      }
    } catch (e) {
      print('Error while calculating directory size: $e');
    }
    return totalSize;
  }

  Future<String> _getLastModificationDate(Directory directory) async {
    DateTime latestModification = DateTime.fromMillisecondsSinceEpoch(0);
    try {
      final List<FileSystemEntity> entities =
          directory.listSync(recursive: true);
      for (FileSystemEntity entity in entities) {
        if (entity is File) {
          final File file = entity;
          final FileStat stat = await file.stat();
          if (stat.modified.isAfter(latestModification)) {
            latestModification = stat.modified;
          }
        }
      }
    } catch (e) {
      print('Error while getting last modification date: $e');
    }
    return latestModification.toIso8601String();
  }

  Future<bool> _checkDatabaseIntegrity(Directory directory) async {
    try {
      // Basit bir sağlık kontrolü olarak dosya varlığını kontrol edebiliriz
      final List<FileSystemEntity> entities =
          directory.listSync(recursive: true);
      return entities.isNotEmpty;
    } catch (e) {
      print('Error while checking database integrity: $e');
      return false;
    }
  }
}
