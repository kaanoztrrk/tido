import 'package:flutter/material.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';
import 'package:tido/utils/Helpers/helpers_functions.dart';

import '../../../utils/Theme/custom_theme.dart/text_theme.dart';

class ViSwiperButton extends StatefulWidget {
  const ViSwiperButton({
    super.key,
    this.onSwipe,
    this.width,
    this.height,
    this.text,
    required this.isCompleted,
  });

  final VoidCallback? onSwipe;
  final double? width;
  final double? height;
  final String? text;
  final bool isCompleted;

  @override
  _ViSwiperButtonState createState() => _ViSwiperButtonState();
}

class _ViSwiperButtonState extends State<ViSwiperButton> {
  double _dragPosition = 0.0;

  bool _enabled = true;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_enabled) return;

    setState(() {
      _dragPosition += details.primaryDelta!;
      final maxDrag =
          (widget.width ?? MediaQuery.of(context).size.width * 0.65) - 80;
      if (_dragPosition < 0) {
        _dragPosition = 0;
      } else if (_dragPosition >= maxDrag) {
        _dragPosition = maxDrag;
        _enabled = false;
        widget.onSwipe!();

        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _dragPosition = 0;
          });
        });
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!widget.isCompleted && _enabled) {
      setState(() {
        _dragPosition = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark = ViHelpersFunctions.isDarkMode(context);
    return Center(
      child: ViContainer(
        width: widget.width ?? MediaQuery.of(context).size.width * 0.65,
        bgColor: widget.isCompleted
            ? AppColors.darkerGrey
            : AppColors.lightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(ViSizes.borderRadiusLg * 2),
        height: widget.height ?? 70.0,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.isCompleted
                      ? "Completed"
                      : (widget.text ?? "Drag to mark done"),
                  style: dark
                      ? ViTextTheme.darkTextTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600)
                      : ViTextTheme.ligthTextTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                ),
                widget.isCompleted
                    ? const SizedBox(width: 20)
                    : const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.double_arrow_rounded,
                          color: AppColors.lightGrey,
                        ),
                      )
              ],
            ),
            Positioned(
              left: _dragPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: _onHorizontalDragUpdate,
                onHorizontalDragEnd: _onHorizontalDragEnd,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isCompleted
                          ? Colors.green
                          : Theme.of(context).primaryColor),
                  child: Icon(
                    widget.isCompleted
                        ? Icons.done
                        : Icons.double_arrow_rounded,
                    color: widget.isCompleted ? Colors.white : AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
