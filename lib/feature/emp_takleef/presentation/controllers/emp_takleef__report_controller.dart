import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmpTakleefReportController extends GetxController {
  // قرار خارج دوام
  Future<void> createQrarTakleefReport() async {
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
                    "قرار تكليف بالعمل خارج وقت الدوام الرسمي",
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
                    0: const pw.FixedColumnWidth(500),
                    1: const pw.FixedColumnWidth(250),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(400),
                    6: const pw.FixedColumnWidth(200),
                  },
                  headers: [
                    'العمل المكلف به',
                    'بدل النقل',
                    'الراتب',
                    'المرتبة',
                    'مسمى الوظيفة',
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
                    ],
                  ],
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  """إن رئيس:- بلدية مجافظة تيماء
بناءً على الصلاحيات الممنوحة له.
واستنادا إلى المادة رقم (26) من نظام الخدمات المدنية و تخقيقاً لمقتضيات مصلحة العمل
يقرر ما يلي:-
1:- يكلف الموظفين الموضحة اسمائهم و بياناتهم أعلاه بالعمل خارج وقت الدوام الرسمي
لمدة 13 يوماً / أيام بمعدل (3.50) ساعة / ساعات يوميا لإنهاء العمل المسند إليهم اعتباراً من
يوم الأحد الموافق 2023/11/20 م.
2:- يبلغ هذا القرار لمن يلزم لإنفاذه.
""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 11, lineSpacing: 10),
                ),
                pw.Center(
                  child: pw.Text(
                    "و السلام عليكم ورحمة الله و بركاته ,,,,,",
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 11, lineSpacing: 10),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "رئيس بلدية مجافظة تيماء",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              font: arabicFont, fontSize: 11, lineSpacing: 10),
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
        },
      ),
    );
    // حفظ أو مشاركة الملف
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'قرار خارج دوام.pdf',
    );
  }

  // مسير خارج دوام
  Future<void> createMoserTakleefReport() async {
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
        orientation: pw.PageOrientation.landscape,
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
                        """المملكة العربية السعودية
وزارة الشئون البلدية و القروية
بلدية محافظة تيماء
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
                        "مسير مكافأة العمل الإضافي خلال فترة",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 8,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(
                      "عن المدة من:      2020/11/2      الى      2020/12/2      بموجب قرار رقم      1230213465      و تاريخ      2019/2/11 ",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
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
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(300),
                    6: const pw.FixedColumnWidth(300),
                    7: const pw.FixedColumnWidth(300),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(200),
                    10: const pw.FixedColumnWidth(200),
                    11: const pw.FixedColumnWidth(300),
                    12: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'رقم السجل / الإقامة',
                    'التوقيع',
                    'الصافي',
                    'بدل النقل',
                    'مبلغ التكليف',
                    'مجموع الساعات',
                    'عدد أيام التكليف',
                    'بدل النقل الشهري',
                    'الراتب الاساسي',
                    'الدرجة',
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
                    0: const pw.FixedColumnWidth(300),
                    1: const pw.FixedColumnWidth(200),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(300),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(300),
                    6: const pw.FixedColumnWidth(300),
                    7: const pw.FixedColumnWidth(300),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(1100),
                  },
                  headers: [
                    '',
                    '',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    'المجموع:   10000'
                  ],
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
      filename: 'مسير خارج دوام.pdf',
    );
  }

  // قرار صرف خارج دوام
  Future<void> createQrarSrfTakleefReport() async {
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
                pw.SizedBox(height: 5),
                pw.Center(
                  child: pw.Text(
                    "قرار صرف بالعمل خارج وقت الدوام الرسمي",
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
                    0: const pw.FixedColumnWidth(500),
                    1: const pw.FixedColumnWidth(250),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(400),
                    6: const pw.FixedColumnWidth(200),
                  },
                  headers: [
                    'العمل المكلف به',
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
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    // حفظ أو مشاركة الملف
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'قرار صرف خارج دوام.pdf',
    );
  }
}
