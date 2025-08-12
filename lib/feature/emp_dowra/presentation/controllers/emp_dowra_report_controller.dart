import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import 'emp_dowra_controller.dart';
import 'emp_dowra_det_controller.dart';

class EmpDowraReportController extends GetxController {
  final JobsRepository _jobsRepository;
  final EmployeeRepository _employeeRepository;

  EmpDowraReportController(this._jobsRepository, this._employeeRepository);

  // قرار دورة
  Future<void> createQrarDowraReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String edara = bladiaInfoController.partBoss.text;

    final controller = Get.find<EmpDowraController>();
    String decisionNumber = controller.decisionNumber.text;
    String decisionDate = controller.decisionDate.text;
    String startDate = controller.startDate.text;
    String endDate = controller.endDate.text;
    String courseDays = controller.courseDays.text;

    final detController = Get.find<EmpDowraDetController>();
    List<List<dynamic>> data = [];

    for (var e in detController.dowraDets) {
      int jobId = 0;
      String jobName = "";
      (await _employeeRepository.findById(e.empId ?? 0))
          .fold((l) => l, (r) => jobId = r.jobId ?? 0);
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      data.add([
        e.naqlBadal.getValue(),
        e.salary.getValue(),
        e.fia.getValue(),
        jobName,
        e.empName.getValue()
      ]);
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار دورة");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        // orientation: pw.PageOrientation.landscape,
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
                  "الموضوع: قرار دورة موظف",
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
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(400),
            },
            headers: [
              'بدل النقل',
              'الراتب',
              'المرتبة',
              'الوظيفة',
              'الاسم',
            ],
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Center(
              child: pw.Text(
            "قرار إداري رقم ($decisionNumber) وتاريخ $decisionDate",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          )),
          pw.SizedBox(height: 10),
          pw.Text(
            """إن رئيس بلدية محافظة $name
بناء على الصلاحيات الممنوحة له و نظرا لالتحاق الموضح اسمه و بياناته أعلاه بدوره تدريبية لمدة ($courseDays) أيام / يوم خلال الفترة من $startDate إلى $endDate .
واستنادا للمواد (34/26) و (34/26) من لائحه التدريب يقرر ما يلي:
1:- يصرف للموظف اسمه أعلاه (100%) من راتبه الشهري خلال فتره إلتحاقه بالدورة التدريبية من $startDate ألى $endDate ولمدة ($courseDays) يوما
2:- على الجهة المختصة اعتماد موجبه و انفاذه
""",
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
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          )),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text(
                    "ص للموارد البشرية",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 8, lineSpacing: 10),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "ص للصادر",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 10, lineSpacing: 10),
                  ),
                ],
              ),
              pw.Column(
                children: [
                  pw.Text(
                    "رئيس بلدية مجافظة $name",
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
    //   filename: 'قرار حسم.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }

  // بيان دورة
  Future<void> createBeanDowraReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    final controller = Get.find<EmpDowraController>();
    String extraDays = controller.extraDays.text;

    final detController = Get.find<EmpDowraDetController>();
    List<List<dynamic>> data = [];

    double sumTotal = 0;
    for (var e in detController.dowraDets) {
      int jobId = 0;
      String jobName = "";
      (await _employeeRepository.findById(e.empId ?? 0))
          .fold((l) => l, (r) => jobId = r.jobId ?? 0);
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      double nqalBadalCost = (((e.naqlBadal ?? 0) / 30) *
              int.parse(extraDays == "" ? "0" : extraDays))
          .toPrecision(2);

      double total = ((e.mokafaa ?? 0) +
              nqalBadalCost +
              (e.badalEntidab ?? 0) +
              (e.ticketCost ?? 0))
          .toPrecision(2);

      sumTotal += total;

      data.add([
        "",
        total,
        e.ticketCost.getValue(),
        nqalBadalCost,
        e.badalEntidab.getValue(),
        extraDays,
        e.mokafaa.getValue(),
        e.naqlBadal.getValue(),
        e.salary.getValue(),
        e.fia.getValue(),
        jobName,
        e.empName.getValue()
      ]);
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'بيان دورة');

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
                  "بسم الله الرحمن الرحيم",
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
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(300),
              6: const pw.FixedColumnWidth(250),
              7: const pw.FixedColumnWidth(300),
              8: const pw.FixedColumnWidth(250),
              9: const pw.FixedColumnWidth(250),
              10: const pw.FixedColumnWidth(300),
              11: const pw.FixedColumnWidth(400),
            },
            headers: [
              'التوقيع',
              'المجموع',
              'بدل التذاكر',
              'مقدار بدل النقل',
              'مقدار بدل الإنتداب',
              'عدد أيام الإنتداب',
              'مقدار',
              'بدل النقل',
              'الراتب',
              'المرتبة',
              'المسمى الوظيفي',
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
              0: const pw.FixedColumnWidth(3050),
            },
            headers: ['المجموع:   ${sumTotal.toPrecision(2)}'],
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
              // pw.Column(
              //   children: [
              //     pw.Text(
              //       "رئيس بلدية مجافظة تيماء",
              //       textAlign: pw.TextAlign.center,
              //       style: pw.TextStyle(
              //           font: arabicFont, fontSize: 8, lineSpacing: 10),
              //     ),
              //     pw.SizedBox(height: 20),
              //     pw.Text(
              //       "المهندس / حسن بن عبدالرحيم الغبان",
              //       textAlign: pw.TextAlign.center,
              //       style: pw.TextStyle(
              //           font: arabicFont, fontSize: 10, lineSpacing: 10),
              //     ),
              //   ],
              // ),
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
    //   filename: 'مسير خارج دوام.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
