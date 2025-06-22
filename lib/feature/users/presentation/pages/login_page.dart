import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_colors.dart';
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.greyDark.withOpacity(0.1), AppColors.greyDark],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 380,
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyDark.withOpacity(0.1),
                    spreadRadius: 8,
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Section
                  const Column(
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        size: 80,
                        color: AppColors.greyDark,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "نظام الموارد البشرية",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  CustomTextField(
                    label: "اسم المستخدم",
                    controller: controller.name,
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: AppColors.blackDark,
                    ),
                    obscureText: true,
                    maxLine: 1,
                    customHeight: 50,
                    customWidth: double.infinity,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: "كلمة المرور",
                    controller: controller.pass,
                    obscureText: true,
                    maxLine: 1,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.blackDark,
                    ),
                    customHeight: 50,
                    customWidth: double.infinity,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "تسجيل الدخول",
                    onPressed: () => controller.login(),
                    height: 50,
                    width: double.infinity,
                    color: AppColors.greyDark,
                    textColor: Colors.white,
                    borderRadius: 12,
                  ),

                  // حقوق النشر
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      "جميع الحقوق محفوظة - حوران الشامل التجارية 2025 ©",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.greyDark.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
