import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_button.dart';
import 'package:personnel_management/core/widgets/custom_text_feild.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();
    controller.findAll();
    return Scaffold(
      body: Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text(
              "تسجيل الدخول",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "اسم المستخدم",
              controller: controller.name,
              obscureText: true,
              maxLine: 1,
              customHeight: 30,
              customWidth: 250,
            ),
            CustomTextField(
              label: "كلمة المرور",
              controller: controller.pass,
              obscureText: true,
              maxLine: 1,
              customHeight: 30,
              customWidth: 250,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: "تسجيل الدخول",
              onPressed: () => controller.login(),
              height: 30,
              width: 120,
            ),
          ],
        ),
      ).center(),
    );
  }
}
