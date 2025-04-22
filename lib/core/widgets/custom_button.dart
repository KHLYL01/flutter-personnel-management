import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_colors.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

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
      ).paddingAll(8),
    );
    //   Container(
    //   width: width,
    //   height: height,
    //   margin: const EdgeInsets.all(4),
    //   padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    //   decoration: BoxDecoration(
    //     color: color,
    //     borderRadius: BorderRadius.circular(borderRadius),
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Colors.black26,
    //         blurRadius: 4.0,
    //         spreadRadius: 1.0,
    //         offset: Offset(2.0, 2.0),
    //       ),
    //     ],
    //   ),
    //   child: Center(
    //     child: Text(
    //       text,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         color: textColor,
    //         fontSize: 18,
    //       ),
    //     ),
    //   ),
    // ).onTap(onPressed);
  }
}
