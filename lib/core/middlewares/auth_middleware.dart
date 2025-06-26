import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

class AuthMiddleware extends GetMiddleware {
  Map<String, String> map = {
    "/baladiaInfo": "بيانات البلدية",
    "/nations": "انواع الجنسيات",
    "/dissents": "أنواع المخالفات",
    "/jobs": "أنواع الوظائف",
    "/badal_countries": "تصنيف الدول حسب فئات البدل",
    "/badal": "بدل الانتداب",
    "/emp_degrees": "سلم درجات الموظفين",
    "/emp_degrees_worker": "سلم درجات العمال",
    "/parts": "أنواع الأقسام",
    "/users": "المستخدمين",
    "/dowra_search": "الإستعلام عن الدورات",
    "/end_search": "الاستعلام عن إنهاء خدمة",
    "/entedab_search": "الإستعلام عن إنتداب",
    "/hasmiat_search": "الإستعلام عن حسميات",
    "/holiday_search": "الإستعلام عن إجازة",
    "/kashf_tepy_search": "الإستعلام عن كشف طبي",
    "/mobashra_search": "الإستعلام عن مباشرة",
    "/mokhalfat_search": "الإستعلام عن مخالفات",
    "/takleef_search": "الإستعلام عن خارح دوام",
    "/taeen_search": "الاستعلام عن قرار تعيين",
    "/Tarqea_search": "الاستعلام عن ترقية",
    "/passport_search": "الاستعلام عن إقرار جواز سفر",
    "/tafweed_search": "الاستعلام عن تفويض",
    "/employee_search": "الإستعلام عن موظف",
    "/eqrar_search": "الاستعلام عن إقرار",
    "/add_tafweed": "تفويض",
    "/add_dowra": "بيان دورة موظف",
    "/add_end": "إنهاء خدمة",
    "/add_entedab": "بيانات الإنتداب",
    "/add_eqrar": "إقرار موظف",
    "/add_hasmiat": "بيانات الحسميات",
    "/add_holiday": "بيانات الإجازات",
    "/add_kashf_tepy": "طلب كشف طبي",
    "/add_mobashra": "قرار مباشرة",
    "/add_mokhalfat": "بيانات المخالفات",
    "/add_taeen": "قرار تعيين",
    "/add_tarqea": "ترقية موظف",
    "/add_passport": "إقرار استلام جواز سفر",
    "/add_takleef": "بيانات خارح دوام",
    "/add_employee": "بيانات الوظائف الأساسية",
    "/mosaeer_salary": "مسير الرواتب",
  };

  @override
  RouteSettings? redirect(String? route) {
    // final controller = Get.find<UserController>();
    // if (controller.loginUserPermissions.isEmpty) {
    //   // المستخدم غير مسجل دخول
    //   return const RouteSettings(name: '/login');
    // }
    //
    // if (route != null &&
    //     !controller.checkPermission(map[route] ?? "", enter: true) &&
    //     route != "/home") {
    //   // الصفحة غير موجودة ضمن الصلاحيات
    //   return const RouteSettings(name: '/login');
    // }

    return null; // كل شيء تمام
  }
}
