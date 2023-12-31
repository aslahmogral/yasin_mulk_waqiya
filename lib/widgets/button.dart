import 'package:flutter/material.dart';
import 'package:daily_quran/utils/colors.dart';

class QButton extends StatelessWidget {
  final buttonSize;
  final VoidCallback? onPressed;
  final child;
  final buttonColor;
  const QButton(
      {super.key,
      this.buttonSize = 100.0,
      required this.onPressed,
      this.child,
      this.buttonColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: child,
        width: buttonSize,
        height: buttonSize,
        decoration: new BoxDecoration(
          border: Border.all(width: 1, color: AppColors.seconderyColor),
          color: buttonColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
