import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuEntry<String>> items;
  final ValueChanged<String> onSelected;
  final String buttonText;

  const CustomPopupMenuButton({
    Key? key,
    required this.items,
    required this.onSelected,
    this.buttonText = 'Menu',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => items,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(buttonText),
      ),
    );
  }
}