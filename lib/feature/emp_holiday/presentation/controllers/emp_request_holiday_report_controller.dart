import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/app_routes.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import 'emp_holiday_controller.dart';

class EmpRequestHolidayReportController extends GetxController {
  Future<void> generatePdf() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String edara = bladiaInfoController.partBoss.text;
    String boss = bladiaInfoController.boss.text;

    String bossAssistant = bladiaInfoController.bossAssistant.text;

    EmpHolidayController controller = Get.find<EmpHolidayController>();

    String empName = controller.empName.text;
    String holidayStartDate = controller.startDate.text;
    String holidayEndDate = controller.endDate.text;
    String holidaySarf =
        controller.sarf.value == "لا أرغب بصرف راتبها مقدما" ? "لا " : "";

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'قرار إجازة');

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
                  """المملكة العربية السعودية
وزارة الشئون البلدية و القروية
$name
إدارة الموارد البشرية
""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'طلب إجازة',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  """الرقم:..........................
التاريخ:      /      /      14هـ
المشفوعات:..........................""",
                  textAlign: pw.TextAlign.end,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Stack(
            children: [
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                columnWidths: {
                  0: const pw.FixedColumnWidth(10),
                  1: const pw.FixedColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              """ سعادة رئيس $name    المحترم
السلام عليكم ورحمه الله وبركاته ...""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "ارغب السماح لي بإجازة ",
                                  style: pw.TextStyle(
                                    font: arabicFont,
                                    fontSize: 8,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                                pw.SizedBox(width: 32),
                                pw.Row(
                                  children: [
                                    _buildCheckboxWithText(
                                        arabicFont, "اعتيادية", false),
                                    _buildCheckboxWithText(
                                        arabicFont, "اضطرارية", false),
                                    _buildCheckboxWithText(
                                        arabicFont, "استثنائية", false),
                                  ],
                                )
                              ],
                            ),
                            pw.Text(
                              """وذلك لمدة (         ) يوم / يوماً
اعتباراً من يوم (                           ) هـ و تاريخ مباشرة العمل اعتباراً من: (                           ) هـ

الاسم: $empName""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildCheckboxWithText(
                                arabicFont,
                                "اوافق على منحة إجازة لمدة (          يوم / يوماً اعتباراً من (                           ) هـ.",
                                false),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _buildCheckboxWithText(arabicFont,
                                    "مع عدم الموافقة على منحة الإجازة.", false),
                                pw.SizedBox(width: 50),
                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    _buildCheckboxWithText(
                                        arabicFont, "ضغط العمل", false),
                                    _buildCheckboxWithText(
                                        arabicFont, "لعدم وجود بديل", false),
                                    _buildCheckboxWithText(
                                        arabicFont, "أخرى", false),
                                  ],
                                ),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'الاسم:',
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              """رصيد الموظف [                ] يوم / يوماً
رصيد الإجازة [                ] يوم / يوماً
الرصيد المتبقي [                ] يوم / يوماً
        الموظف المختص /""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Row(
                              children: [
                                _buildCheckboxWithText(
                                    arabicFont, "الإجازة مستحقة نظاماً", false),
                                pw.SizedBox(width: 50),
                                _buildCheckboxWithText(arabicFont,
                                    "الإجازة غير مستحقة نظاماً", false),
                              ],
                            ),
                            pw.Text(
                              "مدير شئون الموظفين / : $edara",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 20),
                            pw.Text(
                              """       صاحب الصلاحية: رئيس $name
        $boss""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 20),
                          ],
                        ),
                      ),
                      pw.SizedBox(),
                    ],
                  ),
                ],
              ),
              pw.Positioned(
                // جرب قيمًا مختلفة لـ right و top لضبط الموضع
                right:
                    -25, // سيتجاوز حدود الجدول قليلاً نحو اليمين ليظهر على الحافة
                top: 60, // يضبط الموضع الرأسي ليتماشى مع بداية محتوى الجدول
                child: pw.Transform.rotate(
                  angle: 90 * (pi / 180), // تدوير -90 درجة
                  // origin: const PdfPoint(0, 0), // قد لا تحتاج لـ origin هنا مع Positioned
                  child: pw.Text(
                    'تعبأ من قبل الموظف نفسه',
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                // جرب قيمًا مختلفة لـ right و top لضبط الموضع
                right:
                    -5, // سيتجاوز حدود الجدول قليلاً نحو اليمين ليظهر على الحافة
                top: 180, // يضبط الموضع الرأسي ليتماشى مع بداية محتوى الجدول
                child: pw.Transform.rotate(
                  angle: 90 * (pi / 180), // تدوير -90 درجة
                  // origin: const PdfPoint(0, 0), // قد لا تحتاج لـ origin هنا مع Positioned
                  child: pw.Text(
                    'الرئيس المباشر',
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                // جرب قيمًا مختلفة لـ right و top لضبط الموضع
                right:
                    -5, // سيتجاوز حدود الجدول قليلاً نحو اليمين ليظهر على الحافة
                top: 300, // يضبط الموضع الرأسي ليتماشى مع بداية محتوى الجدول
                child: pw.Transform.rotate(
                  angle: 90 * (pi / 180), // تدوير -90 درجة
                  // origin: const PdfPoint(0, 0), // قد لا تحتاج لـ origin هنا مع Positioned
                  child: pw.Text(
                    'شئون الموظفين',
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                // جرب قيمًا مختلفة لـ right و top لضبط الموضع
                right:
                    -15, // سيتجاوز حدود الجدول قليلاً نحو اليمين ليظهر على الحافة
                top: 400, // يضبط الموضع الرأسي ليتماشى مع بداية محتوى الجدول
                child: pw.Transform.rotate(
                  angle: 90 * (pi / 180), // تدوير -90 درجة
                  // origin: const PdfPoint(0, 0), // قد لا تحتاج لـ origin هنا مع Positioned
                  child: pw.Text(
                    'توقيع صاحب الصلاحية',
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Positioned(
                // جرب قيمًا مختلفة لـ right و top لضبط الموضع
                left:
                    30, // سيتجاوز حدود الجدول قليلاً نحو اليمين ليظهر على الحافة
                top: 400, // يضبط الموضع الرأسي ليتماشى مع بداية محتوى الجدول
                child: pw.Transform.rotate(
                  angle: 10 * (pi / 180), // تدوير -90 درجة
                  // origin: const PdfPoint(0, 0), // قد لا تحتاج لـ origin هنا مع Positioned
                  child: pw.Text(
                    'تم الاعتماد الكترونيا',
                    style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار إجازة.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // دالة مساعدة لإنشاء Checkbox مع نصها
  pw.Widget _buildCheckboxWithText(
      pw.Font arabicFont, String text, bool value) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min, // لجعل الصف يأخذ أقل مساحة ممكنة
      children: [
        pw.Checkbox(value: value, name: text), // استخدام name كمعرف
        pw.SizedBox(width: 4), // مسافة أقل
        pw.Text(
          text,
          textDirection: pw.TextDirection.rtl,
          style: pw.TextStyle(
            font: arabicFont,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(width: 8), // مسافة بين كل خيار
      ],
    );
  }
}
