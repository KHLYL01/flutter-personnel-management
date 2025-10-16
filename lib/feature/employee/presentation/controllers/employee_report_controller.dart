import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/employee/data/model/mosaeer_salary_model.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/mosaeer_salary_controller.dart';
import 'package:personnel_management/feature/tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../users/presentation/controllers/user_controller.dart';

class EmployeeReportController extends GetxController {
  // عقد عامل
  Future<void> createAkdEmployeeReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;
    String ma3esha = bladiaInfoController.ma3esha.text;

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
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'عقد توظيف عامل',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
                pw.Text(
                  'عقد توظيف عامل',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'طرف أول : $name ويمثلها رئيسها $bossName',
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 9,
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
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.Text(
                'الجنسية : $employeeNation',
                style: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.Text(
                'رقم القامة : $employeeCardId',
                style: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
              pw.Text(
                'تاريخه: ',
                style: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """تم الأتفاق على هذا العقد بين الطرفين بالشروط الآتية :
1:- يباشر الطرف الثاني واجبات الوظيفة المعين عليها $employeeJobName رقم : $employeeJobIdاعتبارا من تاريخ $employeeJobDate هـ ويلتزم بما يوجه له الطرف الأول من أعمال على أن يكون العمل اليومي 8 سـاعات والعطلة السبوعية يوم الجمعة فقط إلا إذا رأى الطرف الأول غير ذلك .
2:- يدفع الطرف الأول للطرف الثاني راتبا شهريا وقدره : $totalSalary ريال الراتب مقداره : $employeeSalary ريال . وبدل نقل شهري وقدره : $employeeNaqlBadal ريال .وبدل اعاشة $ma3esha في نهاية كل شهر هجري .
3:- عطلة الأعياد يوم قبل العيد ويوم العيد ويوم بعده فقط ثلاثة أيام .والإجازة السنوية إحدى وعشرون يوما عن كل سنة من تاريخ بداية هذا العقد .
4:- لا يتحمل الطرف الأول تكاليف السفر والإقامة أو تجديدها .
5:- يتحمل الطرف الأول سكن الطرف الثاني حسب المتاح وإلا فالطرف الثاني يتحمل سكنه .
6:- يلتزم الطرف الثاني بالعادات والتقاليد المعمول بها في المملكة العربية السعودية ويبتعد عن المشاكل وكل ما يخل بالشرف والأمانة وإلا سوف يتحمل عواقب الخلل بهذه الفقرة .
7:- الطرف الأول غير ملزم بدفع مبالغ عند نهاية الخدمة .
8:- يجدد هذا العقد تلقائيا كل سنتين وفي حالة الطرف الثاني في إنهاء عقده يتقدم بطلب رسمي إلى الطرف الأول قبل ذلك بثلاثين يوما .تم الأتفاق على هذا العقد بين الطرفين بالشروط الآتية: 
""",
            style: pw.TextStyle(font: arabicFont, fontSize: 8, lineSpacing: 16),
          ),
          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              "والله الموفق ,,,,,",
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 9, lineSpacing: 16),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  "     طرف ثاني",
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 9, lineSpacing: 16),
                ),
                pw.Text(
                  "طرف أول :  $name   ",
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 9, lineSpacing: 16),
                )
              ]),
          pw.SizedBox(height: 16),
          pw.Center(
            child: pw.Text(
              "الختم الرسمي",
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 9, lineSpacing: 16),
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                employeeName,
                style: pw.TextStyle(
                    font: arabicFont, fontSize: 9, lineSpacing: 16),
              ),
              pw.Text(
                bossName,
                style: pw.TextStyle(
                    font: arabicFont, fontSize: 9, lineSpacing: 16),
              )
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
    //   filename: 'عقد عامل.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مكافأة عن الإجازات
  Future<void> createMokafaaHolidayReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = Get.find<UserController>().userEmpName;
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
                    empName,
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
    //   filename: 'مكافأة عن الإجازات.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // شهادة تعريف
  Future<void> createShahadaTarefReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String bossName = bladiaInfoController.boss.text;
    String name = bladiaInfoController.name.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String empName = controller.name.text;
    String cardId = controller.cardId.text;
    String jobStartDate = controller.datWork.text;
    String job = controller.jobName.text;
    String martaba = controller.fia.text;
    String draga = controller.draga.text;

    String salary = controller.salary.text;
    String naqlBadal = controller.naqlBadal.text;
    String jobBadalat = controller.jobbadalat.text;
    String badal2 = controller.badal2.text;
    double employeeTotal = double.parse(salary) +
        double.parse(naqlBadal) +
        double.parse(jobBadalat) +
        double.parse(badal2);

    double hasmTaamenat = double.parse(salary) * 9 / 100;
    String dissent = controller.dissent.text;
    String sandok = controller.sandok.text;
    String zeraee = controller.zeraee.text;
    String taka3od = controller.taka3odM.text;

    double hasmTotal = hasmTaamenat +
        double.parse(dissent) +
        double.parse(sandok) +
        double.parse(zeraee) +
        double.parse(taka3od);

    double employeeSafee = employeeTotal - hasmTotal;

    List<List<dynamic>> data = [
      [
        salary,
        'الراتب الأساسي:',
        empName,
        'اسم الموظف:',
      ],
      [
        naqlBadal,
        'بدل النقل:',
        cardId,
        'رقم السجل:',
      ],
      [
        jobBadalat,
        'طبيعة العمل:',
        jobStartDate,
        'بداية الخدمة:',
      ],
      [
        badal2,
        'ضرر وعدوى:',
        job,
        'الوظيفة:',
      ],
      [
        employeeTotal,
        'الإجمالي:',
        martaba,
        'المرتبة / المستوى:',
      ],
      [
        sandok,
        'حسم صندوق التنمية العقاري:',
        draga,
        'الدرجة:',
      ],
      [
        zeraee,
        'حسم صندوق التنمية الزراعية:',
        hasmTaamenat,
        'حسم التأمينات:',
      ],
      [
        employeeSafee,
        'الصافي:',
        dissent,
        'حسم التنمية الإجتماعية:',
      ],
    ];
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "شهادة تعريف");

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
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "الموضوع : شهادة تعريف",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
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
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """تشهد بأن المذكور اسمه أعلاه يعمل لدينا و على رأس عمله واعطيت له شهادة بناء على طلبه دون ادنى مسؤولية على البلديةي سواء كانت مالية أو إدارية اتجاه تلك الشهادة لتقديمها إلى
            
            """,
            textAlign: pw.TextAlign.center,
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
                """رئيس $name

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

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'انتداب موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مشهد بالراتب
  Future<void> createMashhadRatebReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String edara = bladiaInfoController.partBoss.text;
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmployeeController controller = Get.find<EmployeeController>();

    String jobNo = controller.jobNo.text;
    String empName = controller.name.text;
    String cardId = controller.cardId.text;
    String jobStartDate = controller.datWork.text;
    String job = controller.jobName.text;
    String martaba = controller.fia.text;
    String draga = controller.draga.text;

    String salary = controller.salary.text;
    String naqlBadal = controller.naqlBadal.text;
    String jobBadalat = controller.jobbadalat.text;
    double employeeTotal = double.parse(salary) +
        double.parse(naqlBadal) +
        double.parse(jobBadalat);

    double hasmTaamenat = double.parse(salary) * 9 / 100;
    String dissent = controller.dissent.text;

    double hasmTotal = hasmTaamenat + double.parse(dissent);

    double safeeSalary = employeeTotal - hasmTotal;

    List<List<dynamic>> data = [
      [
        cardId,
        'رقم السجل المدني:',
        empName,
        'الاسم:',
      ],
      [
        jobStartDate,
        'تاريخ التعيين:',
        jobNo,
        'رقم الوظيفة:',
      ],
      [
        salary,
        'الراتب:',
        job,
        'الوظيفة:',
      ],
      [
        jobBadalat,
        'بدل طبيعة العمل',
        martaba,
        'المرتبة:',
      ],
      [
        dissent,
        'حسم بنكي:',
        draga,
        'الدرجة:',
      ],
      [
        hasmTaamenat,
        'التأمينات:',
        naqlBadal,
        'بدل النقل:',
      ],
      [
        '',
        '',
        safeeSalary,
        'صافي الراتب',
      ],
    ];

    double employeeSafee = employeeTotal - hasmTotal;
    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "مشهد بالراتب");

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
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "الموضوع : مشهد بالراتب",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
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
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """تشهد إدارة شئون الموظفين ب$name بأن الموضج اسمه أعلاه أحد (موظفي) هذة البلدية ولازال على رأس العمل حتى تاريخه. 
وبناء على طلبه أعطي هذة الشهادة لتقديمها إلى""",
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

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'انتداب موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
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
    String employeeCardNumber = controller.cardNo.text;

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
                                fontSize: 8,
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
                            fontSize: 6,
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
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'انتداب موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);

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
                                        'رقم البطاقة $employeeCardNumber',
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
                                      fontSize: 7,
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
                                fontSize: 7,
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
                              fontSize: 6,
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

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مسير الروتب
  Future<void> mosaeerSalaryReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = Get.find<UserController>().userEmpName;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    MosaeerSalaryController controller = Get.find<MosaeerSalaryController>();

    String month = "";
    String empType = "";

    if (controller.empType.value == "موظف") {
      empType = "رواتب الموظفين";
    }
    if (controller.empType.value == "مستخدم") {
      empType = "رواتب المستخدمين";
    }
    if (controller.empType.value == "عامل بند إجور") {
      empType = "رواتب العمال بند الإجور";
    }
    if (controller.empType.value == "عامل أجنبي") {
      empType = "رواتب العمال الأجانب";
    }

    List<String> list = controller.startDate.text.split("/");
    int y = int.parse(list[0]);
    int m = int.parse(list[1]);
    int d = int.parse(list[2]);

    HijriCalendar.language = 'ar';
    HijriCalendar hijriCalendar = HijriCalendar()
      ..hYear = y
      ..hMonth = m
      ..hDay = d;

    month = "${hijriCalendar.getLongMonthName()} $y";

    List<List<dynamic>> data = [];
    int i = 1;

    double sumSafy = 0;
    double sumHasmTotal = 0;
    double sumHasm2 = 0;
    double sumHasm3 = 0;
    double sumSandok = 0;
    double sumZeraee = 0;
    double sumBank = 0;
    double sumTaka3odM = 0;
    double sumGza = 0;
    double sumTaka3ed = 0;
    double sumMosta7qTotal = 0;
    double sumBadal4 = 0;
    double sumBadal2 = 0;
    double sumJobBadalat = 0;
    double sumNaqlBadal = 0;
    double sumSalary = 0;
    for (MosaeerSalaryModel m in controller.mosaeer) {
      if (!m.check.value) {
        if (controller.empType.value == "عامل أجنبي") {
          data.add([
            m.safy ?? "",
            m.hasmTotal ?? "",
            m.hasm2 ?? 0,
            m.hasm3 ?? 0,
            m.sandok ?? 0,
            m.zeraee ?? 0,
            m.bank ?? "",
            m.taka3odM ?? 0,
            m.gza ?? 0,
            m.taka3ed ?? 0,
            m.mosta7qTotal ?? 0,
            m.badal4 ?? 0,
            m.badal2 ?? 0,
            m.jobBadalat ?? "",
            m.naqlBadal ?? 0,
            m.salary ?? 0,
            m.draga ?? "",
            m.fia ?? "",
            m.jobName ?? "",
            m.name ?? "",
            i,
          ]);
        } else {
          data.add([
            m.ibanNum ?? "",
            m.safy ?? "",
            m.hasmTotal ?? "",
            m.hasm2 ?? 0,
            m.hasm3 ?? 0,
            m.sandok ?? 0,
            m.zeraee ?? 0,
            m.bank ?? "",
            m.taka3odM ?? 0,
            m.gza ?? 0,
            m.taka3ed ?? 0,
            m.mosta7qTotal ?? 0,
            m.badal4 ?? 0,
            m.badal2 ?? 0,
            m.jobBadalat ?? "",
            m.naqlBadal ?? 0,
            m.salary ?? 0,
            m.draga ?? "",
            m.fia ?? "",
            m.jobName ?? "",
            m.name ?? "",
            i,
          ]);
        }
        sumSafy += m.safy ?? 0;
        sumHasmTotal += m.hasmTotal ?? 0;
        sumHasm2 += m.hasm2 ?? 0;
        sumHasm3 += m.hasm3 ?? 0;
        sumSandok += m.sandok ?? 0;
        sumZeraee += m.zeraee ?? 0;
        sumBank += m.bank ?? 0;
        sumTaka3odM += m.taka3odM ?? 0;
        sumGza += m.gza ?? 0;
        sumTaka3ed += m.taka3ed ?? 0;
        sumMosta7qTotal += m.mosta7qTotal ?? 0;
        sumBadal4 += m.badal4 ?? 0;
        sumBadal2 += m.badal2 ?? 0;
        sumJobBadalat += m.jobBadalat ?? 0;
        sumNaqlBadal += m.naqlBadal ?? 0;
        sumSalary += m.salary ?? 0;
        i++;
      }
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'مسير رواتب');

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    final chunks = chunkList(data, 14);

    //إضافة صفحة إلى المستند
    int start = 1;
    int last = chunks.length;
    for (var chunk in chunks) {
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
                  pw.SizedBox(width: 170),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        """سند مشترك  برواتب شهر  $month
