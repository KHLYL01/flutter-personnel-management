import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/constants/app_static.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final controller = Get.find<UserController>();
    if (controller.loginUserPermissions.isEmpty && !controller.isAdmin) {
      // المستخدم غير مسجل دخول
      return const RouteSettings(name: '/login');
    }

    if (route != null &&
        !controller.checkPermission(AppStatic.map[route] ?? "", enter: true) &&
        route != "/home") {
      // الصفحة غير موجودة ضمن الصلاحيات
      return const RouteSettings(name: '/login');
    }

    return null; // كل شيء تمام
  }

  //for develop mode
  // @override
  // RouteSettings? redirect(String? route) {
  //   return null; // كل شيء تمام
  // }
}
