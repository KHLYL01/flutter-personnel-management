import 'package:hijri/hijri_calendar.dart';

String nowHijriDate() {
  HijriCalendar date = HijriCalendar.now();
  return "${date.hYear.toString().padLeft(4, "0")}/${date.hMonth.toString().padLeft(2, "0")}/${date.hDay.toString().padLeft(2, "0")}";
}

String nowDate() {
  DateTime date = DateTime.now();
  return "${date.year.toString().padLeft(4, "0")}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
}
