import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EmpEntedabReportController extends GetxController {
  // امر اركاب
  Future<void> createAmrErkabReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "امر اركاب");

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
وزارة الشئون البلدية والقروية
بلدية محافظة تيماء""",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 6,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 50),
                      pw.Text(
                        """بسم الله الرحمن الرحيم""",
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
                pw.SizedBox(height: 20),
                pw.Row(
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
                      "الموضوع : إركاب موظف",
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
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "رقم قرار النتداب: 194521321 تاريخه 1444/2/2 جهه الانتداب تبوك",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Center(
                  child: pw.Text(
                    "البيانات الموضحة أدناه صحيحة و على مسؤوليتي",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
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
                      11: const pw.FixedColumnWidth(450),
                      9: const pw.FixedColumnWidth(200),
                      10: const pw.FixedColumnWidth(200),
                    },
                    headers: [
                      'التوقيع',
                      'الرصيد المتبقي',
                      'مدة الانتداب المجموع',
                      'مدة الانتداب الحالية',
                      'مدة الانتداب السابقة',
                      'الرصيد الثابت للسنة المالية',
                      'بدل النقل',
                      'الراتب',
                      'المرتبة',
                      'الوظيفة',
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
                        '',
                        '',
                      ],
                    ]),
                pw.SizedBox(height: 10),
                pw.Text(
                  """رقم أمر التكليف 122002121 تاريخه 1444/2/2 مدة المهمة 3 
تاريخ السفر الفعلي : 1444/2/2 تاريخ العودة 1444/2/2
""",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Row(
                  children: [
                    pw.Text(
                      "وسيلة السفر",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '1',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "الطائرة",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '2',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "القطار",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '3',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "سيارة حكومية",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '4',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "وسيلة أخرى",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '5',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "نعم",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 10),
                    pw.Checkbox(
                      value: false,
                      name: '6',
                      checkColor: PdfColors.blue,
                      activeColor: PdfColors.black,
                    ),
                    pw.SizedBox(width: 4),
                    pw.Text(
                      "لا",
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
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "هـل تم تـأمـين وسيلـة الـسفر",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '7',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "هل استعملت سيارة حكومية من الجهة المنتدب منها أو المنتدب إليها للتنقلات الداخلية",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '8',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "هل تم تكليفـك بالعمـل خـارج وقـت الــدوام خـلال فتـرة الانتــداب",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '9',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "هـــل تــم تأمـــين الســـكن و الطعـــام أو أحـــدهمـــا",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '10',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "هـل سبق أن صـرف سلفة نقدية على حسـاب المصاريف السفرية و ما مقـدارها",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '11',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 450,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "كـــم تبعـــد جهـــة الانتـــداب عـــن مقـــر العمـــل",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        "0 كـم",
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
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      """الموظف المختص
                           
التوقيع:""",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 9,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      """مدير شؤون الموظفين
عبد الله
التوقيع:""",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 9,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
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
    //   filename: 'اركاب موظف.pdf',
    // );
  }

  // انتداب موظف
  Future<void> createEntedabEmployeeReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "انتداب موظف");

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
                        "الموضوع : إنتداب موظف",
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
                      5: const pw.FixedColumnWidth(300),
                      6: const pw.FixedColumnWidth(350),
                      7: const pw.FixedColumnWidth(400),
                    },
                    headers: [
                      'بدل النقل',
                      'مدة الانتداب',
                      'الراتب',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'رقم السجل المدني',
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
                      ],
                    ]),
                pw.SizedBox(height: 10),
                pw.Text(
                  """المكرم الموضح اسمه اعلاه                                                                              المحترم
