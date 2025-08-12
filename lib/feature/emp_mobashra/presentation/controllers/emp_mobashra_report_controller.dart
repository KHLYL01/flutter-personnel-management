import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/app_routes.dart';
import '../../../employee/data/repository/employee_repository.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import 'emp_mobashra_controller.dart';

class EmpMobashraReportController extends GetxController {
  final EmployeeRepository _empRepository;
  final JobsRepository _jobsRepository;

  EmpMobashraReportController(this._empRepository, this._jobsRepository);

  // قرار مباشرة
  Future<void> createQrarMobashraReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpMobashraController controller = Get.find<EmpMobashraController>();
    String holidayStartDate = controller.holidayStartDate.text;
    String holidayEndDate = controller.endDate.text;
    String mobashraQrarId = controller.qrarId.text;
    String mobashraQrarDate = controller.qrarDate.text;
    String mobashraDay = controller.day.value;
    String mobashraPeriod = controller.period.text;
    String mobashraPartBoss = controller.partBoss.text;

    String employeeName = controller.empName.text;
    String fia = controller.mrtaba.text;
    String draga = controller.draga.text;
    String salary = controller.salary.text;
    String naqlBadal = controller.naqlBadal.text;

    late int jobId;
    late String jobName;
    late String cardId;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) {
      jobId = r.jobId ?? 0;
      cardId = r.cardId ?? "";
    });

    (await _jobsRepository.findById(id: jobId))
        .fold((l) => l, (r) => jobName = r.name ?? "");

    List<List<dynamic>> data = [
      [
        naqlBadal,
        salary,
        draga,
        fia,
        jobName,
        cardId,
        employeeName,
      ]
    ];

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار مباشرة");

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
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """المكرم مدير الموارد البشرية                                                 المحترم
السلام عليكم ورحمة الله و بركاته ,
إلحاقا لقرارنا الإداري رقم $mobashraQrarId و تاريخ $mobashraQrarDate هـ القاضي بمنح الموضح اسمه اعلاه إجازة أعتيادية من $holidayStartDate هـ إلى $holidayEndDate هـ ولمدة ($mobashraPeriod) يوما و بناء على ما رفعه لنا $mobashraPartBoss بتاريخ $holidayEndDate هـ والذي أفاد فيه عن مباشرة المذكور عمله لدى القسم اعتبارا من يوم $mobashraDay الموافق $holidayEndDate هـ

لذا اعتمدوا التأشير لموجبه
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
              pw.Text(
                """رئيس $name
                
$bossName""",
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
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار حسم.pdf',
    // );
    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مسير راتب افرادي
  Future<void> createMoserRatebEfradyReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmpMobashraController controller = Get.find<EmpMobashraController>();
    String holidayStartDate = controller.holidayStartDate.text;
    String holidayEndDate = controller.endDate.text;
    String mobashraQrarId = controller.qrarId.text;
    String mobashraQrarDate = controller.qrarDate.text;
    String mobashraDay = controller.day.value;
    String mobashraPeriod = controller.period.text;
    String mobashraPartBoss = controller.partBoss.text;

    String employeeName = controller.empName.text;
    String fia = controller.mrtaba.text;
    String draga = controller.draga.text;
    String salary = controller.salary.text;
    String naqlBadal = controller.naqlBadal.text;

    late int jobId;
    late String jobName;
    late double naturalWorkBadal;
    late int kastSalary;
    late double kastNqalBadal;
    late double kastNaturalWorkBadal;
    late double taka3d;
    late int hasmAkary;
    late int hasmTsleef;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) {
      jobId = r.jobId ?? 0;
      naturalWorkBadal = 0;
      kastSalary = r.salary1 ?? 0;
      kastNqalBadal = 0;
      kastNaturalWorkBadal = 0;
      taka3d = r.taka3odM ?? 0;
      hasmAkary = r.hasm1 ?? 0;
      hasmTsleef = r.hasm2 ?? 0;
    });

    (await _jobsRepository.findById(id: jobId))
        .fold((l) => l, (r) => jobName = r.name ?? "");

    double salaryWithBadal =
        naturalWorkBadal + double.parse(salary) + double.parse(naqlBadal);
    double totalkast = kastSalary + kastNaturalWorkBadal + kastNqalBadal;
    double totalHasm = hasmTsleef + hasmAkary + taka3d;

    List<List<dynamic>> data = [
      [
        "",
        totalkast + totalHasm,
        totalHasm,
        hasmTsleef,
        hasmAkary,
        taka3d,
        totalkast,
        kastNaturalWorkBadal,
        kastNqalBadal,
        kastSalary,
        salaryWithBadal,
        naturalWorkBadal,
        naqlBadal,
        salary,
        draga,
        fia,
        jobName,
        employeeName,
        "1",
      ]
    ];

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "مسير راتب افرادي");

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
                pw.SizedBox(width: 190),
                pw.Text(
                  "سند إفرادي يوضح استحقاق الموضح ادناه",
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
                """عن المدة من:      $holidayStartDate      الى      $holidayEndDate
