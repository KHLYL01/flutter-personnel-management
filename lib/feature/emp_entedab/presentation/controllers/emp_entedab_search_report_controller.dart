import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/core/functions/custom_snack_bar.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../data/model/emp_entedab_model.dart';
import '../../data/repository/emp_entedab_repository.dart';

class EmpEntedabSearchReportController extends GetxController {
  final EmpEntedabRepository _repository;

  EmpEntedabSearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpEntedabReportModel> empEntedabs = <EmpEntedabReportModel>[].obs;

  get length => empEntedabs.length;

  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController fromDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController toDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController fromDateGo =
      TextEditingController(text: nowDate());
  final TextEditingController toDateGo = TextEditingController(text: nowDate());

  Future<void> search() async {
    isLoading(true);
    messageError("");
    final data = await _repository.report(
      empId: empId.text.isNotEmpty ? int.parse(empId.text) : null,
      fromDate: fromDateGo.text,
      toDate: toDateGo.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empEntedabs(r));
    isLoading(false);
  }

  void clearControllers() {
    empId.clear();
    empName.clear();
    fromDate.text = nowHijriDate();
    toDate.text = nowHijriDate();
    fromDateGo.text = nowDate();
    toDateGo.text = nowDate();
    search();
  }

  Future<void> report() async {
    if (empEntedabs.isEmpty) {
      customSnackBar(title: "تنبيه", message: "لا توجد بيانات", isDone: false);
      return;
    }

    if (empId.text.isEmpty) {
      customSnackBar(
          title: "تنبيه", message: "يرجى اختيار موظف", isDone: false);
      return;
    }

    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    List<List<dynamic>> data = [];

    for (EmpEntedabReportModel m in empEntedabs) {
      data.add([
        "",
        m.entedabPlace,
        60 - ((m.period ?? 0) + (m.prevPeriod ?? 0)),
        (m.period ?? 0) + (m.prevPeriod ?? 0),
        m.period ?? 0,
        m.prevPeriod ?? 0,
        "60 يوماً",
        m.assignmentStartDate,
        m.id,
      ]);
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "تقرير الانتدابات");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            decoration: const pw.BoxDecoration(
              border: pw.Border.fromBorderSide(pw.BorderSide.none),
            ),
            child: pw.Column(
              children: [
                pw.Center(
                  child: pw.Text(
                    "سجل الإنتداب",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Center(
                  child: pw.Text(
                    "الفترة من ${fromDate.text} هـ  إلى ${toDate.text} هـ ",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "الجهة: $name",
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 8,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        if (empId.text.isNotEmpty)
                          pw.Text(
                            "الاسم: ${empEntedabs.first.employeeName ?? ""}",
                            style: pw.TextStyle(
                              font: arabicFont,
                              fontSize: 8,
                              lineSpacing: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 16),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "الإدارة: الموارد البشرية",
                            style: pw.TextStyle(
                              font: arabicFont,
                              fontSize: 8,
                              lineSpacing: 10,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          if (empId.text.isNotEmpty)
                            pw.Text(
                              "المرتبة: ${empEntedabs.first.fia ?? ""}",
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
                    pw.Text(
                      """السنة المالية: ....................................
رقمها: ....................................""",
                      textAlign: pw.TextAlign.end,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        lineSpacing: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                )
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
              0: const pw.FixedColumnWidth(2),
              1: const pw.FixedColumnWidth(2),
              2: const pw.FixedColumnWidth(2.5),
              3: const pw.FixedColumnWidth(2),
              4: const pw.FixedColumnWidth(3),
              5: const pw.FixedColumnWidth(3),
              6: const pw.FixedColumnWidth(4),
              7: const pw.FixedColumnWidth(2),
              8: const pw.FixedColumnWidth(2),
            },
            headers: [
              'ايضاحات',
              'جهة الإنتداب',
              'الرصيد المتبقي',
              'المجموع',
              'مدة الانتداب الحالية',
              'مدة الانتداب السابقة',
              'رصيد ثابت للسنة المالية',
              'تاريخه',
              'رقم الانتداب',
            ],
            data: data,
          ),
          pw.SizedBox(height: 16),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(
                """كاتب التأدية            
الاسم: ....................................
التوقيع: ....................................""",
                textAlign: pw.TextAlign.end,
                style: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 8,
                  lineSpacing: 8,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(width: 64),
              pw.Text(
                """ مدير الموارد البشرية            
الاسم: ....................................
التوقيع: ....................................""",
                textAlign: pw.TextAlign.end,
                style: pw.TextStyle(
                  font: arabicFont,
                  fontSize: 8,
                  lineSpacing: 8,
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

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    // Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
