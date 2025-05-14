import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmpMokhalfatReportController extends GetxController {
  // بيان مخالفة
  Future<void> createBeanMokhalfatReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "بيان مخالفة");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
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
                        'إدارة الموارد البشرية',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'الموضوع: بيان مخالفة',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
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
                      fontSize: 11,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.grey600,
                    ),
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                    ),
                    cellAlignment: pw.Alignment.center,
                    headerAlignment: pw.Alignment.center,
                    columnWidths: {
                      0: const pw.FixedColumnWidth(250),
                      1: const pw.FixedColumnWidth(250),
                      2: const pw.FixedColumnWidth(250),
                      3: const pw.FixedColumnWidth(250),
                      4: const pw.FixedColumnWidth(250),
                      5: const pw.FixedColumnWidth(250),
                      6: const pw.FixedColumnWidth(300),
                      7: const pw.FixedColumnWidth(300),
                    },
                    headers: [
                      'أيام الجزاء',
                      'الفترة إلى',
                      'الفترة من',
                      'النوع',
                      'المرتبة',
                      'مسمى الوظيفة',
                      'رقم السجل المدني',
                      'الاسم',
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
                      ]
                    ]),
                pw.SizedBox(height: 30),

                // نص ختامي
                pw.Text(
                  """ان رئيس بلدية محافظة تيماء .
بناءعلى خطاب الدارة القانونية رقم 4300640241 وبعد التوصيات المنتضمنة عقوبة الحسم يومين من راتب الموظف ابراهيم صالح الصعب تقرر مايلي :
1- حسم يومين من راتب الموظف المذكور
2- يبلغ قرارنا من يلزم لنفاذه""",
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 11, lineSpacing: 10),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """رئيس بلدية محافظة تيماء

المهندس/حسن بن عبدالرحيم الغبان""",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          font: arabicFont, fontSize: 11, lineSpacing: 10),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'بيان مخالفة.pdf',
    // );
  }
}
