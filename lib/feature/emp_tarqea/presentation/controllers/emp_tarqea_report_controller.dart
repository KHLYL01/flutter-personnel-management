import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmpTarqeaReportController extends GetxController {
  // قرار ترقية
  Future<void> createQrarTarqeaReport(bool withWorkPercentage) async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(
        title: withWorkPercentage
            ? "قرار ترقية مع نسبة طبيعة العمل"
            : "قرار ترقية");

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
                        "الموضوع: قرار ترقية",
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
                    "قرار رقم                     و تاريخ 1437/8/16 هـ",
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

                pw.Text(
                  """إن رئيس بلدية محافظة تيماء :-
بناء على الصلحيات المخولة له بموجب القرار الداري رقم 2314 تاريخ 1426/3/15 و بناء على خطاب سعادة مدير عام الشئون الدارية و المالية بأمانة منطقة الجوف رقم                     و تاريخ 1437/8/16 هـ المبني على مصادقة مدير إدارة الترقيات و النقل المدنية رقم                     و تاريخ 1437/8/16 هـ  المتضمن المصادقة على محضر الترقيات رقم                     و تاريخ 1437/8/16 هـ
بشأن ترقية الموظف الموضح اسمه أدناه و بناء على لائحة الترقيات بنظام الخدمة المدنية و تنفيذ المادة /18ب من النظام المتعلقة بالعلاوة الضافية و المادة 17/27 التي تشير لبدل طبيعة عليه يقرر ما يلي: """,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "(1) ترقية  عبد المجيد محمد منصور   برقم بطاقة  121654672  وفقاً للبيانات الموضحة",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "الوظيفة التي يشغلها:",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
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
                    1: const pw.FixedColumnWidth(300),
                    2: const pw.FixedColumnWidth(400),
                    3: const pw.FixedColumnWidth(300),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'مقرها',
                    'طبيعة العمل',
                    'الراتب',
                    'الرقم',
                    'المرتبة',
                    'مسمى الوظيفة',
                  ],
                  data: [
                    [
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
                  "الوظيفة المرقى إليها:",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
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
                    1: const pw.FixedColumnWidth(300),
                    2: const pw.FixedColumnWidth(400),
                    3: const pw.FixedColumnWidth(300),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'مقرها',
                    'طبيعة العمل',
                    'الراتب',
                    'الرقم',
                    'المرتبة',
                    'مسمى الوظيفة',
                  ],
                  data: [
                    [
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
                withWorkPercentage
                    ? pw.Text(
                        """(2) منحه العلاوة الإضافية المنصوص عليها بالمادة /18ب من نظام الخدمة المدنية.
(3) يمنح المذكور بدل طبيعة عمل 0 % من أول مربوط 38 مبلغ و 0 ريال.
(4) تكون ترقية المذكور من تاريخ مباشرته عمل الوظيفة المرقى عليها بعد صدور هذا القرار.
(5) يبلغ هذا القرار للجهات المختصة و على شؤون الموظفين إنفاذه بموجب النظام .""",
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      )
                    : pw.Text(
                        """(2) منحه العلاوة الإضافية المنصوص عليها بالمادة /18ب من نظام الخدمة المدنية.
(3) تكون ترقية المذكور من تاريخ مباشرته عمل الوظيفة المرقى عليها بعد صدور هذا القرار.
(4) يبلغ هذا القرار للجهات المختصة و على شؤون الموظفين إنفاذه بموجب النظام .""",
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
                    "والله الموفق....",
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
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "رئيس بلدية محافظة تيماء",
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

  // قرار مباشرة
  Future<void> createQrarMobashraReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار مباشرة");

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
                        "الموضوع: قرار مباشرة",
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
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(400),
                    6: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'بدل النقل',
                    'الراتب',
                    'الدرجة',
                    'المرتبة',
                    'الوظيفة',
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
                    ],
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """المكرم مدير الموارد البشرية                                                 المحترم
السلام عليكم ورحمة الله و بركاته ,
إلحاقا لقرارنا الإداري رقم / و تاريخ 14 / 9 / 1436هـ هـ القاضي بترقية الموضح اسمه و بياناته أعلاه على الوظيفة المحاذية لسمه و بناء على ما رفعه لنا رئيس قسم الحركة والصيانة في خطابه 1663 و بتاريخ 14 / 9 / 1436هـ والذي أفاد فيه عن مباشرة المذكور عمله لدى القسم اعتبارا من يوم السبت الموافق 14 / 9 / 1436هـ

لذا اعتمدوا التأشير  بذلك و تزويد الجهات المختصة بصورة منه .
والسلام عليكم ورحمة الله وبركاته ,""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          "رئيس بلدية محافظة تيماء",
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