وقد فوض موقعوه أمين الصندوق بقبض استحقاقهم بموجبه
                  """,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 8,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        empType,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 8,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(width: 160),
                  pw.Text(
                    "الصفحة $start من $last",
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
                fontSize: 5,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey600,
              ),
              cellStyle: pw.TextStyle(
                font: arabicFont,
                fontSize: 5,
              ),
              cellAlignment: pw.Alignment.center,
              headerAlignment: pw.Alignment.center,
              columnWidths: controller.empType.value == "عامل أجنبي"
                  ? {
                      0: const pw.FixedColumnWidth(1.8),
                      1: const pw.FixedColumnWidth(1.8),
                      2: const pw.FixedColumnWidth(1.2),
                      3: const pw.FixedColumnWidth(1.2),
                      4: const pw.FixedColumnWidth(1.2),
                      5: const pw.FixedColumnWidth(1.3),
                      6: const pw.FixedColumnWidth(1.5),
                      7: const pw.FixedColumnWidth(1.5),
                      8: const pw.FixedColumnWidth(1.4),
                      9: const pw.FixedColumnWidth(2),
                      10: const pw.FixedColumnWidth(1.8),
                      11: const pw.FixedColumnWidth(1.2),
                      12: const pw.FixedColumnWidth(1.5),
                      13: const pw.FixedColumnWidth(1.5),
                      14: const pw.FixedColumnWidth(1.5),
                      15: const pw.FixedColumnWidth(2),
                      16: const pw.FixedColumnWidth(1.2),
                      17: const pw.FixedColumnWidth(1.3),
                      18: const pw.FixedColumnWidth(3.5),
                      19: const pw.FixedColumnWidth(5),
                      20: const pw.FixedColumnWidth(1),
                    }
                  : {
                      0: const pw.FixedColumnWidth(2.2),
                      1: const pw.FixedColumnWidth(1.8),
                      2: const pw.FixedColumnWidth(1.8),
                      3: const pw.FixedColumnWidth(1.2),
                      4: const pw.FixedColumnWidth(1.2),
                      5: const pw.FixedColumnWidth(1.2),
                      6: const pw.FixedColumnWidth(1.3),
                      7: const pw.FixedColumnWidth(1.5),
                      8: const pw.FixedColumnWidth(1.5),
                      9: const pw.FixedColumnWidth(1.4),
                      10: const pw.FixedColumnWidth(2),
                      11: const pw.FixedColumnWidth(1.8),
                      12: const pw.FixedColumnWidth(1.2),
                      13: const pw.FixedColumnWidth(1.5),
                      14: const pw.FixedColumnWidth(1.5),
                      15: const pw.FixedColumnWidth(1.5),
                      16: const pw.FixedColumnWidth(2),
                      17: const pw.FixedColumnWidth(1.2),
                      18: const pw.FixedColumnWidth(1.3),
                      19: const pw.FixedColumnWidth(3.5),
                      20: const pw.FixedColumnWidth(5),
                      21: const pw.FixedColumnWidth(1),
                    },
              headers: controller.empType.value == "عامل أجنبي"
                  ? [
                      'الصافي',
                      'المجموع',
                      'أخرى',
                      'سند',
                      'عقارى',
                      'الزراعى',
                      'التسليف',
                      'تقاعد معاد',
                      'جزاءات',
                      'تقاعد / تأمينات',
                      'المجموع',
                      'أخرى',
                      'ضرر / عدوى',
                      'طبيعة العمل',
                      'بدل النقل',
                      'الراتب الأساسي',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'الاسم',
                      ' م ',
                    ]
                  : [
                      'الايبان',
                      'الصافي',
                      'المجموع',
                      'أخرى',
                      'سند',
                      'عقارى',
                      'الزراعى',
                      'التسليف',
                      'تقاعد معاد',
                      'جزاءات',
                      'تقاعد / تأمينات',
                      'المجموع',
                      'أخرى',
                      'ضرر / عدوى',
                      'طبيعة العمل',
                      'بدل النقل',
                      'الراتب الأساسي',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'الاسم',
                      ' م ',
                    ],
              data: chunk,
            ),
            if (start == last)
              pw.TableHelper.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: PdfColors.grey400),
                tableDirection: pw.TextDirection.rtl,
                headerStyle: pw.TextStyle(
                  font: arabicFont,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  fontSize: 5,
                ),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey600,
                ),
                cellStyle: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 5,
                ),
                cellAlignment: pw.Alignment.center,
                headerAlignment: pw.Alignment.center,
                columnWidths: controller.empType.value == "عامل أجنبي"
                    ? {
                        0: const pw.FixedColumnWidth(1.8),
                        1: const pw.FixedColumnWidth(1.8),
                        2: const pw.FixedColumnWidth(1.2),
                        3: const pw.FixedColumnWidth(1.2),
                        4: const pw.FixedColumnWidth(1.2),
                        5: const pw.FixedColumnWidth(1.3),
                        6: const pw.FixedColumnWidth(1.5),
                        7: const pw.FixedColumnWidth(1.5),
                        8: const pw.FixedColumnWidth(1.4),
                        9: const pw.FixedColumnWidth(2),
                        10: const pw.FixedColumnWidth(1.8),
                        11: const pw.FixedColumnWidth(1.2),
                        12: const pw.FixedColumnWidth(1.5),
                        13: const pw.FixedColumnWidth(1.5),
                        14: const pw.FixedColumnWidth(1.5),
                        15: const pw.FixedColumnWidth(2),
                        16: const pw.FixedColumnWidth(12),
                      }
                    : {
                        0: const pw.FixedColumnWidth(2.2),
                        1: const pw.FixedColumnWidth(1.8),
                        2: const pw.FixedColumnWidth(1.8),
                        3: const pw.FixedColumnWidth(1.2),
                        4: const pw.FixedColumnWidth(1.2),
                        5: const pw.FixedColumnWidth(1.2),
                        6: const pw.FixedColumnWidth(1.3),
                        7: const pw.FixedColumnWidth(1.5),
                        8: const pw.FixedColumnWidth(1.5),
                        9: const pw.FixedColumnWidth(1.4),
                        10: const pw.FixedColumnWidth(2),
                        11: const pw.FixedColumnWidth(1.8),
                        12: const pw.FixedColumnWidth(1.2),
                        13: const pw.FixedColumnWidth(1.5),
                        14: const pw.FixedColumnWidth(1.5),
                        15: const pw.FixedColumnWidth(1.5),
                        16: const pw.FixedColumnWidth(2),
                        17: const pw.FixedColumnWidth(12),
                      },
                headers: controller.empType.value == "عامل أجنبي"
                    ? [
                        sumSafy.toPrecision(2),
                        sumHasmTotal.toPrecision(2),
                        sumHasm2.toPrecision(2),
                        sumHasm3.toPrecision(2),
                        sumSandok.toPrecision(2),
                        sumZeraee.toPrecision(2),
                        sumBank.toPrecision(2),
                        sumTaka3odM.toPrecision(2),
                        sumGza.toPrecision(2),
                        sumTaka3ed.toPrecision(2),
                        sumMosta7qTotal.toPrecision(2),
                        sumBadal4.toPrecision(2),
                        sumBadal2.toPrecision(2),
                        sumJobBadalat.toPrecision(2),
                        sumNaqlBadal.toPrecision(2),
                        sumSalary.toPrecision(2),
                        'الإجمالي',
                      ]
                    : [
                        "",
                        sumSafy.toPrecision(2),
                        sumHasmTotal.toPrecision(2),
                        sumHasm2.toPrecision(2),
                        sumHasm3.toPrecision(2),
                        sumSandok.toPrecision(2),
                        sumZeraee.toPrecision(2),
                        sumBank.toPrecision(2),
                        sumTaka3odM.toPrecision(2),
                        sumGza.toPrecision(2),
                        sumTaka3ed.toPrecision(2),
                        sumMosta7qTotal.toPrecision(2),
                        sumBadal4.toPrecision(2),
                        sumBadal2.toPrecision(2),
                        sumJobBadalat.toPrecision(2),
                        sumNaqlBadal.toPrecision(2),
                        sumSalary.toPrecision(2),
                        'الإجمالي',
                      ],
                data: [],
              ),
            if (start == last) pw.SizedBox(height: 20),
            if (start == last)
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
                        empName,
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
                        "مدير قسم الشؤون المالية",
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
                  pw.Column(
                    children: [
                      pw.Text(
                        "رئيس $name",
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
              ),
          ],
        ),
      );
      start++;
    }
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'بيان خدمة موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مسير الروتب لعمال النظافة
  Future<void> mosaeerSalaryWorkerReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = Get.find<UserController>().userEmpName;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    MosaeerSalaryController controller = Get.find<MosaeerSalaryController>();

    String month = "";
    String empType = "رواتب عمال النظافة";

    List<String> list = controller.startDate.text.split("/");
    int y = int.parse(list[0]);
    int m = int.parse(list[1]);
    int d = int.parse(list[2]);

    HijriCalendar.language = 'ar';
    HijriCalendar hijriCalendar = HijriCalendar()
      ..hYear = y
      ..hMonth = m
      ..hDay = d;

    month = "${hijriCalendar.getLongMonthName()} $y";

    List<List<dynamic>> data = [];
    int i = 1;

    double sumSafy = 0;
    double sumHasmTotal = 0;
    double sumBank = 0;
    double sumGza = 0;
    double sumTaka3ed = 0;
    double sumMosta7qTotal = 0;
    double sumMaeesha = 0;
    double sumNaqlBadal = 0;
    double sumMosta7qSalary = 0;
    double sumSalary = 0;
    for (MosaeerSalaryModel m in controller.mosaeer) {
      if (!m.check.value) {
        data.add([
          "",
          "",
          m.safy,
          m.hasmTotal,
          m.bank,
          m.gza,
          m.taka3ed,
          m.mosta7qTotal,
          m.ma3esha,
          m.naqlBadal,
          m.mosta7qSalary,
          m.salary,
          m.cardId,
          m.fia,
          m.jobName,
          m.name,
          i,
        ]);

        sumSafy += m.safy ?? 0;
        sumHasmTotal += m.hasmTotal ?? 0;
        sumBank += m.bank ?? 0;
        sumGza += m.gza ?? 0;
        sumTaka3ed += m.taka3ed ?? 0;
        sumMosta7qTotal += m.mosta7qTotal ?? 0;
        sumMaeesha += m.jobBadalat ?? 0;
        sumNaqlBadal += m.naqlBadal ?? 0;
        sumMosta7qSalary += m.salary ?? 0;
        sumSalary += m.salary ?? 0;

        i++;
      }
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'مسير رواتب');

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    final chunks = chunkList(data, 14);

    //إضافة صفحة إلى المستند
    int start = 1;
    int last = chunks.length;
    for (var chunk in chunks) {
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
                  pw.SizedBox(width: 170),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        """سند مشترك  برواتب شهر  $month
