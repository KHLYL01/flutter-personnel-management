import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

class EmployeeReportController extends GetxController {
  // عقد عامل
  Future<void> createAkdEmployeeReport() async {
    String bossName = Get.find<BladiaInfoController>().boss.text;
    String ma3esha = Get.find<BladiaInfoController>().ma3esha.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String employeeName = controller.name.text;
    String employeeNation = controller.nationName.text;
    String employeeCardId = controller.cardId.text;
    String employeeJobDate = controller.datJob.text;
    String employeeJobId = controller.jobNo.text;
    String employeeJobName = controller.jobName.text;
    String employeeSalary = controller.salary.text;
    String employeeNaqlBadal = controller.naqlBadal.text;

    String totalSalary = (double.parse(employeeSalary) +
            double.parse(employeeNaqlBadal) +
            double.parse(ma3esha))
        .toString();

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
                  'طرف أول : بلدية محافظة تيماء ويمثلها رئيسها $bossName',
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
                      'طرف ثاني : $employeeName',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'الجنسية : $employeeNation',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'رقم القامة : $employeeCardId',
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                        decoration: pw.TextDecoration.underline,
                      ),
                    ),
                    pw.Text(
                      'تاريخه: ',
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
                  """تم الأتفاق على هذا العقد بين الطرفين بالشروط الآتية :
1:- يباشر الطرف الثاني واجبات الوظيفة المعين عليها $employeeJobName رقم : $employeeJobId
اعتبارا من تاريخ $employeeJobDate هـ ويلتزم بما يوجه له الطرف الأول من أعمال على أن يكون العمل اليومي 8 سـاعات والعطلة السبوعية يوم
الجمعة فقط إلا إذا رأى الطرف الأول غير ذلك .
2:- يدفع الطرف الأول للطرف الثاني راتبا شهريا وقدره : $totalSalary ريال
الراتب مقداره : $employeeSalary ريال . وبدل نقل شهري وقدره : $employeeNaqlBadal ريال .وبدل اعاشة $ma3esha في نهاية كل شهر هجري .
3:- عطلة الأعياد يوم قبل العيد ويوم العيد ويوم بعده فقط ثلاثة أيام .
والإجازة السنوية إحدى وعشرون يوما عن كل سنة من تاريخ بداية هذا العقد .
4:- لا يتحمل الطرف الأول تكاليف السفر والإقامة أو تجديدها .
5:- يتحمل الطرف الأول سكن الطرف الثاني حسب المتاح وإلا فالطرف الثاني يتحمل سكنه .
6:- يلتزم الطرف الثاني بالعادات والتقاليد المعمول بها في المملكة العربية السعودية ويبتعد عن المشاكل وكل ما يخل بالشرف والأمانة وإلا سوف يتحمل عواقب الخلل بهذه الفقرة .
7:- الطرف الأول غير ملزم بدفع مبالغ عند نهاية الخدمة .
8:- يجدد هذا العقد تلقائيا كل سنتين وفي حالة الطرف الثاني في إنهاء عقده يتقدم بطلب رسمي إلى الطرف الأول قبل ذلك بثلاثين يوما .
تم الأتفاق على هذا العقد بين الطرفين بالشروط الآتية: 
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
                      employeeName,
                      style: pw.TextStyle(
                          font: arabicFont, fontSize: 11, lineSpacing: 16),
                    ),
                    pw.Text(
                      bossName,
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
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmployeeController controller = Get.find<EmployeeController>();
    String employeeJobDate = controller.datJob.text;
    String employeeName = controller.name.text;
    String employeeJobName = controller.jobName.text;
    String employeeSalary = controller.salary.text;

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

$name
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
تاريخ تعينه فى $employeeJobDate هـ
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
                        employeeSalary,
                        employeeJobName,
                        employeeName,
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
                          edara,
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
                          modaqeq,
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
                          malia,
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
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmployeeController controller = Get.find<EmployeeController>();
    String employeeName = controller.name.text;
    String employeeCardNumber = controller.cardNo.text;
    String employeeCardDate = controller.cardStart.text;
    String employeeCardPlace = name.split(" ").last;
    String employeeJobName = controller.jobName.text;
    String employeeMartba = controller.fia.text;
    String employeeJobNo = controller.jobNo.text;
    String employeeSalary = controller.salary.text;
    String place = "";
    String khedmaFrom = "";
    String khedmaTo = "";
    String numberOfAmr = "";
    String dateOfAmr = "";

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
$name
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
                        "بيان بخدمات الموظف $employeeName بطاقة رقم $employeeCardNumber تاريخها $employeeCardDate مصدرها $employeeCardPlace",
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
                        dateOfAmr,
                        numberOfAmr,
                        khedmaTo,
                        khedmaFrom,
                        place,
                        employeeSalary,
                        employeeJobNo,
                        employeeMartba,
                        employeeJobName,
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
                          edara,
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
                          bossName,
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
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String bossName = bladiaInfoController.boss.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String employeeName = controller.name.text;
    String employeeCardId = controller.cardId.text;
    String employeeJobStartDate = controller.datJob.text;
    String employeeJobName = controller.jobName.text;
    String employeeMartba = controller.fia.text;
    String employeeDraga = controller.draga.text;
    String employeeHasmTaamenat = "";
    String employeeHasmTaamenatEjtemaia = "";

    String employeeSalary = controller.salary.text;
    String employeeNaqlBadal = controller.naqlBadal.text;
    String employeeNatureWork = "";
    String employeeDrarAndAdua = "";
    String employeeTotal = "";
    String employeeHasmSandokAkary = "";
    String employeeHasmSandokZera3y = "";
    String employeeSafee = "";

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
                    data: [
                      [
                        employeeSalary,
                        'الراتب الأساسي:',
                        employeeName,
                        'اسم الموظف:',
                      ],
                      [
                        employeeNaqlBadal,
                        'بدل النقل:',
                        employeeCardId,
                        'رقم السجل:',
                      ],
                      [
                        employeeNatureWork,
                        'طبيعة العمل:',
                        employeeJobStartDate,
                        'بداية الخدمة:',
                      ],
                      [
                        employeeDrarAndAdua,
                        'ضرر وعدوى:',
                        employeeJobName,
                        'الوظيفة:',
                      ],
                      [
                        employeeTotal,
                        'الإجمالي:',
                        employeeMartba,
                        'المرتبة / المستوى:',
                      ],
                      [
                        employeeHasmSandokAkary,
                        'حسم صندوق التنمية العقاري:',
                        employeeDraga,
                        'الدرجة:',
                      ],
                      [
                        employeeHasmSandokZera3y,
                        'حسم صندوق التنمية الزراعية:',
                        employeeHasmTaamenat,
                        'حسم التأمينات:',
                      ],
                      [
                        employeeSafee,
                        'الصافي:',
                        employeeHasmTaamenatEjtemaia,
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
                      """رئيس بلدية محافظة تيماء

$bossName""",
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

  // مشهد بالراتب
  Future<void> createMashhadRatebReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String edara = bladiaInfoController.partBoss.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String employeeName = controller.name.text;
    String employeeJobNumber = controller.jobNo.text;
    String employeeJobName = controller.jobName.text;
    String employeeMartba = controller.fia.text;
    String employeeDraga = controller.draga.text;
    String employeeNaqlBadal = controller.naqlBadal.text;
    String employeeHasmTaamenat = "";

    String employeeCardId = controller.cardId.text;
    String employeeJobStartDate = controller.datJob.text;
    String employeeSalary = controller.salary.text;
    String employeeNatureWorkBadal = "";
    String employeeHasmBank = "";
    String employeeSafeeSalary = "";

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
                    data: [
                      [
                        employeeCardId,
                        'رقم السجل المدني:',
                        employeeName,
                        'الاسم:',
                      ],
                      [
                        employeeJobStartDate,
                        'تاريخ التعيين:',
                        employeeJobNumber,
                        'رقم الوظيفة:',
                      ],
                      [
                        employeeSalary,
                        'الراتب:',
                        employeeJobName,
                        'الوظيفة:',
                      ],
                      [
                        employeeNatureWorkBadal,
                        'بدل طبيعة العمل',
                        employeeMartba,
                        'المرتبة:',
                      ],
                      [
                        employeeHasmBank,
                        'حسم بنكي:',
                        employeeDraga,
                        'الدرجة:',
                      ],
                      [
                        employeeSafeeSalary,
                        'صافي الراتب',
                        employeeNaqlBadal,
                        'بدل النقل:',
                      ],
                      [
                        '',
                        '',
                        employeeHasmTaamenat,
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
$edara""",
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
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String bossName = bladiaInfoController.boss.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String employeeName = controller.name.text;
    String employeeCardId = controller.cardId.text;
    String employeePartName = controller.partName.text;
    String employeeCardEndDate = "";

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
                              """اسم الموظف: $employeeName

رقم الهوية: $employeeCardId

القسم: $employeePartName

تاريخ انتهاء البطاقة: $employeeCardEndDate""",
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
