import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/constants/app_routes.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../data/model/employee_model.dart';
import '../../data/repository/employee_repository.dart';

class EmployeeSearchReportController extends GetxController {
  final EmployeeRepository _repository;

  EmployeeSearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmployeeReportModel> employees = <EmployeeReportModel>[].obs;

  get length => employees.length;

  final TextEditingController partId = TextEditingController();
  final TextEditingController partName = TextEditingController();

  RxString jobState = "مشغولة".obs;

  final List<String> jobStateList = [
    "مشغولة",
    "مشغولة ومتوقف عن العمل",
    "شاغرة",
  ];

  void onChangedJobState(String? value) {
    jobState(value!);
  }

  RxString empType = "موظف".obs;

  final List<String> empTypeList = [
    "موظف",
    "مستخدم",
    "عامل بند إجور",
    "عامل أجنبي",
  ];

  void onChangedJobWork(String? value) {
    empType(value!);
  }

  Future<void> search() async {
    isLoading(true);
    messageError("");
    final data = await _repository.report(
      partId: partId.text.isEmpty ? null : int.parse(partId.text),
      jobState: jobState.value,
      empType: empType.value,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => employees(r));
    isLoading(false);
  }

  void clearControllers() {
    partId.clear();
    partName.clear();
    jobState("مشغولة");
    empType("موظف");
    search();
  }

  Future<void> report() async {
    if (employees.isEmpty) {
      customSnackBar(title: "تنبيه", message: "لا توجد بيانات", isDone: false);
      return;
    }

    // if (empId.text.isEmpty) {
    //   customSnackBar(
    //       title: "تنبيه", message: "يرجى اختيار موظف", isDone: false);
    //   return;
    // }

    String? type = switch (empType.value) {
      "موظف" => "الموظفين",
      "مستخدم" => "المستخدمين",
      "عامل بند إجور" => "عمال بند الإجور",
      "عامل أجنبي" => "العمال الأجانب",
      String() => null,
    };

    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    List<List<dynamic>> data = [];

    int i = 1;
    for (EmployeeReportModel m in employees) {
      data.add(
        [
          m.salary ?? "",
          m.education ?? "",
          m.datJob ?? "",
          m.datWork ?? "",
          m.datBok ?? "",
          m.cardId ?? "",
          m.jobState ?? "",
          m.jobName ?? "",
          m.draga ?? "",
          m.fia ?? "",
          m.name ?? "",
          i,
        ],
      );
      i++;
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "تقرير بيانات $type");

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
                  "تقرير بيانات $type",
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
              0: const pw.FixedColumnWidth(3),
              1: const pw.FixedColumnWidth(3),
              2: const pw.FixedColumnWidth(3),
              3: const pw.FixedColumnWidth(3),
              4: const pw.FixedColumnWidth(2),
              5: const pw.FixedColumnWidth(3),
              6: const pw.FixedColumnWidth(3),
              7: const pw.FixedColumnWidth(3),
              8: const pw.FixedColumnWidth(2),
              9: const pw.FixedColumnWidth(2),
              10: const pw.FixedColumnWidth(4),
              11: const pw.FixedColumnWidth(1),
            },
            headers: [
              'الراتب الأساسي',
              'المؤهل العلمي',
              'تاريخ شغل الوظيفة',
              'تاريخ بداية الخدمة',
              'تاريخ الحفيظة',
              'رقم السجل المدني',
              'حالة الوظيفة',
              'مسمى الوظيفة',
              'الدرجة',
              'المرتبة',
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

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
