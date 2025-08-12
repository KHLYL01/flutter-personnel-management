import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final Uint8List image;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  TransformationController viewController = TransformationController();
  var initialControllerValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: InteractiveViewer(
          transformationController: viewController,
          minScale: 0.3,
          maxScale: 8,
          onInteractionStart: (details) {
            initialControllerValue = viewController.value;
          },
          onInteractionEnd: (details) {
            viewController.value = initialControllerValue;
          },
          child: Image.memory(widget.image).center().paddingOnly(bottom: 16),
        ),
      ),
    );
  }
}
