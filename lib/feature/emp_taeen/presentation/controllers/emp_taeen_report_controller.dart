import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_controller.dart';

import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

class EmpTaeenReportController extends GetxController {
  // قرار تعيين
  Future<void> createQrarTaeenReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String emp = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmpTaeenController controller = Get.find<EmpTaeenController>();
    String empName = controller.empName.text;
    String jobName = controller.jobName.text;
    String jobNumber = controller.jobNumber.text;
    String mrtaba = controller.mrtaba.text;
    String draga = controller.draga.text;
    String salary = controller.salary.text;
    String nqalBadal = controller.nqalBadal.text;
    String empPart = controller.empPart.text;
    String birthDate = controller.birthDate.text;
    String gender = controller.gender.value;
    String state = controller.state.value;
    String socialNumber = controller.socialNumber.text;
    String khetabId = controller.khetabId.text;
    String khetabName = controller.khetabName.text;
    String khetabDate = controller.khetabDate.text;
    String mKhetabDate = controller.mKhetabDate.text;
    String mDay = controller.mDay.value;

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار تعيين");

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
              children: [
                pw.Text(
                  "إدارة الموارد البشرية",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "الموضوع: قرار تعيين",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
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
              "قرار تعيين و مباشرة على بند الأجور",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: arabicFont,
                fontSize: 7,
                lineSpacing: 10,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1, color: PdfColors.black),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      """الاسم الرباعي: $empName
الحالة الإجتماعية: $state""",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 7,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      """تاريخ الميلاد: $birthDate           
الجنس: $gender           """,
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 7,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  "رقم التأمين الإجتماعي: $socialNumber",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  "رقم اشتراك الجهة في المؤسسة العامة للتأمينات الإجتماعية(00921609728000) .",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Divider(
                  height: 20,
                  thickness: 2,
                  color: PdfColors.black,
                ),
                pw.Text(
                  "إن رئيس $name :-",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  """بناءً على الصلاحيات الممنوحة له بموجب القرار الإداري رقم 2314 وتاريخ 1426/3/15 هـ وبناءً على خطاب مدير                         الصادر برقم $khetabId  في $khetabDate هـ والذي يفيد صلاحيةالمذكور للعمل على وظيفة $jobName ولتوافر المؤهلات المطلوبة لدى الموضح اسمه وهويته أعلاه ولحاجة العمل في $empPart و عملاً بأحكام نظام العمل و العمال و لائحة المعنيين على بند الأجور.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    "يقرر ما يلي:",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 7,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  """1- يعين الموضح اسمه وبياناته أعلاه على وظيفة $empName ب$empPart فئة $mrtaba رقمها $jobNumber على الدرجة $draga بأجر شهري وقدرة $salary و نقل $nqalBadal.
2- يعتبر تعيينه من تاريخ مباشرته العمل.
3- يكون تحت التجربة خلال سنة من تاريخ المباشرة.
4- يصرف له راتب شهر وفقاً للمادة 11 من لائحة المعينين على بند الأجور.
5- يبلغ هذا القرار من يلزم لانفاذه.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """رئيس $name
                      
$bossName""",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 7,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.Divider(
                  height: 20,
                  thickness: 2,
                  color: PdfColors.black,
                ),
                pw.Center(
                  child: pw.Text(
                    "المباشرة",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 7,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Text(
                  """المكرم / مدير شئون الموظفين                                                                       المحترم
السلام عليكم ورحمة الله وبركاته:-
بناء على ما رفعه لنا مدير قسم الخدمات البلدية في خطابة المؤرخ في $khetabDate هـ والمتضمن مباشرة الموضح اسمه أعلاه العمل لديهم يوم $mDay الموافق $mKhetabDate هـ.
لذا اعتمدوا التأشير بذلك.. """,
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 7,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """رئيس $name
                      
$bossName""",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 7,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
}
