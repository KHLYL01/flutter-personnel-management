import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/tafweed/presentation/controllers/tafweed_controller.dart';
import 'package:personnel_management/feature/tarmeez_nations/data/repository/nations_repository.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../employee/data/repository/employee_repository.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';

class TafweedReportController extends GetxController {
  final EmployeeRepository _empRepository;
  final JobsRepository _jobsRepository;
  final NationsRepository _nationsRepository;

  TafweedReportController(
      this._empRepository, this._jobsRepository, this._nationsRepository);
  // التقرير
  Future<void> createReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    TafweedController controller = Get.find<TafweedController>();
    String subject = controller.subject.text;
    String day = controller.selectedDay.value;
    String startDate = controller.startDate.text;
    String endDate = controller.endDate.text;
    String notes = controller.note.text;

    String employeeName = controller.empName.text;

    late int jobId = 0;
    late int nationId = 0;

    late String jobName = "";
    late String cardId = "";
    late String nationName = "";

    (await _empRepository.findById(int.parse(
            controller.empId.text == "" ? "0" : controller.empId.text)))
        .fold((l) => l, (r) {
      jobId = r.jobId ?? 0;
      nationId = r.nationId ?? 0;
      cardId = r.cardId ?? "";
    });

    (await _jobsRepository.findById(id: jobId))
        .fold((l) => l, (r) => jobName = r.name ?? "");
    (await _nationsRepository.findById(id: nationId))
        .fold((l) => l, (r) => nationName = r.name ?? "");

    List<List<dynamic>> data = [
      [
        nationName,
        cardId,
        jobName,
        employeeName,
      ],
    ];

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "التقرير");

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
                  "الموضوع: $subject",
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
              0: const pw.FixedColumnWidth(200),
              1: const pw.FixedColumnWidth(200),
              2: const pw.FixedColumnWidth(200),
              3: const pw.FixedColumnWidth(200),
            },
            headers: [
              'الجنسية',
              'الوظيفة',
              'رقم السجل المدني',
              'الاسم',
            ],
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """تشهد $name بأن الموضح اسمه و بياناته اعلاه هو أحد منسوبيها و لازال على رأس عمله حتى تاريخه و يرغب اعتبارا من يوم $day الموافق $startDate هـ و حتى $endDate هـ و حيث لا مانع لدينا من تفويضه $subject  ,  $notes آمل تسهيل مروره.""",
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
}
