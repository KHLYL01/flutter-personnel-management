import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({super.key, required this.text, required this.onTap});
  final Function() onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text).onTap(onTap),
    );
  }
}
