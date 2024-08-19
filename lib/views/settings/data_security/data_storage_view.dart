import 'package:flutter/material.dart';

import '../../../common/styles/container_style.dart';
import '../../../common/widget/appbar/appbar.dart';
import '../../../core/l10n/l10n.dart';
import '../../../data/services/hive_data_service.dart';
import '../../../utils/Constant/sizes.dart';

class DataStorageView extends StatelessWidget {
  const DataStorageView({super.key});

  @override
  Widget build(BuildContext context) {
    final HiveDataService hiveDataService = HiveDataService();

    return Scaffold(
      appBar: ViAppBar(
        showBackArrow: true,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.data_storage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Future.wait([
            hiveDataService.getDatabaseSize(),
            hiveDataService.getNumberOfRecords('allTasksBox'),
            hiveDataService.getLastBackupDate(),
            hiveDataService.getDatabaseStatus(),
            hiveDataService.getDatabaseHealth(),
            hiveDataService.getLastModificationDate(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final databaseSize = snapshot.data![0] as String;
            final numberOfRecords = snapshot.data![1] as int;
            final lastBackupDate = snapshot.data![2] as String;
            final databaseStatus = snapshot.data![3] as String;
            final databaseHealth = snapshot.data![4] as String;
            final lastModificationDate = snapshot.data![5] as String;

            return ListView(
              children: [
                _buildStatCard(
                  context,
                  title: 'Database Size',
                  value: '$databaseSize MB',
                ),
                _buildStatCard(
                  context,
                  title: 'Number of Records',
                  value: '$numberOfRecords',
                ),
                _buildStatCard(
                  context,
                  title: 'Last Backup Date',
                  value: lastBackupDate,
                ),
                _buildStatCard(
                  context,
                  title: 'Database Status',
                  value: databaseStatus,
                ),
                _buildStatCard(
                  context,
                  title: 'Database Health',
                  value: databaseHealth,
                ),
                _buildStatCard(
                  context,
                  title: 'Last Modification Date',
                  value: lastModificationDate,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context,
      {required String title, required String value}) {
    return ViContainer(
      margin: const EdgeInsets.all(ViSizes.defaultSpace / 2),
      padding: const EdgeInsets.all(ViSizes.defaultSpace / 2),
      borderRadius: BorderRadius.circular(20.0),
      child: ListTile(
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }
}
