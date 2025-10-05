import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/constants/app_routes.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/custom_snack_bar.dart';
import '../../../pdf_viewer/presentation/controllers/pdf_viewer_controller.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../data/model/emp_services_model.dart';
import '../../data/repository/emp_services_repository.dart';
import 'employee_controller.dart';

class EmpServicesController extends GetxController {
  final EmpServicesRepository _repository;

  EmpServicesController(this._repository);

  RxString messageError = "".obs;
  RxBool isLoading = false.obs;

  RxList<EmpServicesModel> list = <EmpServicesModel>[].obs;

  get length => list.length;

  TextEditingController empId = TextEditingController();

  TextEditingController id = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController martaba = TextEditingController();
  TextEditingController mNum = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController datB = TextEditingController();
  TextEditingController datE = TextEditingController();
  TextEditingController reasons = TextEditingController();
  TextEditingController amrNo = TextEditingController();
  TextEditingController datAmr = TextEditingController();
  TextEditingController nots = TextEditingController();

  Future<void> findAllByEmployeeId() async {
    isLoading(true);
    messageError("");
    final data = await _repository.search(
      empId: empId.text.isNotEmpty ? int.parse(empId.text) : 0,
    );
    data.fold((l) => messageError(l.eerMessage), (r) => list(r));
    isLoading(false);
  }

  Future<void> save() async {
    isLoading(true);
    messageError("");
    final data = await _repository.save(
      EmpServicesModel(
        empId: int.parse(empId.text),
        salary: double.parse(salary.text),
        amrNo: amrNo.text,
        datAmr: datAmr.text,
        datB: datB.text,
        datE: datE.text,
        martaba: martaba.text,
        mnum: mNum.text,
        place: place.text,
        reasons: reasons.text,
        nots: nots.text,
        job: job.text,
      ),
    );
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      customSnackBar(title: 'تم', message: 'تمت العملية بنجاح');
      findAllByEmployeeId();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  Future<void> delete(int id) async {
    isLoading(true);
    messageError("");
    final data = await _repository.delete(id);
    data.fold((l) => messageError(l.eerMessage), (r) => r);
    isLoading(false);
    if (messageError.isEmpty) {
      customSnackBar(title: 'تم', message: 'تم الحذف بنجاح');
      findAllByEmployeeId();
      return;
    }
    customSnackBar(title: 'خطأ', message: messageError.value, isDone: false);
  }

  void confirmDelete(int id, {bool withGoBack = true}) async {
    await alertDialog(
      title: 'تحذير',
      middleText: "هل تريد حذف الوظيفة بالفعل",
      onPressedConfirm: () {
        if (withGoBack) {
          Get.back();
        }
        delete(id);
      },
    );
  }

  clearControllers() {
    id.clear();
    job.clear();
    martaba.clear();
    mNum.clear();
    salary.clear();
    place.clear();
    datB.clear();
    datE.clear();
    reasons.clear();
    amrNo.clear();
    datAmr.clear();
    nots.clear();
  }

  // بيان خدمة موظف
  report() async {
    if (list.isEmpty) {
      customSnackBar(title: "تنبيه", message: "لا يوجد بيانات");
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

    EmployeeController controller = Get.find<EmployeeController>();
    String employeeName = controller.name.text;
    String employeeCardNumber = controller.cardNo.text;
    String employeeCardDate = controller.cardStart.text;
    String employeeCardPlace = name.split(" ").last;
    // String employeeJobName = controller.jobName.text;
    // String employeeMartba = controller.fia.text;
    // String employeeJobNo = controller.jobNo.text;
    // String employeeSalary = controller.salary.text;
    // String place = "";
    // String khedmaFrom = "";
    // String khedmaTo = "";
    // String numberOfAmr = "";
    // String dateOfAmr = "";

    List<List<dynamic>> data = [];

    for (EmpServicesModel m in list) {
      data.add(
        [
          m.nots ?? "",
          m.datAmr ?? "",
          m.amrNo ?? "",
          m.datE ?? "",
          m.datB ?? "",
          m.place ?? "",
          m.salary ?? "",
          m.mnum ?? "",
          m.martaba ?? "",
          m.job ?? "",
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: 'بيان خدمة موظف');

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
                pw.SizedBox(width: 100),
                pw.Text(
                  "بيان بخدمات الموظف $employeeName بطاقة رقم $employeeCardNumber تاريخها $employeeCardDate مصدرها $employeeCardPlace",
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
              0: const pw.FixedColumnWidth(200),
              1: const pw.FixedColumnWidth(400),
              2: const pw.FixedColumnWidth(400),
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(200),
              6: const pw.FixedColumnWidth(200),
              7: const pw.FixedColumnWidth(200),
              8: const pw.FixedColumnWidth(200),
              9: const pw.FixedColumnWidth(300),
            },
            headers: [
              'الملاحظات',
              'تاريخ الامر المستند إليه',
              'رقم الامر المستند إليه',
              'الخدمة إلى',
              'الخدمة من',
              'الجهة',
              'الراتب',
              'رقمها',
              'المرتبة',
              'الوظيفة',
            ],
            data: data,
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
    //   filename: 'بيان خدمة موظف.pdf',
    // );

    Get.find<CustomPdfViewerController>().pdfData(pdfBytes);
    Get.find<CustomPdfViewerController>().rotatePdf();
    Get.toNamed(AppRoutes.pdfViewer);
  }
}