وقد فوض موقعوه أمين الصندوق بقبض استحقاقهم بموجبه
                  """,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 8,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        empType,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 8,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(width: 160),
                  pw.Text(
                    "الصفحة $start من $last",
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
                fontSize: 5,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey600,
              ),
              cellStyle: pw.TextStyle(
                font: arabicFont,
                fontSize: 5,
              ),
              cellAlignment: pw.Alignment.center,
              headerAlignment: pw.Alignment.center,
              columnWidths: {
                0: const pw.FixedColumnWidth(1.4),
                1: const pw.FixedColumnWidth(1.4),
                2: const pw.FixedColumnWidth(1.8),
                3: const pw.FixedColumnWidth(1.8),
                4: const pw.FixedColumnWidth(1.5),
                5: const pw.FixedColumnWidth(1.5),
                6: const pw.FixedColumnWidth(1.5),
                7: const pw.FixedColumnWidth(1.8),
                8: const pw.FixedColumnWidth(2),
                9: const pw.FixedColumnWidth(1.5),
                10: const pw.FixedColumnWidth(1.5),
                11: const pw.FixedColumnWidth(1.5),
                12: const pw.FixedColumnWidth(2),
                13: const pw.FixedColumnWidth(1.2),
                14: const pw.FixedColumnWidth(3.5),
                15: const pw.FixedColumnWidth(5),
                16: const pw.FixedColumnWidth(1.2),
              },
              headers: [
                'ملاحظات',
                'التوقيع',
                'الصافي',
                'المجموع',
                'بنك التسليف',
                'جزاءات',
                'تقاعد 2%',
                'المجموع',
                'بدل غلاء المعيشة',
                'بدل النقل',
                'الراتب المستحق',
                'الراتب الأساسي',
                'رقم الإقامة',
                'الفئة',
                'الوظيفة',
                'الاسم',
                ' م ',
              ],
              data: chunk,
            ),
            if (start == last)
              pw.TableHelper.fromTextArray(
                context: context,
                border: pw.TableBorder.all(color: PdfColors.grey400),
                tableDirection: pw.TextDirection.rtl,
                headerStyle: pw.TextStyle(
                  font: arabicFont,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.white,
                  fontSize: 5,
                ),
                headerDecoration: const pw.BoxDecoration(
                  color: PdfColors.grey600,
                ),
                cellStyle: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 5,
                ),
                cellAlignment: pw.Alignment.center,
                headerAlignment: pw.Alignment.center,
                columnWidths: {
                  0: const pw.FixedColumnWidth(1.4),
                  1: const pw.FixedColumnWidth(1.4),
                  2: const pw.FixedColumnWidth(1.8),
                  3: const pw.FixedColumnWidth(1.8),
                  4: const pw.FixedColumnWidth(1.5),
                  5: const pw.FixedColumnWidth(1.5),
                  6: const pw.FixedColumnWidth(1.5),
                  7: const pw.FixedColumnWidth(1.8),
                  8: const pw.FixedColumnWidth(2),
                  9: const pw.FixedColumnWidth(1.5),
                  10: const pw.FixedColumnWidth(1.5),
                  11: const pw.FixedColumnWidth(1.5),
                  12: const pw.FixedColumnWidth(12.9),
                },
                headers: [
                  "",
                  "",
                  sumSafy.toPrecision(2),
                  sumHasmTotal.toPrecision(2),
                  sumBank.toPrecision(2),
                  sumGza.toPrecision(2),
                  sumTaka3ed.toPrecision(2),
                  sumMosta7qTotal.toPrecision(2),
                  sumMaeesha.toPrecision(2),
                  sumNaqlBadal.toPrecision(2),
                  sumMosta7qSalary.toPrecision(2),
                  sumSalary.toPrecision(2),
                  'الإجمالي',
                ],
                data: [],
              ),
            if (start == last) pw.SizedBox(height: 20),
            if (start == last)
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
                        empName,
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
                        "مدير قسم الشؤون المالية",
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
                  pw.Column(
                    children: [
                      pw.Text(
                        "مدير إدارة الشؤون الإدارية و المالية",
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
                        "رئيس $name",
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
              ),
          ],
        ),
      );
      start++;
    }
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'بيان خدمة موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }

  List<List<T>> chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }
}
