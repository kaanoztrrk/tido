import 'package:TiDo/blocs/home_bloc/home_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../data/models/category_model/category_model.dart';
import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../styles/container_style.dart';
import '../button/ratio_button.dart';

class ViLabelChip extends StatelessWidget {
  const ViLabelChip({
    super.key,
    required this.category, // CategoryModel kullanılacak
    this.onTap,
    this.deleteButtonShow = false,
  });

  final CategoryModel category; // CategoryModel'i aldık
  final Function()? onTap;
  final bool deleteButtonShow;

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          ViContainer(
            bgColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg),
            padding: const EdgeInsets.symmetric(
              horizontal: ViSizes.lg,
              vertical: ViSizes.sm,
            ),
            child: Text(
              category.name, // CategoryModel'den name özelliği alınıyor
              style: dark
                  ? ViTextTheme.darkTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.white)
                  : ViTextTheme.ligthTextTheme.bodyLarge
                      ?.copyWith(color: AppColors.white),
            ),
          ),
          if (deleteButtonShow == true)
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context).add(
                      DeleteCategoryEvent(categoryModel: category),
                    );
                  },
                  child: ViRotioButton(
                    size: 15,
                    bgColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      CupertinoIcons.clear,
                      color: AppColors.white,
                      size: 10,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
