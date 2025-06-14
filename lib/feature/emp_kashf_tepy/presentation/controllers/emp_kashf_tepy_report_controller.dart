import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_controller.dart';

import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

class EmpKashfTepyReportController extends GetxController {
  // طلب كشف طبي
  Future<void> createOrderKashfTepyReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossAssistant = bladiaInfoController.bossAssistant.text;
    String amana = bladiaInfoController.amana.text;
    String city = name.split(" ").last;

    EmpKashfTepyController controller = Get.find<EmpKashfTepyController>();
    String empName = controller.empName.text;
    String cardId = controller.cardId.text;

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "طلب كشف طبي");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            decoration: const pw.BoxDecoration(
              border: pw.Border.fromBorderSide(pw.BorderSide.none),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  """أمانة $amana
                  
                  
إدارة الموارد البشرية""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'الموضوع: طلب كشف طبي',
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
          pw.Text(
            "المكرم مدير مستشفى مستشفى محافظة $city",
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
          ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Text(
              "السلام عليكم ورحمة الله وبركاته،",
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 9, lineSpacing: 10),
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            "نأمل إجراء الكشف الطبى على -: موظف $empName",
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
          ),
          pw.SizedBox(height: 10),
          pw.Center(
            child: pw.Text(
              "رقم السجل المدني: $cardId",
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            """وإفادتنا بالنتيجة علما بأنه :
   قائم بالعمل حتى تاريخه""",
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                """مساعد رئيس $name
                
$bossAssistant""",
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                    font: arabicFont, fontSize: 11, lineSpacing: 10),
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
    //   filename: 'بيان مخالفة.pdf',
    // );
  }
}
