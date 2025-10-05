import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/app_routes.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../data/model/emp_kashf_tepy_model.dart';
import '../../data/repository/emp_kashf_tepy_repository.dart';

class EmpKashfTepySearchReportController extends GetxController {
  final EmpKashfTepyRepository _repository;

  EmpKashfTepySearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpKashfTepyReportModel> empKashfTepys =
      <EmpKashfTepyReportModel>[].obs;

  get length => empKashfTepys.length;

  RxBool all = true.obs;

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
      all: all.value,
      empId: empId.text.isNotEmpty ? int.parse(empId.text) : null,
      fromDate: fromDate.text,
      toDate: toDate.text,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empKashfTepys(r));
    isLoading(false);
  }

  void clearControllers() {
    all.value = true;
    empId.clear();
    empName.clear();
    fromDate.text = nowHijriDate();
    toDate.text = nowHijriDate();
    fromDateGo.text = nowDate();
    toDateGo.text = nowDate();
    search();
  }

  Future<void> report() async {
    if (empKashfTepys.isEmpty) {
      customSnackBar(title: "تنبيه", message: "لا توجد بيانات", isDone: false);
      return;
    }

    // if (empId.text.isEmpty) {
    //   customSnackBar(
    //       title: "تنبيه", message: "يرجى اختيار موظف", isDone: false);
    //   return;
    // }

    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    List<List<dynamic>> data = [];

    for (EmpKashfTepyReportModel m in empKashfTepys) {
      data.add(
        [
          m.datEnketa3 ?? "",
          m.employeeStatus ?? "",
          m.medicalUnitName ?? "",
          m.medicalUnitType ?? "",
          m.requestDate ?? "",
          m.jobName ?? "",
          m.employeeName ?? "",
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "تقرير بطلب الكشف الطبي للموظفين");

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
            child: pw.Column(
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
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
                    pw.Text(
                      "تقرير بطلب الكشف الطبي للموظفين",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 100),
                  ],
                ),
                pw.SizedBox(height: 8),
                if (empId.text.isNotEmpty)
                  pw.Text(
                    "الاسم: ${this.empName.text ?? ""}",
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 8,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                pw.SizedBox(height: 8),
                if (all.isFalse)
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
              ],
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
              1: const pw.FixedColumnWidth(3),
              2: const pw.FixedColumnWidth(4),
              3: const pw.FixedColumnWidth(4),
              4: const pw.FixedColumnWidth(3),
              5: const pw.FixedColumnWidth(3),
              6: const pw.FixedColumnWidth(4),
            },
            headers: [
              'تاريخ الإنقطاع',
              'حالة الموظف',
              'اسم الوحدة الصحية',
              'نوع الوحدة الصحية',
              'تاريخ الطلب',
              'مسمى الوظيفة',
              'الاسم',
            ],
            data: data,
          ),
        ],
      ),
    );

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
