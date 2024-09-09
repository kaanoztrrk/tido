import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../data/models/category_model/category_model.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../styles/container_style.dart';

class ViCategoryChip extends StatelessWidget {
  const ViCategoryChip({
    super.key,
    required this.category,
    required this.state,
  });

  final CategoryModel category;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<HomeBloc>(context).add(const CategoryUpdateTab(0));
      },
      onLongPress: () {
        ViBottomSheet.showEditCategoryBottomSheet(
          context,
          onEdit: () {
            ViBottomSheet.onEditCategoryBottomSheet(
              context: context,
              oldCategory: category,
              bloc: BlocProvider.of<HomeBloc>(context),
            );
          },
          onDelete: () {
            BlocProvider.of<HomeBloc>(context)
                .add(DeleteCategoryEvent(categoryModel: category));
            Navigator.pop(context);
          },
        );
      },
      child: ViContainer(
        // ignore: unrelated_type_equality_checks
        bgColor: Theme.of(context).primaryColor,
        margin: const EdgeInsets.only(right: ViSizes.sm),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        borderRadius: BorderRadius.circular(50),
        child: Center(
          child: Text(
            "${category.name} (${state.getTaskCount(0)})",
            style: state.taskCategoryIndex == 0
                ? ViTextTheme.darkTextTheme.titleSmall
                : ViTextTheme.ligthTextTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
