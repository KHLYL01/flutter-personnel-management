import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/base_screen.dart';
import 'package:personnel_management/core/widgets/custom_button.dart';
import 'package:personnel_management/core/widgets/custom_text_feild.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseScreen(
      widget: Container(),
    ));
  }
}
