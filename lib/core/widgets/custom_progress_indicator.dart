import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SpinKitFadingCube(
          color: Colors.grey,
          size: 64,
        ),
        const SizedBox(height: 32),
        Text(
          "Loading...".tr,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    ).center();
  }
}
