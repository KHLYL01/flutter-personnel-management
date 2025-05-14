import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmployeeReportController extends GetxController {
  // عقد عامل
  Future<void> createAkdEmployeeReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "عقد عامل");

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
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'عقد توظيف عامل',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                      pw.Text(
                        'عقد توظيف عامل',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'طرف أول : بلدية محافظة تيماء ويمثلها رئيسها المهندس/حسن بن عبدالرحيم الغبان',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'طرف ثاني :دانش ريس الدين',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'الجنسية :هندي',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'رقم القامة : 192222',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'تاريخه: 1444/2/22',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """تم التفاق على هذا العقد بين الطرفين بالشروط الآتية :
1:- يباشر الطرف الثاني واجبات الوظيفة المعين عليها عامل نظافة رقم : 0
اعتبارا من تاريخ 1445/2/22 هـ ويلتزم بما يوجه له الطرف الول من أعمال على أن يكون العمل اليومي 8 سـاعات والعطلة السبوعية يوم
الجمعة فقط إل إذا رأى الطرف الول غير ذلك .
2:- يدفع الطرف الول للطرف الثاني راتبا شهريا وقدره : 0.00 ريال
الراتب مقداره : 0.00 ر . وبدل نقل شهري وقدره : 0.00 ر .وبدل اعاشة 0.00 في نهاية كل شهر هجري .
3:- عطلة العياد يوم قبل العيد ويوم العيد ويوم بعده فقط ثلثة أيام .
والجازة السنوية إحدى وعشرون يوما عن كل سنة من تاريخ بداية هذا العقد .
4:- لا يتحمل الطرف الأول تكاليف السفر والإقامة أو تجديدها .
5:- يتحمل الطرف الأول سكن الطرف الثاني حسب المتاح وإلا فالطرف الثاني يتحمل سكنه .
6:- يلتزم الطرف الثاني بالعادات والتقاليد المعمول بها في المملكة العربية السعودية ويبتعد عن المشاكل وكل ما يخل بالشرف والمانة وإلا سوف
يتحمل عواقب الخلل بهذه الفقرة .
7:- الطرف الول غير ملزم بدفع مبالغ عند نهاية الخدمة .
-:8 يجدد هذا العقد تلقائيا كل سنتين وفي حالة الطرف الثاني في إنهاء عقده يتقدم بطلب رسمي إلى الطرف الول قبل ذلك بثلاثين يوما .
تم التفاق على هذا العقد بين الطرفين بالشروط الآتية: 
""",
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 11, lineSpacing: 16),
                ),
                pw.SizedBox(height: 16),
                pw.Center(
                  child: pw.Text(
                    "والله الموفق ,,,,,",
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 11, lineSpacing: 16),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "     طرف ثاني",
                        style: pw.TextStyle(
                            font: arabicFont, fontSize: 11, lineSpacing: 16),
                      ),
                      pw.Text(
                        "طرف أول : بلدية محافظة تيماء   ",
                        style: pw.TextStyle(
                            font: arabicFont, fontSize: 11, lineSpacing: 16),
                      )
                    ]),
                pw.SizedBox(height: 16),
                pw.Center(
                  child: pw.Text(
                    "الختم الرسمي",
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 11, lineSpacing: 16),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "دانش ريس الدين",
                      style: pw.TextStyle(
                          font: arabicFont, fontSize: 11, lineSpacing: 16),
                    ),
                    pw.Text(
                      "المهندس/حسن بن عبدالرحيم الغبان",
                      style: pw.TextStyle(
                          font: arabicFont, fontSize: 11, lineSpacing: 16),
                    )
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
    //   filename: 'عقد عامل.pdf',
    // );
  }

  // مكافأة عن الإجازات
  Future<void> createMokafaaHolidayReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "مكافأة عن الإجازات");

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
                          lineSpacing: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 50),
                      pw.Text(
                        """بسم الله الرحمن الرحيم
تاريخ تعينه فى 1444/2/2 هـ
مسير إفرادى بمقدرا مكافأة العامل أدناه لتعويضه عن الجازات
                        """,
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
                // جدول البيانات
                pw.TableHelper.fromTextArray(
                    context: context,
                    border: pw.TableBorder.all(color: PdfColors.grey400),
                    tableDirection: pw.TextDirection.rtl,
                    headerStyle: pw.TextStyle(
                      font: arabicFont,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.white,
                      fontSize: 8,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.grey600,
                    ),
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                    ),
                    cellAlignment: pw.Alignment.center,
                    headerAlignment: pw.Alignment.center,
                    columnWidths: {
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(200),
                      3: const pw.FixedColumnWidth(200),
                      4: const pw.FixedColumnWidth(200),
                      5: const pw.FixedColumnWidth(200),
                      6: const pw.FixedColumnWidth(200),
                      7: const pw.FixedColumnWidth(200),
                      8: const pw.FixedColumnWidth(400),
                    },
                    headers: [
                      'التوقيع',
                      'المجموع',
                      'الصافي',
                      'مقدار تعويض الإجازات',
                      'المدة المعوض عنها',
                      'الرصيد المتبقي من الإجازات',
                      'أساس الراتب',
                      'المسمى الوظيفي',
                      'الاسم',
                    ],
                    data: [
                      [
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                      ],
                    ]),
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
    //   filename: 'مكافأة عن الإجازات.pdf',
    // );
  }

  // بيان خدمة موظف
  Future<void> createBeanKhedmhEmployeeReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'بيان خدمة موظف');

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
                      pw.SizedBox(width: 100),
                      pw.Text(
                        "بيان بخدمات الموظف سعد محمد سالم العنزي بطاقة رقم 1200020541 تاريخها 1411/8/19 مصدرها تيماء",
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
                      1: const pw.FixedColumnWidth(400),
                      2: const pw.FixedColumnWidth(400),
                      3: const pw.FixedColumnWidth(300),
                      4: const pw.FixedColumnWidth(300),
                      5: const pw.FixedColumnWidth(200),
                      6: const pw.FixedColumnWidth(200),
                      7: const pw.FixedColumnWidth(200),
                      8: const pw.FixedColumnWidth(200),
                      9: const pw.FixedColumnWidth(300),
                    },
                    headers: [
                      'الملاحظات',
                      'تاريخ الامر المستند إليه',
                      'رقم الامر المستند إليه',
                      'الخدمة إلى',
                      'الخدمة من',
                      'الجهة',
                      'الراتب',
                      'رقمها',
                      'المرتبة',
                      'الوظيفة',
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
                      ]
                    ]),
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
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'بيان خدمة موظف.pdf',
    // );
  }

  // شهادة تعريف
  Future<void> createShahadaTarefReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "شهادة تعريف");

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
                        "الموضوع : شهادة تعريف",
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
                      fontSize: 8,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                    ),
                    cellAlignment: pw.Alignment.center,
                    headerAlignment: pw.Alignment.center,
                    columnWidths: {
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(400),
                      3: const pw.FixedColumnWidth(200),
                    },
                    // headers: [
                    //   'بدل النقل',
                    //   'مدة الانتداب',
                    //   'الراتب',
                    //   'الدرجة',
                    //   'المرتبة',
                    //   'الوظيفة',
                    //   'رقم السجل المدني',
                    //   'الاسم',
                    // ],
                    data: [
                      [
                        '',
                        'الراتب الأساسي:',
                        '',
                        'اسم الموظف:',
                      ],
                      [
                        '',
                        'بدل النقل:',
                        '',
                        'رقم السجل:',
                      ],
                      [
                        '',
                        'طبيعة العمل:',
                        '',
                        'بداية الخدمة:',
                      ],
                      [
                        '',
                        'ضرر وعدوى:',
                        '',
                        'الوظيفة:',
                      ],
                      [
                        '',
                        'الإجمالي:',
                        '',
                        'المرتبة / المستوى:',
                      ],
                      [
                        '',
                        'حسم صندوق التنمية العقاري:',
                        '',
                        'الدرجة:',
                      ],
                      [
                        '',
                        'حسم صندوق التنمية الزراعية:',
                        '',
                        'حسم التأمينات:',
                      ],
                      [
                        '',
                        'الصافي:',
                        '',
                        'حسم التنمية الإجتماعية:',
                      ],
                    ]),
                pw.SizedBox(height: 10),
                pw.Text(
                  """تشهد بأن المذكور اسمه أعلاه يعمل لدينا و على رأس عمله واعطيت له شهادة بناء على طلبه دون ادنى مسؤولية على البلديةي سواء كانت مالية أو إدارية اتجاه تلك الشهادة لتقديمها إلى
                  
                  """,
                  textAlign: pw.TextAlign.center,
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
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 9,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      "رئيس بلدية محافظة تيماء            ",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 13,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      "المهندس / حسن بن عبد الرحيم الغبان",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 13,
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
    //   filename: 'انتداب موظف.pdf',
    // );
  }

  // مشهد بالراتب
  Future<void> createMashhadRatebReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "مشهد بالراتب");

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
                        "الموضوع : مشهد بالراتب",
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
                      fontSize: 8,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                    ),
                    cellAlignment: pw.Alignment.center,
                    headerAlignment: pw.Alignment.center,
                    columnWidths: {
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(400),
                      3: const pw.FixedColumnWidth(200),
                    },
                    // headers: [
                    //   'بدل النقل',
                    //   'مدة الانتداب',
                    //   'الراتب',
                    //   'الدرجة',
                    //   'المرتبة',
                    //   'الوظيفة',
                    //   'رقم السجل المدني',
                    //   'الاسم',
                    // ],
                    data: [
                      [
                        '',
                        'رقم السجل المدني:',
                        '',
                        'الاسم:',
                      ],
                      [
                        '',
                        'تاريخ التعيين:',
                        '',
                        'رقم الوظيفة:',
                      ],
                      [
                        '',
                        'الراتب:',
                        '',
                        'الوظيفة:',
                      ],
                      [
                        '',
                        'بدل طبيعة العمل',
                        '',
                        'المرتبة:',
                      ],
                      [
                        '',
                        'حسم بنكي:',
                        '',
                        'الدرجة:',
                      ],
                      [
                        '',
                        'صافي الراتب',
                        '',
                        'بدل النقل:',
                      ],
                      [
                        '',
                        '',
                        '',
                        'التأمينات:',
                      ],
                    ]),
                pw.SizedBox(height: 10),
                pw.Text(
                  """تشهد إدارة شئون الموظفين ببلدية محافظة تيماء بأن الموضج اسمه أعلاه أحد (موظفي) هذة البلدية
ولازال على رأس العمل حتى تاريخه.
وبناء على طلبه أعطي هذة الشهادة
لتفديمها إلى""",
                  textAlign: pw.TextAlign.center,
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
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 9,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """مدير إدارة الموارد البشرية
فهد نايف العنزي""",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 13,
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
    //   filename: 'انتداب موظف.pdf',
    // );
  }

  // كارت تعريفي
  Future<void> createEmployeeCard() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "كارت تعريفي");

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
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  width: 240,
                  height: 130,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey50,
                    border: pw.Border.all(width: .1, color: PdfColors.black),
                  ),
                  child: pw.Stack(
                    children: [
                      pw.SizedBox(
                        width: 240,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 16),
                            pw.Text(
                              """المملكة العربية السعودية
وزارة الشئون البلدية و القروية
إدارة الموارد البشرية
""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 6,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 6),
                            pw.Text(
                              """اسم الموظف:

رقم الهوية:

القسم:

تاريخ انتهاء البطاقة:""",
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 9,
                                height: 16,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.Align(
                        alignment: const pw.Alignment(-1, -.9),
                        child: pw.Text(
                          """رئيس بلدية محافظة دومة الجندل
م. ناصر صنهات الشطير""",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 7,
                            height: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
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
    //   filename: 'انتداب موظف.pdf',
    // );

    // إنشاء مستند PDF جديد
    final pdf1 = pw.Document(title: "كارت تعريفي الخلفية");

    // إضافة صفحة إلى المستند
    pdf1.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // للغة العربية
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  width: 240,
                  height: 130,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                  color: PdfColors.grey50,
                  child: pw.Stack(
                    children: [
                      pw.Align(
                        alignment: pw.Alignment.bottomCenter,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(bottom: 16),
                          child: pw.Container(
                            width: 224,
                            height: 100,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(12),
                              border: pw.Border.all(width: .2),
                            ),
                            child: pw.Padding(
                              padding: const pw.EdgeInsets.all(8),
                              child: pw.Column(
                                children: [
                                  pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        'رقم البطاقة 0',
                                        style: pw.TextStyle(
                                          font: arabicFont,
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  pw.SizedBox(height: 16),
                                  pw.Text(
                                    """1- تعتبر هذة البطاقة وثيقة رسمية خاصة بمنسوبي بلدية محافظة دومة و سوف يعاقب كل من يخالف ذلك حسب النظام.
2- في حال العثور عليها يرجى تسليمها إلى بلدية محافظة دومة الجندل.""",
                                    style: pw.TextStyle(
                                      font: arabicFont,
                                      fontSize: 9,
                                      height: 20,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.topCenter,
                        child: pw.Container(
                          height: 20,
                          width: 100,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey50,
                            borderRadius: pw.BorderRadius.circular(10),
                            border: pw.Border.all(width: .2),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              'تعليمات هامة',
                              style: pw.TextStyle(
                                font: arabicFont,
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.bottomCenter,
                        child: pw.Container(
                          height: 10,
                          child: pw.Text(
                            'تليفون: 6221                          ص.ب: 33',
                            style: pw.TextStyle(
                              font: arabicFont,
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // Generate the PDF bytes
    final pdfBytes1 = await pdf1.save();

    // Open in new tab
    final blob1 = html.Blob([pdfBytes1], 'application/pdf');
    final url1 = html.Url.createObjectUrlFromBlob(blob1);
    html.window.open(url1, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf1.save(),
    //   filename: 'انتداب موظف.pdf1',
    // );
  }
}
