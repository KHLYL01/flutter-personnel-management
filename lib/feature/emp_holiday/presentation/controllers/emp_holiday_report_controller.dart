import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/app_routes.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import '../../../users/presentation/controllers/user_controller.dart';

class EmpHolidayReportController extends GetxController {
  final EmployeeRepository _empRepository;
  final JobsRepository _jobsRepository;

  EmpHolidayReportController(this._empRepository, this._jobsRepository);

  // قرار إجازة
  Future<void> createQrarHolidayReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String boss = bladiaInfoController.boss.text;
    String bossAssistant = bladiaInfoController.bossAssistant.text;

    EmpHolidayController controller = Get.find<EmpHolidayController>();
    String empName = controller.empName.text;
    String empFia = controller.mrtaba.text;
    String empDraga = controller.draga.text;
    String empSalary = controller.salary.text;
    String empNqalBadal = controller.naqlBadal.text;

    String holidayQrarId = controller.qrarId.text;
    String holidayQrarDate = controller.qrarDate.text;
    String holidayType = controller.holidayTypeName.text;
    String holidayDay = controller.period.text;
    String holidayStartDate = controller.startDate.text;
    String holidayEndDate = controller.endDate.text;
    String holidaySarf =
        controller.sarf.value == "لا أرغب بصرف راتبها مقدما" ? "لا " : "";

