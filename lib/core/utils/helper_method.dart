import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../feature/users/presentation/controllers/user_controller.dart';
import '../functions/alert_dialog.dart';
import '../widgets/base_screen.dart';

String nowHijriDate() {
  HijriCalendar date = HijriCalendar.now();
  return "${date.hYear.toString().padLeft(4, "0")}/${date.hMonth.toString().padLeft(2, "0")}/${date.hDay.toString().padLeft(2, "0")}";
}

String nowDate() {
  DateTime date = DateTime.now();
  return "${date.year.toString().padLeft(4, "0")}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
}

DateTime convertToDateTime(String hijriDate) {
  List<String> list = hijriDate.split("/");
  int year = int.parse(list[0]);
  int month = int.parse(list[1]);
  int day = int.parse(list[2]);

  return HijriCalendar().hijriToGregorian(year, month, day);
}

bool checkSavePermission() {
  if (!Get.find<UserController>()
      .checkPermission(Get.find<BaseController>().page.value, save: true)) {
    alertDialog(
      title: 'تنبيه',
      middleText: "       ليس لديك صلاحية الإضافة       ",
      withoutButton: true,
      onPressedConfirm: () {
        Get.back();
      },
    );
    return false;
  }
  return true;
}

bool checkUpdatePermission() {
  if (!Get.find<UserController>()
      .checkPermission(Get.find<BaseController>().page.value, update: true)) {
    alertDialog(
      title: 'تنبيه',
      middleText: "       ليس لديك صلاحية التعديل       ",
      withoutButton: true,
      onPressedConfirm: () {
        Get.back();
      },
    );
    return false;
  }
  return true;
}

bool checkDeletePermission() {
  if (!Get.find<UserController>()
      .checkPermission(Get.find<BaseController>().page.value, delete: true)) {
    alertDialog(
      title: 'تنبيه',
      middleText: "       ليس لديك صلاحية الحذف       ",
      withoutButton: true,
      onPressedConfirm: () {
        Get.back();
      },
    );
    return false;
  }
  return true;
}
