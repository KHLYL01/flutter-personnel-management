import 'package:flutter/material.dart';

// import 'package:get/instance_manager.dart';

extension CustomWidget on Widget {
  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget expanded({int? flex}) {
    return Expanded(
      flex: flex ?? 0,
      child: this,
    );
  }

  Widget padding(EdgeInsetsGeometry? padding) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: this,
    );
  }

  Widget paddingDirectional(EdgeInsetsDirectional? padding) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.all(8),
      child: this,
    );
  }

  Widget makeSafeArea() {
    return SafeArea(child: this);
  }

  Widget align({required AlignmentGeometry alignment}) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget fittedBox() {
    return FittedBox(
      child: this,
    );
  }

  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }

  Widget onDoubleTap(VoidCallback onDoubleTap) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: this,
    );
  }
  Widget scrollDirection(Axis scrollDirection ){
    return SingleChildScrollView(
      scrollDirection : scrollDirection,
      child : this
    );
  }

  Widget onLongPress(VoidCallback onLongPress) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: this,
    );
  }
}
