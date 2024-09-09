// ignore_for_file: library_private_types_in_public_api

import 'package:TiDo/utils/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/l10n/l10n.dart';
import '../../utils/Device/device_utility.dart';
import '../../utils/Helpers/helpers_functions.dart';
import '../../utils/Snackbar/snacbar_service.dart';
import '../styles/square_container_style.dart';
import 'chip/label_chip.dart';
import '../../utils/Constant/colors.dart';
import '../../utils/Constant/sizes.dart';
import '../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViLabeWidget extends StatefulWidget {
  const ViLabeWidget({
    super.key,
    this.categoryName,
    required this.tags,
    this.extraWidget = false,
    required this.onTagsUpdated,
  });

  final String? categoryName;
  final bool? extraWidget;
  final List<String> tags;
  final Function(List<String>) onTagsUpdated;

  @override
  _ViLabeWidgetState createState() => _ViLabeWidgetState();
}

class _ViLabeWidgetState extends State<ViLabeWidget> {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.tags);
  }

  void _updateTags(List<String> updatedTags) {
    if (updatedTags.length <= 3) {
      setState(() {
        _tags = updatedTags;
      });
      widget.onTagsUpdated(updatedTags);
    } else {
      ViSnackbar.showInfo(
          context, AppLocalizations.of(context)!.create_label_text);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onTagsUpdated(_tags);
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return ViSquareContainer(
      ontap: () {
        if (_tags.length < 3) {
          ViBottomSheet.showAddTagBottomSheet(
            context: context,
            tags: _tags,
            onTagsUpdated: _updateTags,
          );
          ViDeviceUtils.hideKeyboard(context);
        } else {
          ViSnackbar.showInfo(
              context, AppLocalizations.of(context)!.create_label_text);
        }
      },
      height: ViDeviceUtils.getScreenHeigth(context) * 0.2,
      width: double.infinity,
      icon: Iconsax.category_2,
      widget: Wrap(
        spacing: ViSizes.spaceBtwItems,
        runSpacing: ViSizes.spaceBtwItems / 3,
        children: _tags.isEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.all(ViSizes.md),
                  child: Text.rich(TextSpan(
                      text: "${AppLocalizations.of(context)!.label_text}\n",
                      style: dark
                          ? ViTextTheme.darkTextTheme.headlineMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold)
                          : ViTextTheme.ligthTextTheme.headlineMedium?.copyWith(
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!.selected,
                          style: dark
                              ? ViTextTheme.darkTextTheme.titleLarge
                                  ?.copyWith(color: AppColors.secondaryText)
                              : ViTextTheme.ligthTextTheme.titleLarge
                                  ?.copyWith(color: AppColors.secondaryText),
                        )
                      ])),
                )
              ]
            : _tags.map((tag) {
                return ViLabelChip(
                  tag: tag,
                  onTap: () => _removeTag(tag),
                  deleteButtonShow: true,
                );
              }).toList(),
      ),
    );
  }
}
