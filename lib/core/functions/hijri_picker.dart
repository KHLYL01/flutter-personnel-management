import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriPicker {
  final TextEditingController pickedDate;
  final TextEditingController? pickedGregorianDate;

  HijriCalendar hijriDate = HijriCalendar.now();

  HijriPicker(this.pickedDate, [this.pickedGregorianDate]);

  String _formatHijriDate(HijriCalendar date) {
    return "${date.hYear.toString().padLeft(4, "0")}/${date.hMonth.toString().padLeft(2, "0")}/${date.hDay.toString().padLeft(2, "0")}";
  }

  String _formatGregDate(DateTime date) {
    return "${date.year}/${date.month.toString().padLeft(2, "0")}/${date.day.toString().padLeft(2, "0")}";
  }

  void pickHijriDate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        width: 350,
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "اختر التاريخ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 75,
                itemBuilder: (context, index) {
                  final hijriYear = HijriCalendar.now().hYear - index;
                  return ListTile(
                    title: Text("$hijriYear هـ"),
                    onTap: () => _pickHijriMonth(context, hijriYear),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickHijriMonth(BuildContext context, int year) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        width: 350,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "اختر الشهر لسنة $year هـ",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) {
                  final month = index + 1;
                  return ListTile(
                    title: Text("شهر $month"),
                    onTap: () => _pickHijriDay(context, year, month),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickHijriDay(BuildContext context, int year, int month) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 300,
        width: 350,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "اختر اليوم ل $month/$year هـ",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 30, // Adjust this based on the month
                itemBuilder: (context, index) {
                  final day = index + 1;
                  return ListTile(
                    title: Text("اليوم $day"),
                    onTap: () {
                      hijriDate
                        ..hYear = year
                        ..hMonth = month
                        ..hDay = day;

                      final gregorianDate =
                          hijriDate.hijriToGregorian(year, month, day);

                      final formattedHijri = _formatHijriDate(hijriDate);
                      final formattedGregorian = _formatGregDate(gregorianDate);

                      pickedDate.text = formattedHijri;

                      if (pickedGregorianDate != null) {
                        pickedGregorianDate!.text = formattedGregorian;
                      }

                      // Close all bottom sheets
                      Get.back();
                      Get.back();
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickGregDate(BuildContext context) async {
    DateTime initialDate =
        DateTime.parse(pickedGregorianDate!.text.replaceAll("/", "-"));

    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(const Duration(days: 75 * 365)),
      lastDate: DateTime.now(),
    );

    if (dateTime != null) {
      pickedGregorianDate!.text = _formatGregDate(dateTime);

      List<String> hijri = hijriDate
          .gregorianToHijri(dateTime.year, dateTime.month, dateTime.day)
          .split("/");

      pickedDate.text = "${hijri[2]}/${hijri[1]}/${hijri[0]}";
    }
  }
}
