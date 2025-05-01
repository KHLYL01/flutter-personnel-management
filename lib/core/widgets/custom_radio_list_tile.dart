import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final T value;
  final String title;
  final T? groupValue;
  final Function()? onTap;
  final void Function(T?)? onChanged;

  const CustomRadioListTile({
    Key? key,
    required this.value,
    required this.title,
    this.onChanged,
    this.groupValue,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call onTap when the tile is tapped
      child: Row(
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          Text(title),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}
