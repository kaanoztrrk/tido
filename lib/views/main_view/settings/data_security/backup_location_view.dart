// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../data/services/backup_sevices.dart';
import '../../../../common/widget/appbar/appbar.dart';
import '../../../../core/l10n/l10n.dart';

class BackupLocationView extends StatefulWidget {
  const BackupLocationView({super.key});

  @override
  _BackupLocationViewState createState() => _BackupLocationViewState();
}

class _BackupLocationViewState extends State<BackupLocationView> {
  final HiveBackupService _backupService = HiveBackupService();
  List<File> _backupFiles = [];
  String _lastBackupDate = 'Yedekleme yapılmadı';

  @override
  void initState() {
    super.initState();
    _loadBackupData();
  }

  Future<void> _loadBackupData() async {
    try {
      final backupFiles = await _backupService.getBackupFiles();
      final lastBackupDate = await _backupService.getLastBackupDate();

      setState(() {
        _backupFiles = backupFiles;
        _lastBackupDate = lastBackupDate;
      });
    } catch (e) {
      print('Error loading backup data: $e');
    }
  }

  Future<void> _startBackup() async {
    try {
      await _backupService.backupTaskBox();
      await _loadBackupData();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yedekleme başarıyla tamamlandı.')),
      );
    } catch (e) {
      print('Error starting backup: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yedekleme sırasında hata oluştu.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.backup_location),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Son Yedekleme Tarihi: $_lastBackupDate',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Yedekleme Dosyaları:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _backupFiles.length,
                itemBuilder: (context, index) {
                  final file = _backupFiles[index];
                  return FutureBuilder<List<String>>(
                    future: Future.wait([
                      _backupService.getFileSize(file),
                      _backupService.getFileModificationDate(file),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          title: Text(file.path.split('/').last),
                          subtitle: const Text('Yükleniyor...'),
                        );
                      }
                      if (snapshot.hasError) {
                        return ListTile(
                          title: Text(file.path.split('/').last),
                          subtitle: Text('Hata: ${snapshot.error}'),
                        );
                      }

                      final fileSize = snapshot.data?[0] ?? 'Hata';
                      final modificationDate = snapshot.data?[1] ?? 'Hata';
                      return ListTile(
                        title: Text(file.path.split('/').last),
                        subtitle: Text(
                            'Boyut: $fileSize\nSon Değişiklik: $modificationDate'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await _backupService.deleteBackupFile(file.path);
                            _loadBackupData(); // Yedekleme dosyalarını yeniden yükle
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startBackup,
        tooltip: 'Yedekle',
        child: const Icon(Icons.backup),
      ),
    );
  }
}
