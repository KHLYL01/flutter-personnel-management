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

DateTime hijriToGreg(String hijri) {
  List<String> str = hijri.split("/");

  int year = int.parse(str[0]);
  int month = int.parse(str[1]);
  int day = int.parse(str[2]);

  HijriCalendar hijriDate = HijriCalendar();
  return hijriDate.hijriToGregorian(year, month, day);
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

int dateCompare(String str1, String str2) {
  List<String> s1 = str1.split("/");
  List<String> s2 = str2.split("/");

  int years = int.parse(s1[0]) - int.parse(s2[0]);
  int months = int.parse(str1[1]) - int.parse(str2[1]);
  int days = int.parse(str1[2]) - int.parse(str2[2]);

  if (years > 0) {
    return 1;
  } else if (years < 0) {
    return 0;
  } else if (years == 0) {
    if (months > 0) {
      return 1;
    } else if (months < 0) {
      return 0;
    } else if (months == 0) {
      if (days >= 0) {
        return 1;
      } else {
        return 0;
      }
    }
  }
  return 1;
}

int daysbett(String str1, String str2) {
  int years = 0, days = 0, x1 = 0, x2 = 0;
  while (dateCompare(datePlusY(str1, 1), str2) == 0) {
    years = years + 1;
    str1 = datePlusY(str1, 1);
    //MessageBox.Show(years.ToString() + " " + str1);
  }

  List<String> s1 = str1.split("/");
  List<String> s2 = str2.split("/");

  x1 = int.parse(s1[1]) * 30 + int.parse(s1[2]);
  x2 = int.parse(s2[1]) * 30 + int.parse(s2[2]);
  //MessageBox.Show(x1.ToString() + " " + x2.ToString());
  if (int.parse(s1[0]) != int.parse(s2[0])) {
    days = years * 360 + (360 - (x1 - x2).abs());
  } else {
    days = years * 360 + (x1 - x2).abs();
  }
  return days;
}

String datePlusY(String str, int x) {
  List<String> s = str.split("/");

  int year = int.parse(s[0]) + x;
  int month = int.parse(s[1]);
  int day = int.parse(s[2]);
  return "$year/$month/$day";
}
