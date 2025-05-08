import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmpHasmiatReportController extends GetxController {
  // قرار حسم
  Future<void> createQrarHasmiatReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document();

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        // orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // للغة العربية
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // عنوان التقرير
                pw.Header(
                  level: 0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border.fromBorderSide(pw.BorderSide.none),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "إدارة الموارد البشرية",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "الموضوع: قرار حسم",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Center(
                  child: pw.Text(
                    "قرار حسم الغياب و التأخير",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                // جدول البيانات
                pw.TableHelper.fromTextArray(
                  context: context,
                  border: pw.TableBorder.all(color: PdfColors.grey400),
                  tableDirection: pw.TextDirection.rtl,
                  headerStyle: pw.TextStyle(
                    font: arabicFont,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 6,
                  ),
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey600,
                  ),
                  cellStyle: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 6,
                  ),
                  cellAlignment: pw.Alignment.center,
                  headerAlignment: pw.Alignment.center,
                  columnWidths: {
                    0: const pw.FixedColumnWidth(250),
                    1: const pw.FixedColumnWidth(250),
                    2: const pw.FixedColumnWidth(300),
                    3: const pw.FixedColumnWidth(300),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(250),
                    6: const pw.FixedColumnWidth(200),
                    7: const pw.FixedColumnWidth(200),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(400),
                    10: const pw.FixedColumnWidth(200),
                  },
                  headers: [
                    'ملاحظات',
                    'مقدار الحسم بالريال',
                    'مدة الغياب و التأخير يوم',
                    'مدة الغياب و التأخير س',
                    'مدة الغياب و التأخير د',
                    'بدل النقل',
                    'الراتب',
                    'المرتبة',
                    'الوظيفة',
                    'الاسم',
                    ' م ',
                  ],
                  data: [
                    [
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                      "",
                    ],
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """إن رئيس بلدية محافظة تيماء
بناء على خطاب مدير عام شؤون الموظفين بالوزارة رقم )2962( و تاريخ 1435/02/14 هـ و المتضمنة تأخر و
تغيب الموظف الموضح اسمه أعلاه خلال خلاصة لشهر سبتمبر عام 2024 هو استنادا للمادة رقم )21( من نظام
الخدمة المدنية فقد تقرر ما يلي:
1:- يحسم من راتب الموظف الموضح اسمه أعله راتب و بدلت مدة الغياب و التأخير المحددة أمام اسمه من راتب شهر اكتوبر لعام 2024
2:- يبلغ قرارنا هذا من يلزم لنفاذه .""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "و السلام عليكم و رحمه الله و بركاته ,,,,,",
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "رئيس بلدية مجافظة تيماء",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              font: arabicFont, fontSize: 8, lineSpacing: 10),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          "المهندس / حسن بن عبدالرحيم الغبان",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              font: arabicFont, fontSize: 10, lineSpacing: 10),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
    // حفظ أو مشاركة الملف
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'قرار حسم.pdf',
    );
  }
}
