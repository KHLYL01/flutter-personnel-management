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
import '../../data/model/emp_mokhalfat_det_model.dart';
import 'emp_mokhalfat_controller.dart';
import 'emp_mokhalfat_det_controller.dart';

class EmpMokhalfatReportController extends GetxController {
  final EmployeeRepository _employeeRepository;
  final JobsRepository _jobsRepository;

  EmpMokhalfatReportController(this._employeeRepository, this._jobsRepository);

  // بيان مخالفة
  Future<void> createBeanMokhalfatReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpMokhalfatController controller = Get.find<EmpMokhalfatController>();
    String mokhalfatType = controller.mokhalfaType.value;
    String mokhalfatStartDate = controller.startDate.text;
    String mokhalfatEndDate = controller.endDate.text;
    String mokhalfatDescription = controller.description.text;

    EmpMokhalfatDetController detController =
        Get.find<EmpMokhalfatDetController>();
    await detController
        .getMokhalfatDetByMokhalfatId(int.parse(controller.id.text));

    List<List<dynamic>> data = [];

    for (EmpMokhalfatDetModel item in detController.mokhalfatDets) {
      late int jobId;
      late String jobName;
      late String cardId;

      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId ?? 0;
        cardId = r.cardId ?? "";
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");
      data.add(
        [
          item.gza ?? 0,
          mokhalfatEndDate,
          mokhalfatStartDate,
          mokhalfatType,
          item.fia ?? "",
          jobName,
          cardId,
          item.empName ?? "",
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "بيان مخالفة");

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
                  'الموضوع: بيان مخالفة',
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
              0: const pw.FixedColumnWidth(250),
              1: const pw.FixedColumnWidth(250),
              2: const pw.FixedColumnWidth(250),
              3: const pw.FixedColumnWidth(250),
              4: const pw.FixedColumnWidth(250),
              5: const pw.FixedColumnWidth(250),
              6: const pw.FixedColumnWidth(300),
              7: const pw.FixedColumnWidth(300),
            },
            headers: [
              'أيام الجزاء',
              'الفترة إلى',
              'الفترة من',
              'النوع',
              'المرتبة',
              'مسمى الوظيفة',
              'رقم السجل المدني',
              'الاسم',
            ],
            data: data,
          ),
          pw.SizedBox(height: 30),

          // نص ختامي
          pw.Text(
            mokhalfatDescription,
            style:
                pw.TextStyle(font: arabicFont, fontSize: 11, lineSpacing: 10),
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
    //   filename: 'بيان مخالفة.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
