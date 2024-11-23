// ignore_for_file: library_private_types_in_public_api

import 'package:TiDo/utils/Device/device_utility.dart';
import 'package:flutter/material.dart';

import '../../../utils/Constant/colors.dart';
import '../../../utils/Constant/sizes.dart';
import '../../../utils/Helpers/helpers_functions.dart';
import '../../../utils/Theme/custom_theme.dart/text_theme.dart';
import '../../styles/container_style.dart';

class SelectedFilesTile extends StatefulWidget {
  const SelectedFilesTile({
    super.key,
    this.leading,
    this.title,
    this.isSelected = false,
    this.onSelected,
    this.enableLongPress = false,
  });

  final Widget? leading;
  final String? title;
  final bool isSelected;
  final void Function(bool)? onSelected;
  final bool enableLongPress;

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
      onTap: () {
        if (widget.leading != null) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: InteractiveViewer(
                  child: widget.leading!,
                ),
              );
            },
          );
        }
      },
      onLongPress: widget.enableLongPress
          ? () {
              setState(() {
                _isSelected = !_isSelected;
              });
              widget.onSelected?.call(_isSelected);
            }
          : null,
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
            ViContainer(
              width: ViDeviceUtils.getScreenHeigth(context) * 0.075,
              height: ViDeviceUtils.getScreenHeigth(context) * 0.075,
              child: widget.leading,
            ),
            const SizedBox(width: ViSizes.md),
            Expanded(
              child: Text(
                widget.title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: dark
                    ? ViTextTheme.darkTextTheme.titleMedium
                        ?.copyWith(color: AppColors.white)
                    : ViTextTheme.ligthTextTheme.titleMedium
                        ?.copyWith(color: AppColors.primaryText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