بموجب قرار رقم      $mobashraQrarId      و تاريخ      $mobashraQrarDate
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
              0: const pw.FixedColumnWidth(150),
              1: const pw.FixedColumnWidth(150),
              2: const pw.FixedColumnWidth(160),
              3: const pw.FixedColumnWidth(230),
              4: const pw.FixedColumnWidth(230),
              5: const pw.FixedColumnWidth(150),
              6: const pw.FixedColumnWidth(160),
              7: const pw.FixedColumnWidth(230),
              8: const pw.FixedColumnWidth(230),
              9: const pw.FixedColumnWidth(230),
              10: const pw.FixedColumnWidth(160),
              11: const pw.FixedColumnWidth(230),
              12: const pw.FixedColumnWidth(230),
              13: const pw.FixedColumnWidth(230),
              14: const pw.FixedColumnWidth(130),
              15: const pw.FixedColumnWidth(140),
              16: const pw.FixedColumnWidth(230),
              17: const pw.FixedColumnWidth(300),
              18: const pw.FixedColumnWidth(50),
            },
            headers: [
              'التوقيع',
              'الصافي',
              'المجموع',
              'حسميات التسليف',
              'حسميات العقاري',
              'التقاعد',
              'المجموع',
              'قسط طبيعة العمل',
              'قسط بدل النقل',
              'قسط الراتب',
              'المجموع',
              'بدل طبيعة العمل',
              'بدل النقل',
              'الراتب الاساسي',
              'الدرجة',
              'المرتبة',
              'الوظيفة',
              'الاسم',
              ' م ',
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
              0: const pw.FixedColumnWidth(150),
              1: const pw.FixedColumnWidth(150),
              2: const pw.FixedColumnWidth(160),
              3: const pw.FixedColumnWidth(230),
              4: const pw.FixedColumnWidth(230),
              5: const pw.FixedColumnWidth(150),
              6: const pw.FixedColumnWidth(160),
              7: const pw.FixedColumnWidth(230),
              8: const pw.FixedColumnWidth(230),
              9: const pw.FixedColumnWidth(230),
              10: const pw.FixedColumnWidth(160),
              11: const pw.FixedColumnWidth(230),
              12: const pw.FixedColumnWidth(230),
              13: const pw.FixedColumnWidth(230),
              14: const pw.FixedColumnWidth(850),
            },
            headers: [
              '',
              totalkast + totalHasm,
              totalHasm,
              hasmTsleef,
              hasmAkary,
              taka3d,
              totalkast,
              kastNaturalWorkBadal,
              kastNqalBadal,
              kastSalary,
              salaryWithBadal,
              naturalWorkBadal,
              naqlBadal,
              salary,
              'الإجمالي'
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
              pw.Text(
                """رئيس $name
                
$bossName""",
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
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'استحقاق راتب.pdf',
    // );
    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
