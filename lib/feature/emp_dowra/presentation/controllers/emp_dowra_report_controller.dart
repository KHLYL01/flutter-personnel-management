import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

class EmpDowraReportController extends GetxController {
  // todo ================================
  // قرار دورة
  Future<void> createQrarDowraReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String edara = bladiaInfoController.partBoss.text;

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار دورة");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        // orientation: pw.PageOrientation.landscape,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => [
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
                  "الموضوع: قرار دورة موظف",
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
              0: const pw.FixedColumnWidth(300),
              1: const pw.FixedColumnWidth(200),
              2: const pw.FixedColumnWidth(200),
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(400),
            },
            headers: [
              'بدل النقل',
              'الراتب',
              'المرتبة',
              'الوظيفة',
              'الاسم',
            ],
            data: [
              [
                "",
                "",
                "",
                "",
                "",
              ],
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Center(
              child: pw.Text(
            "قرار إداري رقم (70) وتاريخ 1440/1/13",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          )),
          pw.SizedBox(height: 10),
          pw.Text(
            """إن رئيس بلدية محافظة تيماء
بناء على الصلاحيات الممنوحة له و نظرا لالتحاق الموضح اسمه و بياناته أعلاه بدوره تدريبية لمدة (3) أيام / يوم خلال الفترة من 1440/02/05 إلى 1440/02/08 .
واستنادا للمواد (34/26) و (34/26) من لائحه التدريب يقرر ما يلي:
1:- يصرف للموظف اسمه أعلاه (100%) من راتبه الشهري خلال فتره إلتحاقه بالدورة التدريبية من 1440/02/05 ألى 1440/02/08 ولمدة (3) يوما
2:- على الجهة المختصة اعتماد موجبه و انفاذه
""",
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
            "والله الموفق ....",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          )),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    "ص للموارد البشرية",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "ص للصادر",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 10, lineSpacing: 10),
                  ),
                ],
              ),
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
          ),
        ],
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
    //   filename: 'قرار حسم.pdf',
    // );
  }

  // بيان دورة
  Future<void> createBeanDowraReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'بيان دورة');

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            decoration: const pw.BoxDecoration(
              border: pw.Border.fromBorderSide(pw.BorderSide.none),
            ),
            child: pw.Row(
              children: [
                pw.Text(
                  """المملكة العربية السعودية
وزارة الشئون البلدية و القروية
إدارة الموارد البشرية
""",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 8,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(width: 210),
                pw.Text(
                  "بسم الله الرحمن الرحيم",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 10,
                    lineSpacing: 10,
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
              0: const pw.FixedColumnWidth(200),
              1: const pw.FixedColumnWidth(200),
              2: const pw.FixedColumnWidth(300),
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(250),
              6: const pw.FixedColumnWidth(300),
              7: const pw.FixedColumnWidth(250),
              8: const pw.FixedColumnWidth(250),
              9: const pw.FixedColumnWidth(300),
              10: const pw.FixedColumnWidth(400),
            },
            headers: [
              'التوقيع',
              'المجموع',
              'مقدار بدل النقل',
              'مقدار بدل الإنتداب',
              'عدد أيام الإنتداب',
              'مقدار',
              'بدل النقل',
              'الراتب',
              'المرتبة',
              'المسمى الوظيفي',
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
                "",
                "",
                "",
              ],
            ],
          ),

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
              0: const pw.FixedColumnWidth(3050),
            },
            headers: ['المجموع:   10000'],
            data: [],
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    "الموظف المختص",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "مدير النظام",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    "مدير ادارة الموارد البشرية",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "فهد نايف العنزي",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    "المدقق",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "حمدان هجيج العنزي",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    "مدير قسم الشئون المالية",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "عبدالله فهد العيادي",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                ],
              ),
              // pw.Column(
              //   children: [
              //     pw.Text(
              //       "رئيس بلدية مجافظة تيماء",
              //       textAlign: pw.TextAlign.center,
              //       style: pw.TextStyle(
              //           font: arabicFont, fontSize: 8, lineSpacing: 10),
              //     ),
              //     pw.SizedBox(height: 20),
              //     pw.Text(
              //       "المهندس / حسن بن عبدالرحيم الغبان",
              //       textAlign: pw.TextAlign.center,
              //       style: pw.TextStyle(
              //           font: arabicFont, fontSize: 10, lineSpacing: 10),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
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
    //   filename: 'مسير خارج دوام.pdf',
    // );
  }
}