السلام عليكم ورحمة الله وبركاته""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 14,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """اعتمدوا التوجه إلى   تبوك
لمدة ثلاثة أيام. اعتبارا من يوم الأحد الموافق: 2020/09/08 م
وذلك لأداء مهمة رسمية وهي   تعويض
مع إحضار  شهادة مراجعة.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
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

  // قرار إنتداب
  Future<void> createQrarEntedabReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار إنتداب");

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
                        "الموضوع : قرار إنتداب موظف",
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
                      6: const pw.FixedColumnWidth(300),
                      7: const pw.FixedColumnWidth(350),
                      8: const pw.FixedColumnWidth(400),
                    },
                    headers: [
                      'مقدار البدل',
                      'بدل النقل',
                      'مدة الانتداب',
                      'الراتب',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'رقم السجل المدني',
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
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "قرار إداري رقم (            ) وتاريخ 2020/11/02 م",
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 12,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """جهة الإنتداب: تبوك
مدة الإنتداب: ثلاثة أيام إعتبارت من يوم 2020/11/20 م
تعويض

إن رئيس بلدية محافظة تيماء بناءَ على الصلاحيات الممنوحة له

وبناء على خطابنا رقم : وتاريخ : ٢٠٢٠/١١/٠٢ القاضي انتداب المذكور للجهة والمدة والمهمة المحددة
اعلاه واستنادا لقرار مجلس الخدمة المدنية رقم ) ٣٦٥ ( في ١٤٠٠/١٠/٢٩ هـ واستنادا للمادة ١/٢ من لائحة
الخدمة المدنية""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "يقرر ما يلي:",
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 9,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """1:- يصرف له يوميا مبلغ وقدرة ) أعله ( ر استنادا للمادة ٢٢ ,١/ ٩ من اللوائح المشـار
إليها واستنادا لقرار مجلس الخدمة المدنية المشار إليه شريطة اتساع البند وعدم تكرار
الصرف لتلك الفترة وبناء على قرار مجلس الوزراء رقم ) ٨٦ ( في ١٤٠٨/٠٥/١٠ هـ
القاضي بتخفيض بدل الانتداب.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 500,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "2:- يصرف له يوميا بدل نقل إضافي بنسبة ٣٠/١ من بدل نقله الشهري بموجب المادة ٢/٢٧ من لئحة الخدمة المدنية.",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '1',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 500,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "3:- يصرف له مبلغ تعويضا عن تذكرة إركاب.",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: false,
                        name: '2',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """4:- على شئون الموظفين والمالية اعتماد هذا القرار وإنفاذ موجبة.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
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
    //   filename: 'قرار انتداب موظف.pdf',
    // );
  }

  // استحقاق راتب
  Future<void> createEsthqaqRatebReport() async {
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "استحقاق راتب");

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
                      pw.SizedBox(width: 190),
                      pw.Text(
                        "سند إفرادي يوضح إستحقاق إنتداب موظف",
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
                      """عن المدة من:      2020/11/2      الى      2020/12/2
بموجب قرار رقم      1230213465      و تاريخ      2019/2/11
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
                      2: const pw.FixedColumnWidth(200),
                      3: const pw.FixedColumnWidth(200),
                      4: const pw.FixedColumnWidth(300),
                      5: const pw.FixedColumnWidth(200),
                      6: const pw.FixedColumnWidth(200),
                      7: const pw.FixedColumnWidth(300),
                      8: const pw.FixedColumnWidth(300),
                      9: const pw.FixedColumnWidth(300),
                      10: const pw.FixedColumnWidth(200),
                      11: const pw.FixedColumnWidth(200),
                      12: const pw.FixedColumnWidth(300),
                      13: const pw.FixedColumnWidth(400),
                    },
                    headers: [
                      'الملاحظات',
                      'التوقيع',
                      'الصافي',
                      'تعويض التذاكر',
                      'بدل النقل الصافي',
                      'مبلغ الإنتداب',
                      'مدة الإنتداب',
                      'بدل الإنتداب اليومي',
                      'بدل النقل الشهري',
                      'الراتب الشهري',
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
                        "",
                      ]
                    ]),

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
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(200),
                    6: const pw.FixedColumnWidth(200),
                    7: const pw.FixedColumnWidth(300),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(300),
                    10: const pw.FixedColumnWidth(1100),
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

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'استحقاق راتب.pdf',
    // );
  }
}
