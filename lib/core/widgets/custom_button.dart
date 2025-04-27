import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color color; // remove
  final Color textColor; // remove
  final double borderRadius;
  final double height; // remove
  final double width; // remove
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.greyDark,
    this.textColor = Colors.white,
    this.borderRadius = 8.0,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: AppColors.greyDark,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ).paddingOnly(left: 8, right: 8, top: 8),
    );
  }
}
