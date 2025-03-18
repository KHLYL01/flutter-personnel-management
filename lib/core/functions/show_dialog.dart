import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog({
  required String title,
  required String message,
  Widget? content,
  List<Widget>? actions,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  Get.defaultDialog(
    content: content,
    title: title,
    actions: actions,
    middleText: message,
    textConfirm: "OK",
    textCancel: "Cancel",
    confirmTextColor: Colors.white,
    onConfirm: () {
      if (onConfirm != null) {
        onConfirm();
      }
      Get.back();
    },
    onCancel: onCancel,
  );
}
