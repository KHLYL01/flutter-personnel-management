import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../data/model/emp_holiday_model.dart';
import '../../data/repository/emp_holiday_repository.dart';

class EmpHolidaySearchReportController extends GetxController {
  final EmpHolidayRepository _repository;

  EmpHolidaySearchReportController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpHolidayReportModel> empHolidays = <EmpHolidayReportModel>[].obs;

  get length => empHolidays.length;

  RxBool isAll = true.obs;

  final TextEditingController empId = TextEditingController();
  final TextEditingController empName = TextEditingController();
  final TextEditingController fromDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController toDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController fromDateGo =
      TextEditingController(text: nowDate());
  final TextEditingController toDateGo = TextEditingController(text: nowDate());
  final TextEditingController fromPeriod = TextEditingController(text: "0");
  final TextEditingController toPeriod = TextEditingController(text: "0");
  final TextEditingController holidayTypeId = TextEditingController();
  final TextEditingController holidayType = TextEditingController();

  final TextEditingController dayDate =
      TextEditingController(text: nowHijriDate());
  final TextEditingController startWorkDate =
      TextEditingController(text: nowHijriDate());
  String empType = "";
  int takenHoliday = 0;

  Future<void> search() async {
    isLoading(true);
    messageError("");
    final data = await _repository.report(
      all: isAll.value,
      empId: empId.text.isNotEmpty ? int.parse(empId.text) : null,
      fromDate: fromDate.text,
      toDate: toDate.text,
      fromPeriod:
          fromPeriod.text.isNotEmpty ? int.parse(fromPeriod.text) : null,
      toPeriod: toPeriod.text.isNotEmpty ? int.parse(toPeriod.text) : null,
      holidayType:
          holidayTypeId.text.isNotEmpty ? int.parse(holidayTypeId.text) : null,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => empHolidays(r));
    isLoading(false);
  }

  void clearControllers() {
    isAll.value = true;
    empId.clear();
    empName.clear();
    fromDate.text = nowHijriDate();
    toDate.text = nowHijriDate();
    dayDate.text = nowHijriDate();
    startWorkDate.text = nowHijriDate();
    fromDateGo.text = nowDate();
    toDateGo.text = nowDate();
    fromPeriod.text = "0";
    toPeriod.text = "0";
    holidayTypeId.clear();
    holidayType.clear();
    search();
  }

  Future<void> report() async {
    if (empHolidays.isEmpty) {
      customSnackBar(title: "تنبيه", message: "لا توجد بيانات", isDone: false);
      return;
    }
    //
    // if (empId.text.isEmpty) {
    //   customSnackBar(
    //       title: "تنبيه", message: "يرجى اختيار موظف", isDone: false);
    //   return;
    // }

    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = Get.find<UserController>().userEmpName;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    double sum = 0; // مجموع الإجازات

    int all = 0,
        have = 0,
        remain = 0,
        lblAllNew = 0,
        lblHaveNew = 0,
        lblRemainNew = 0,
        mofarareqHave = 0,
        mofarareqRemain = 0,
        allAll = 0,
        haveHave = 0,
        remainRemain = 0;

    List<List<dynamic>> data = [];

    for (EmpHolidayReportModel m in empHolidays) {
      data.add(
        [
          m.holidayEndDate ?? "",
          m.holidayStartDate ?? "",
          m.period ?? "",
          m.holidayType ?? "",
          m.draga ?? "",
          m.fia ?? "",
          m.jobName ?? "",
          m.employeeName ?? "",
        ],
      );
      sum += (m.period ?? 0);
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "تقرير بيان إجازات الموظفين");

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
                      "تقرير بيان إجازات الموظفين",
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
                if (isAll.isFalse)
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
              0: const pw.FixedColumnWidth(3),
              1: const pw.FixedColumnWidth(3),
              2: const pw.FixedColumnWidth(2),
              3: const pw.FixedColumnWidth(3),
              4: const pw.FixedColumnWidth(1),
              5: const pw.FixedColumnWidth(1),
              6: const pw.FixedColumnWidth(3),
              7: const pw.FixedColumnWidth(4),
            },
            headers: [
              'تاريخ نهاية الإجازة',
              'تاريخ بداية الإجازة',
              'المدة',
              'نوع الإجازة',
              'الدرجة',
              'المرتبة',
              'مسمى الوظيفة',
              'الاسم',
            ],
            data: data,
          ),
          pw.SizedBox(height: 4),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: 200,
                child: pw.TableHelper.fromTextArray(
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
                    2: const pw.FixedColumnWidth(2),
                    3: const pw.FixedColumnWidth(3),
                  },
                  headers: [
                    'باقي',
                    'متمتع',
                    'رصيد كلي',
                    'نوع الإجازة',
                  ],
                  data: [
                    [remain, have, all, "اعتيادي قديم قبل 11/7 1439"],
                    [lblRemainNew, lblHaveNew, lblAllNew, "اعتيادي سنوي"],
                    [mofarareqRemain, mofarareqHave, 10, "اعتبادي متفرق"],
                    [remainRemain, haveHave, allAll, "اعتيادي كلي"],
                  ],
                ),
              ),
              pw.SizedBox(width: 50),
              pw.Text(
                "مجموع الإجازات في التقرير $sum",
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
          pw.SizedBox(height: 16),
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

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
