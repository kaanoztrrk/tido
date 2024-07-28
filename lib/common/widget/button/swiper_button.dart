import 'package:flutter/material.dart';
import 'package:tido/common/styles/container_style.dart';
import 'package:tido/utils/Constant/colors.dart';
import 'package:tido/utils/Constant/sizes.dart';

class ViSwiperButton extends StatefulWidget {
  const ViSwiperButton({
    super.key,
    this.onSwipe,
    this.width,
    this.height,
    this.text,
  });

  final VoidCallback? onSwipe;
  final double? width;
  final double? height;
  final String? text;

  @override
  _ViSwiperButtonState createState() => _ViSwiperButtonState();
}

class _ViSwiperButtonState extends State<ViSwiperButton> {
  double _dragPosition = 0.0;
  bool _isCompleted = false;
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
        _isCompleted = true;
        _enabled = false;
        widget.onSwipe!();

        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _dragPosition = 0;
          });
        });
      } else {
        _isCompleted = false;
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (!_isCompleted && _enabled) {
      setState(() {
        _dragPosition = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ViContainer(
        width: widget.width ?? MediaQuery.of(context).size.width * 0.65,
        bgColor: _isCompleted
            ? AppColors.success
            : AppColors.ligthGrey.withOpacity(0.5),
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
                  _isCompleted
                      ? "Completed"
                      : (widget.text ?? "Drag to mark done"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                _isCompleted
                    ? const SizedBox(width: 20)
                    : const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.double_arrow_rounded,
                          color: AppColors.ligthGrey,
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
                    color: _isCompleted ? Colors.green : AppColors.primary,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: _isCompleted ? Colors.white : AppColors.white,
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