    late int jobId;
    late String jobName;
    late String cardId;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) {
      jobId = r.jobId!;
      cardId = r.cardId!;
    });
    (await _jobsRepository.findById(id: jobId))
        .fold((l) => l, (r) => jobName = r.name!);

    List<List<dynamic>> data = [
      [
        empNqalBadal,
        empSalary,
        empDraga,
        empFia,
        jobName,
        cardId,
        empName,
      ]
    ];

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
                  'إدارة الموارد البشرية',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  'الموضوع: إجازة موظف',
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
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
              0: const pw.FixedColumnWidth(130),
              1: const pw.FixedColumnWidth(130),
              2: const pw.FixedColumnWidth(130),
              3: const pw.FixedColumnWidth(130),
              4: const pw.FixedColumnWidth(120),
              5: const pw.FixedColumnWidth(250),
              6: const pw.FixedColumnWidth(300),
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

          pw.SizedBox(height: 30),

          // نص ختامي
          pw.Text(
            """إن رئيس $name
بناءً على الصلاحيات الممنوحة لة بالقرار الاداري رقم ($holidayQrarId) وتاريخ $holidayQrarDate هـ .
و إشارة إلى طلب الإجازة المرفق من الموضح اسمه و بياناته أعلاه وبناء على
المادة (130) من اللائحة التنفيذية للموارد البشرية بنظام الخدمة المدنية, يقرر ما يلي:

1- الموافقة على تمتع الموظف أعلاه منحة إجازة $holidayType لمدة ($holidayDay)  يوماً / أيام
اعتباراً من: $holidayStartDate هـ إلى $holidayEndDate هـ
2- $holidaySarfيصرف راتبه/ها مقدما
3- يكلف الموظف /  $empName للقيام بعمله لحين الانتهاء من الإجازة. 
4- يبلغ هذا القرار لمن يلزم لإنفاذه

""",
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
          ),

          pw.Center(
            child: pw.Text(
              "والسلام عليكم ورحمة الله و بركاته ....",
              style:
                  pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Text(
                """رئيس $name

$boss""",
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
    //   filename: 'قرار إجازة.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // مسير إجازة
  Future<void> createMoserHolidayReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = Get.find<UserController>().userEmpName;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmpHolidayController controller = Get.find<EmpHolidayController>();
    String holidayStartDate = controller.startDate.text;
    String holidayEndDate = controller.endDate.text;
    String holidayQrarId = controller.qrarId.text;
    String holidayQrarDate = controller.qrarDate.text;
    String holidayPeriod = controller.period.text;

    String employeeName = controller.empName.text;
    String fia = controller.mrtaba.text;
    String draga = controller.draga.text;
    String salary = controller.salary.text;
    String naqlBadal = controller.naqlBadal.text;

    late int jobId;
    late String jobName;
    late double naturalWorkBadal;
    late double kastSalary;
    late double kastNqalBadal;
    late double kastNaturalWorkBadal;
    late double taka3d;
    late double hasmAkary;
    late double hasmTsleef;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) {
      jobId = r.jobId ?? 0;
      naturalWorkBadal = r.jobbadalat ?? 0;
      kastSalary =
          (((r.salary ?? 0) / 30) * int.parse(holidayPeriod)).toPrecision(2);
      kastNqalBadal =
          (((r.naqlBadal ?? 0) / 30) * int.parse(holidayPeriod)).toPrecision(2);
      kastNaturalWorkBadal =
          (((r.jobbadalat ?? 0) / 30) * int.parse(holidayPeriod))
              .toPrecision(2);
      hasmAkary = r.sandok ?? 0;
      hasmTsleef = r.dissent ?? 0;

      if (hasmTsleef == 0 && hasmAkary == 0) {
        taka3d = 0;
      } else {
        taka3d = (r.salary ?? 0) * 9 / 100;
      }
    });

    (await _jobsRepository.findById(id: jobId))
        .fold((l) => l, (r) => jobName = r.name ?? "");

    double totalSalary =
        (naturalWorkBadal + double.parse(salary) + double.parse(naqlBadal))
            .toPrecision(2);
    double totalkast =
        (kastSalary + kastNaturalWorkBadal + kastNqalBadal).toPrecision(2);
    double totalHasm = (hasmTsleef + hasmAkary + taka3d).toPrecision(2);

    List<List<dynamic>> data = [
      [
        "",
        (totalSalary + totalkast - totalHasm).toPrecision(2),
        totalHasm,
        hasmTsleef.toPrecision(2),
        hasmAkary.toPrecision(2),
        taka3d.toPrecision(2),
        totalkast,
        kastNaturalWorkBadal.toPrecision(2),
        kastNqalBadal.toPrecision(2),
        kastSalary,
        totalSalary.toPrecision(2),
        naturalWorkBadal.toPrecision(2),
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
    final pdf = pw.Document(title: "مسير إجازة");

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
                pw.SizedBox(width: 150),
                pw.Text(
                  """بسم الله الرحمن الرحيم

سند إفرادي يوضح استحقاق الموضح ادناه لقاء
عن المدة من $holidayStartDate هـ وتاريخ انتهاء الإجازة إعتباراٌ $holidayEndDate هـ
بموجب القرار رقم $holidayQrarId وتاريخ $holidayQrarDate""",
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
              0: const pw.FixedColumnWidth(150),
              1: const pw.FixedColumnWidth(180),
              2: const pw.FixedColumnWidth(180),
              3: const pw.FixedColumnWidth(230),
              4: const pw.FixedColumnWidth(230),
              5: const pw.FixedColumnWidth(150),
              6: const pw.FixedColumnWidth(180),
              7: const pw.FixedColumnWidth(230),
              8: const pw.FixedColumnWidth(230),
              9: const pw.FixedColumnWidth(230),
              10: const pw.FixedColumnWidth(180),
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
              ' م',
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
              1: const pw.FixedColumnWidth(180),
              2: const pw.FixedColumnWidth(180),
              3: const pw.FixedColumnWidth(230),
              4: const pw.FixedColumnWidth(230),
              5: const pw.FixedColumnWidth(150),
              6: const pw.FixedColumnWidth(180),
              7: const pw.FixedColumnWidth(230),
              8: const pw.FixedColumnWidth(230),
              9: const pw.FixedColumnWidth(230),
              10: const pw.FixedColumnWidth(180),
              11: const pw.FixedColumnWidth(230),
              12: const pw.FixedColumnWidth(230),
              13: const pw.FixedColumnWidth(230),
              14: const pw.FixedColumnWidth(850),
            },
            headers: [
              ' ',
              totalSalary + totalkast - totalHasm,
              totalHasm,
              hasmTsleef,
              hasmAkary,
              taka3d,
              totalkast,
              kastNaturalWorkBadal,
              kastNqalBadal,
              kastSalary,
              totalSalary,
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
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    // final blob = html.Blob([pdfBytes], 'application/pdf');
    // final url = html.Url.createObjectUrlFromBlob(blob);
    // html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'مسير إجازة.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
