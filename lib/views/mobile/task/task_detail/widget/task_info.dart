import 'package:TiDo/core/l10n/l10n.dart';
import 'package:TiDo/utils/constant/colors.dart';
import 'package:TiDo/utils/constant/sizes.dart';
import 'package:TiDo/utils/theme/custom_theme.dart/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../../utils/Helpers/helpers_functions.dart';

class TaskInfoWidget extends StatelessWidget {
  final String creator;
  final String endDate;
  final String time;
  final String priority;

  const TaskInfoWidget({
    Key? key,
    required this.creator,
    required this.endDate,
    required this.time,
    required this.priority,
  }) : super(key: key);

  Color _getPriorityColor() {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(AppLocalizations.of(context)!.creator, creator, context),
        _buildInfoRow(AppLocalizations.of(context)!.due_time, endDate, context),
        _buildInfoRow(AppLocalizations.of(context)!.time, time, context),
        _buildPriority(context),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                        color: dark
                            ? Colors.white
                            : Colors.black87.withOpacity(0.75),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: ViSizes.imageThumbSize / 10)
                  ],
                ),
              ),
              Spacer(),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value ?? "",
                      style: ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                        color: dark
                            ? Colors.white
                            : Colors.black87.withOpacity(0.75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: ViSizes.imageThumbSize / 10)
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriority(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.priority,
                    style: ViTextTheme.darkTextTheme.titleMedium?.copyWith(
                      color: dark
                          ? Colors.white
                          : Colors.black87.withOpacity(0.75),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: ViSizes.imageThumbSize / 10)
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      priority,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
