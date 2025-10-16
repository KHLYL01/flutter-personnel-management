import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final double customHeight;
  final bool obscureText;
  final Widget? prefixIcon;
  final double customWidth;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Function()? onTap;
  final bool enabled;
  final bool withLable;
  final int? maxLine;
  // final IconData? prefixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.prefixIcon,
    this.controller, // Ensure controller is passed
    required this.customHeight,
    required this.customWidth,
    this.hint,
    this.suffixIcon,
    this.onTap,
    this.enabled = true,
    this.withLable = true,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (withLable)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            color: AppColors.greyLight,
            constraints:
                BoxConstraints(maxHeight: customHeight, maxWidth: customWidth),
            width: customWidth,
            height: customHeight,
            child: TextField(
              cursorColor: AppColors.greyDark,
              onTap: onTap,
              controller: controller,
              enabled: enabled,
              maxLines: maxLine,
              style: const TextStyle(fontSize: 14, color: AppColors.greyDark),
              obscureText: obscureText,
              decoration: InputDecoration(
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(5),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greyDark, width: 2.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.greyLight, width: 2.0),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
