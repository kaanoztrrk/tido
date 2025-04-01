import 'package:TiDo/common/widget/item_tile/selected_files_tile.dart';
import 'package:TiDo/core/l10n/l10n.dart';
import 'package:TiDo/data/models/task_model/task_model.dart';
import 'package:TiDo/utils/constant/colors.dart';
import 'package:TiDo/utils/theme/custom_theme.dart/text_theme.dart';
import 'package:TiDo/views/mobile/common/empty_view/empty_view.dart';
import 'package:TiDo/views/mobile/task/task_detail/widget/attachment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/theme_bloc/theme_bloc.dart';
import '../../../../../blocs/theme_bloc/theme_state.dart';
import '../../../../../utils/Helpers/helpers_functions.dart';
import '../../../../../utils/constant/sizes.dart';

class TaskContentWidget extends StatelessWidget {
  const TaskContentWidget({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: state.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(ViSizes.cardRadiusLg * 2),
                topRight: Radius.circular(ViSizes.cardRadiusLg * 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(ViSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description section
                  _buildDescriptionSection(context),

                  // Files section
                  _buildFilesSection(context),

                  // Burada "links" ve "subtasks" bölümleri eklenebilir
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Description bölümünü render etmek için kullanılan metod
  Widget _buildDescriptionSection(BuildContext context) {
    if (task.description?.isEmpty ?? true) {
      return _buildEmptySection(
        context: context,
        title: AppLocalizations.of(context)!.description,
        emptyTitle: "No Description",
      );
    }
    return _buildContentSection(
      context: context,
      title: AppLocalizations.of(context)!.description,
      content: task.description,
    );
  }

  // Files bölümünü render etmek için kullanılan metod
  Widget _buildFilesSection(BuildContext context) {
    if (task.files?.isEmpty ?? true) {
      return _buildEmptySection(
        context: context,
        title: AppLocalizations.of(context)!.files,
        emptyTitle: "No Files",
      );
    }
    return _buildContentSection(
      context: context,
      title: AppLocalizations.of(context)!.files,
      content: task.files?.join(', '), // File list as comma separated string
      childBuilder: (files) => AttachmentWidget(files: files, task: task),
    );
  }

  // İçeriklerin bulunduğu bölümleri render eden metod
  Widget _buildContentSection({
    required BuildContext context,
    required String title,
    required String? content,
    Widget Function(List<String> files)? childBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ViTextTheme.darkTextTheme.titleSmall!
              .copyWith(color: AppColors.darkerGrey),
        ),
        SizedBox(height: ViSizes.spaceBtwItems),
        childBuilder == null
            ? Text(
                content ?? '',
                style: ViTextTheme.darkTextTheme.titleSmall!.copyWith(
                  color: AppColors.dark,
                  fontWeight: FontWeight.w500,
                ),
              )
            : childBuilder(content?.split(', ') ?? []),
        SizedBox(height: ViSizes.spaceBtwItems),
        Divider(color: AppColors.darkerGrey),
      ],
    );
  }

  // İçerik boşsa gösterilecek bölümü render eden metod
  Widget _buildEmptySection({
    required BuildContext context,
    required String title,
    required String emptyTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ViTextTheme.darkTextTheme.titleSmall!
              .copyWith(color: AppColors.darkerGrey),
        ),
        SizedBox(height: ViSizes.spaceBtwItems),
        Center(
          child: ViEmptyScreen(
            title: emptyTitle,
            subTitle: "",
          ),
        ),
      ],
    );
  }
}
