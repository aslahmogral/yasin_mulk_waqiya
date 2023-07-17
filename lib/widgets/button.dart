import 'package:flutter/material.dart';
import 'package:yasin_mulk_waqiya/utils/colors.dart';

class QButton extends StatelessWidget {
  final buttonSize;
  final VoidCallback? onPressed;
  final child;
  const QButton({super.key, this.buttonSize = 100.0, required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        child: child,
        width: buttonSize,
        height: buttonSize,
        decoration: new BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
