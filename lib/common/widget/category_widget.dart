import 'package:TiDo/blocs/home_bloc/home_bloc.dart';
import 'package:TiDo/data/models/category_model/category_model.dart';
import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../blocs/home_bloc/home_state.dart';
import '../../core/l10n/l10n.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Snackbar/snacbar_service.dart';
import '../styles/square_container_style.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViCategoryWidget extends StatefulWidget {
  const ViCategoryWidget({
    super.key,
    this.categoryName,
    required this.categories, // Kategoriler için güncellendi
    this.extraWidget = false,
    required this.onCategoriesUpdated,
  });

  final String? categoryName;
  final bool? extraWidget;
  final List<CategoryModel> categories; // Kategoriler
  final Function(List<CategoryModel>) onCategoriesUpdated;

  @override
  _ViCategoryWidgetState createState() => _ViCategoryWidgetState();
}

class _ViCategoryWidgetState extends State<ViCategoryWidget> {
  late List<CategoryModel> _categories;
  String? _selectedCategory; // Seçilen kategori adını tutacak değişken

  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.categories);
    if (_categories.isNotEmpty) {
      _selectedCategory =
          _categories.last.name; // İlk kategoriyi seçili olarak ayarlayın
    }
  }

  void _updateCategories(List<CategoryModel> updatedCategories) {
    setState(() {
      _categories = updatedCategories;
      _selectedCategory = updatedCategories.isNotEmpty
          ? updatedCategories.last.name // Seçilen kategori adını güncelle
          : null;
    });
    widget.onCategoriesUpdated(updatedCategories);
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return ViSquareContainer(
      ontap: () {},
      height: ViDeviceUtils.getScreenHeigth(context) * 0.2,
      width: double.infinity,
      icon: Iconsax.category_2,
      widget: Wrap(
        spacing: ViSizes.spaceBtwItems,
        runSpacing: ViSizes.spaceBtwItems / 3,
        children: [
          Padding(
            padding: const EdgeInsets.all(ViSizes.md),
            child: Text.rich(
              TextSpan(
                text: _selectedCategory != null
                    ? "$_selectedCategory\n"
                    : "${AppLocalizations.of(context)!.category_text}\n",
                style: dark
                    ? ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.bold)
                    : ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: _selectedCategory != null
                        ? AppLocalizations.of(context)!.category_text
                        : AppLocalizations.of(context)!.selected,
                    style: dark
                        ? ViTextTheme.darkTextTheme.titleLarge
                            ?.copyWith(color: AppColors.secondaryText)
                        : ViTextTheme.ligthTextTheme.titleLarge
                            ?.copyWith(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
