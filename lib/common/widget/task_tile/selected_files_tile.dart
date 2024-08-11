import 'package:flutter/material.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/common/widget/button/ratio_button.dart';
import 'package:tido/utils/Constant/sizes.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class SelectedFilesTile extends StatefulWidget {
  const SelectedFilesTile({
    super.key,
    this.leading,
    this.title,
    this.isSelected = false,
    this.onSelected,
  });

  final Widget? leading;
  final String? title;
  final bool isSelected;
  final void Function(bool)? onSelected;

  @override
  _SelectedFilesTileState createState() => _SelectedFilesTileState();
}

class _SelectedFilesTileState extends State<SelectedFilesTile> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return GestureDetector(
      onLongPress: () {
        // Uzun basma ile seçme modunu başlat
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onSelected!(_isSelected);
      },
      child: ViContainer(
        margin: const EdgeInsets.all(ViSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: (_isSelected)
              ? Border.all(width: 3, color: Theme.of(context).primaryColor)
              : null,
        ),
        height: 100,
        child: Row(
          children: [
            const SizedBox(width: ViSizes.md),
            ViRotioButton(
              bgColor: Theme.of(context).primaryColor,
              child: widget.leading,
            ),
            const SizedBox(width: ViSizes.md),
            Text(
              widget.title ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: dark
                  ? ViTextTheme.darkTextTheme.titleMedium
                      ?.copyWith(color: AppColors.white)
                  : ViTextTheme.ligthTextTheme.titleMedium
                      ?.copyWith(color: AppColors.primaryText),
            ),
          ],
        ),
      ),
    );
  }
}
