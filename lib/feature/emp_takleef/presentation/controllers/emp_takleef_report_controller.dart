import 'dart:developer';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/emp_takleef/data/model/emp_takleef_det_model.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_controller.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_det_controller.dart';

import '../../../employee/data/repository/employee_repository.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';

class EmpTakleefReportController extends GetxController {
  final EmployeeRepository _employeeRepository;
  final JobsRepository _jobsRepository;

  EmpTakleefReportController(this._employeeRepository, this._jobsRepository);

  // قرار خارج دوام
  Future<void> createQrarTakleefReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpTakleefController controller = Get.find<EmpTakleefController>();
    String takleefDateStart = controller.datBeginGo.text;
    String takleefDay = controller.day.value;
    String takleefPeriod = "";
    String takleefHour = controller.hoursAvg.text;

    EmpTakleefDetController detController = Get.find<EmpTakleefDetController>();
    await detController.getTakleefDetByTakleefId(int.parse(controller.id.text));

    List<List<dynamic>> data = [];

    int i = 1;
    for (EmpTakleefDetModel item in detController.takleefDets) {
      late int jobId;
      late String jobName;
      late String fia;

      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId ?? 0;
        fia = r.fia ?? "";
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      takleefPeriod = (item.period ?? 0).toString();
      data.add(
        [
          item.empWork,
          item.naqlBadal ?? 0,
          item.salary ?? 0,
          fia,
          jobName,
          item.empName ?? "",
          i,
        ],
      );
      i++;
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار خارج دوام");

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
            data: data,
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            """إن رئيس:- $name
بناءً على الصلاحيات الممنوحة له.
واستنادا إلى المادة رقم (26) من نظام الخدمات المدنية و تحقيقاً لمقتضيات مصلحة العمل
يقرر ما يلي:-
1:- يكلف الموظفين الموضحة اسمائهم و بياناتهم أعلاه بالعمل خارج وقت الدوام الرسمي
لمدة $takleefPeriod يوماً / أيام بمعدل ($takleefHour) ساعة / ساعات يوميا لإنهاء العمل المسند إليهم اعتباراً من
يوم $takleefDay الموافق $takleefDateStart م.
2:- يبلغ هذا القرار لمن يلزم لإنفاذه.
""",
            textAlign: pw.TextAlign.start,
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
          ),
          pw.Center(
            child: pw.Text(
              "و السلام عليكم ورحمة الله و بركاته ,,,,,",
              textAlign: pw.TextAlign.start,
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
            ),
          ),
          pw.SizedBox(height: 30),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    "رئيس $name",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 11, lineSpacing: 10),
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

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار خارج دوام.pdf',
    // );
  }

  // مسير خارج دوام
  Future<void> createMoserTakleefReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmpTakleefController controller = Get.find<EmpTakleefController>();
    String takleefDateStart = controller.datBegin.text;
    String takleefDateEnd = controller.datEnd.text;
    String takleefQrarNumber = controller.qrarId.text;
    String takleefQrarDate = controller.datQrar.text;
    String takleefHour = controller.hoursAvg.text;

    EmpTakleefDetController detController = Get.find<EmpTakleefDetController>();
    await detController.getTakleefDetByTakleefId(int.parse(controller.id.text));

    List<List<dynamic>> data = [];

    double totalSalary = 0;
    double totalNqalBadal = 0;
    double totalTakleefDay = 0;
    double totalHour = 0;
    double totalTakleefPrice = 0;
    double totalNqalBadalSafee = 0;
    double totalSafee = 0;

    for (EmpTakleefDetModel item in detController.takleefDets) {
      late int jobId;
      late String jobName;
      late String cardId;
      late String fia;
      late double draga;

      log("employee: ${item.empWork}${item.empName}");

      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId ?? 0;
        cardId = r.cardId ?? "";
        fia = r.fia ?? "";
        draga = r.draga ?? 0;
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      double hourSum = double.parse(takleefHour) * (item.period ?? 0);
      double takleefPrice = ((item.salary ?? 0) / 155) * hourSum;
      double takleefNaqlBadal =
          ((item.naqlBadal ?? 0) / 30) * (item.period ?? 0);

      totalSalary += item.salary ?? 0;
      totalNqalBadal += item.naqlBadal ?? 0;
      totalTakleefDay += item.period ?? 0;
      totalHour += hourSum;
      totalTakleefPrice += takleefPrice;
      totalNqalBadalSafee += takleefNaqlBadal;
      totalSafee += takleefNaqlBadal + takleefPrice;

      data.add(
        [
          cardId,
          "",
          (takleefNaqlBadal + takleefPrice).toPrecision(2),
          takleefNaqlBadal.toPrecision(2),
          takleefPrice.toPrecision(2),
          hourSum.toPrecision(2),
          item.period ?? 0,
          item.naqlBadal ?? 0,
          item.salary ?? 0,
          draga,
          fia,
          jobName,
          item.empName ?? "",
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'مسير خارج دوام');

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
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
                "عن المدة من:      $takleefDateStart      الى      $takleefDateEnd      بموجب قرار رقم      $takleefQrarNumber      و تاريخ      $takleefQrarDate ",
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
            data: data,
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
              8: const pw.FixedColumnWidth(1400),
            },
            headers: [
              '',
              '',
              totalSafee.toPrecision(2),
              totalNqalBadalSafee.toPrecision(2),
              totalTakleefPrice.toPrecision(2),
              totalHour.toPrecision(2),
              totalTakleefDay,
              totalNqalBadal,
              'المجموع:   $totalSalary'
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
          )
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
    //   filename: 'مسير خارج دوام.pdf',
    // );
  }

  // قرار صرف خارج دوام
  Future<void> createQrarSrfTakleefReport() async {
    EmpTakleefController controller = Get.find<EmpTakleefController>();
    EmpTakleefDetController detController = Get.find<EmpTakleefDetController>();
    await detController.getTakleefDetByTakleefId(int.parse(controller.id.text));
    List<List<dynamic>> data = [];
    int i = 1;
    for (EmpTakleefDetModel item in detController.takleefDets) {
      late int jobId;
      late String jobName;
      late String fia;

      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId ?? 0;
        fia = r.fia ?? "";
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      data.add(
        [
          item.empWork,
          item.naqlBadal ?? 0,
          item.salary ?? 0,
          fia,
          jobName,
          item.empName ?? "",
          i,
        ],
      );
      i++;
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار صرف خارج دوام");

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
            data: data,
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
    //   filename: 'قرار صرف خارج دوام.pdf',
    // );
  }
}
