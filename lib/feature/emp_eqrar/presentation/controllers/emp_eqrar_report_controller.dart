import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/emp_eqrar/presentation/controllers/emp_eqrar_controller.dart';

import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

class EmpEqrarReportController extends GetxController {
  // اقرار موظف
  Future<void> createEqrarReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpEqrarController controller = Get.find<EmpEqrarController>();
    String eqrarQrarDate = controller.decisionDate.text;
    String eqrarQrarName = controller.decisionName.text;
    String eqrarQrarPlace = controller.decisionPlace.text;
    String eqrarKhetabNumber = controller.letterNumber.text;
    String eqrarKhetabDate = controller.letterDate.text;
    String eqrarKhetabName = controller.letterName.text;

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "اقرار موظف");

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
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "[ إقرار في $eqrarQrarDate هـ ]",
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 14,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Text(
                  """بناء على خطاب  $eqrarKhetabName                                                               رقم $eqrarKhetabNumber 
في $eqrarKhetabDate        هـ  بشأن حضوري $eqrarQrarPlace                                               لديهم لوجود معاملة تخصني .
لذا فإنني اقر باطلاعي على الخطاب المذكور حسب خطاب المشار إليه...""",
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
                    "والله الموفق...",
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
                    pw.Text(
                      """الاسم: $eqrarQrarName             
التوقيع:                                 """,
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.Divider(
                  height: 60,
                  thickness: 2,
                  color: PdfColors.black,
                ),
                pw.Text(
                  """$eqrarKhetabName                                                                                                            الموقر
السلم عليكم و رحمة الله و بركاته : -
إشارة لخطابكم الموضح رقمه و تاريخه أعلاه بخصوص مراجعة الموضح اسمه عليه . نفيدكم انه تم إبلغ المذكور حسب القرار الموضح أعله نأمل بعد الطلع الحاطة ..""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Center(
                  child: pw.Text(
                    "و السلام عليكم و رحمة الله و بركاته ...",
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """الرئيس $name
                      
$bossName""",
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
    //   filename: 'قرار حسم.pdf',
    // );
  }
}
