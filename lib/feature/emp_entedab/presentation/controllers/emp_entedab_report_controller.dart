import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:personnel_management/feature/emp_entedab/data/model/emp_entedab_det_model.dart';
import 'package:personnel_management/feature/emp_entedab/presentation/controllers/emp_entedab_controller.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:personnel_management/feature/tarmeez_jobs/data/repository/jobs_repository.dart';
import 'package:printing/printing.dart';

import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import 'emp_entedab_det_controller.dart';

class EmpEntedabReportController extends GetxController {
  final EmployeeRepository _employeeRepository;
  final JobsRepository _jobsRepository;

  EmpEntedabReportController(this._employeeRepository, this._jobsRepository);

  // امر اركاب
  Future<void> createAmrErkabReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String edara = bladiaInfoController.partBoss.text;

    EmpEntedabController controller = Get.find<EmpEntedabController>();
    String entedabNumber = controller.qrarId.text;
    String entedabDate = controller.datQrar.text;
    String entedabPlace = controller.place.text;
    String entedabTakleefNumber = controller.khetabId.text;
    String entedabTakleefDate = controller.datKhrtab.text;
    String entedabPeriod = controller.period.text;
    String entedabStartDate = controller.datBegin.text;
    String entedabEndDate = controller.datEnd.text;
    String entedabWaselTsafar = controller.waselTsafar.value;
    bool travelVehicleTameen = controller.travelVehicleTameen.value;
    bool usingCar = controller.usingCar.value;
    bool workOutDawam = controller.workOutDawam.value;
    bool housingOrFood = controller.housingOrFood.value;
    bool solfahNaqdeah = controller.solfahNaqdeah.value;
    String entedabDistence = controller.distance.text;

    EmpEntedabDetController detController = Get.find<EmpEntedabDetController>();

    List<List<dynamic>> data = [];

    for (EmpEntedabDetModel item in detController.entedabDets) {
      late int jobId;
      late String jobName;
      (await _employeeRepository.findById(item.empId!))
          .fold((l) => l, (r) => jobId = r.jobId!);
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name!);

      data.add(
        [
          '',
          60 - (int.parse(entedabPeriod) + (item.prev ?? 0)),
          int.parse(entedabPeriod) + (item.prev ?? 0),
          entedabPeriod,
          item.prev ?? 0,
          '60 يوم',
          item.naqlBadal ?? 0,
          item.salary ?? 0,
          item.fia,
          jobName,
          item.empName,
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "امر اركاب");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    if (detController.entedabDets.length <= 8) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl, // للغة العربية
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // عنوان التقرير
                  pw.Header(
                    level: 0,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border.fromBorderSide(pw.BorderSide.none),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          """المملكة العربية السعودية
وزارة الشئون البلدية والقروية
$name""",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 6,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(width: 50),
                        pw.Text(
                          """بسم الله الرحمن الرحيم""",
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
                  pw.SizedBox(height: 20),
                  pw.Row(
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
                        "الموضوع : إركاب موظف",
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
                  pw.SizedBox(height: 10),
                  pw.Center(
                    child: pw.Text(
                      "رقم قرار الأنتداب: $entedabNumber تاريخه $entedabDate جهه الأنتداب $entedabPlace",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Center(
                    child: pw.Text(
                      "البيانات الموضحة أدناه صحيحة و على مسؤوليتي",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
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
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(200),
                      3: const pw.FixedColumnWidth(200),
                      4: const pw.FixedColumnWidth(200),
                      5: const pw.FixedColumnWidth(200),
                      6: const pw.FixedColumnWidth(200),
                      7: const pw.FixedColumnWidth(200),
                      8: const pw.FixedColumnWidth(200),
                      9: const pw.FixedColumnWidth(300),
                      10: const pw.FixedColumnWidth(450),
                    },
                    headers: [
                      'التوقيع',
                      'الرصيد المتبقي',
                      'مدة الانتداب المجموع',
                      'مدة الانتداب الحالية',
                      'مدة الانتداب السابقة',
                      'الرصيد الثابت للسنة المالية',
                      'بدل النقل',
                      'الراتب',
                      'المرتبة',
                      'الوظيفة',
                      'الاسم',
                    ],
                    data: data,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    """رقم أمر التكليف $entedabTakleefNumber تاريخه $entedabTakleefDate مدة المهمة $entedabPeriod 
تاريخ السفر الفعلي : $entedabStartDate تاريخ العودة $entedabEndDate
""",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        "وسيلة السفر",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "الطائرة" == entedabWaselTsafar,
                        name: '1',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "الطائرة",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "القطار" == entedabWaselTsafar,
                        name: '2',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "القطار",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "سيارة حكومية" == entedabWaselTsafar,
                        name: '3',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "سيارة حكومية",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "وسيلة أخرى" == entedabWaselTsafar,
                        name: '4',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "وسيلة أخرى",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: false,
                        name: '5',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "نعم",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: false,
                        name: '6',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "لا",
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
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـل تم تـأمـين وسيلـة الـسفر",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: travelVehicleTameen,
                          name: '7',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هل استعملت سيارة حكومية من الجهة المنتدب منها أو المنتدب إليها للتنقلات الداخلية",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: usingCar,
                          name: '8',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هل تم تكليفـك بالعمـل خـارج وقـت الــدوام خـلال فتـرة الانتــداب",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: workOutDawam,
                          name: '9',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـــل تــم تأمـــين الســـكن و الطعـــام أو أحـــدهمـــا",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: housingOrFood,
                          name: '10',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـل سبق أن صـرف سلفة نقدية على حسـاب المصاريف السفرية و ما مقـدارها",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: solfahNaqdeah,
                          name: '11',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "كـــم تبعـــد جهـــة الانتـــداب عـــن مقـــر العمـــل",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          "$entedabDistence كـم",
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
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        """الموظف المختص
                           
التوقيع:""",
                        textAlign: pw.TextAlign.start,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        """مدير شؤون الموظفين
$edara
التوقيع:""",
                        textAlign: pw.TextAlign.start,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        """رئيس $name
                      
$bossName""",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 13,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl, // للغة العربية
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // عنوان التقرير
                  pw.Header(
                    level: 0,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border.fromBorderSide(pw.BorderSide.none),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          """المملكة العربية السعودية
وزارة الشئون البلدية والقروية
$name""",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 6,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(width: 50),
                        pw.Text(
                          """بسم الله الرحمن الرحيم""",
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
                  pw.SizedBox(height: 20),
                  pw.Row(
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
                        "الموضوع : إركاب موظف",
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
                  pw.SizedBox(height: 10),
                  pw.Center(
                    child: pw.Text(
                      "رقم قرار الأنتداب: $entedabNumber تاريخه $entedabDate جهه الأنتداب $entedabPlace",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 11,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Center(
                    child: pw.Text(
                      "البيانات الموضحة أدناه صحيحة و على مسؤوليتي",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: arabicFont,
                        fontSize: 8,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
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
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(200),
                      3: const pw.FixedColumnWidth(200),
                      4: const pw.FixedColumnWidth(200),
                      5: const pw.FixedColumnWidth(200),
                      6: const pw.FixedColumnWidth(200),
                      7: const pw.FixedColumnWidth(200),
                      8: const pw.FixedColumnWidth(200),
                      9: const pw.FixedColumnWidth(300),
                      10: const pw.FixedColumnWidth(450),
                    },
                    headers: [
                      'التوقيع',
                      'الرصيد المتبقي',
                      'مدة الانتداب المجموع',
                      'مدة الانتداب الحالية',
                      'مدة الانتداب السابقة',
                      'الرصيد الثابت للسنة المالية',
                      'بدل النقل',
                      'الراتب',
                      'المرتبة',
                      'الوظيفة',
                      'الاسم',
                    ],
                    data: data,
                  ),
                ],
              ),
            );
          },
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl, // للغة العربية
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    """رقم أمر التكليف $entedabTakleefNumber تاريخه $entedabTakleefDate مدة المهمة $entedabPeriod 
تاريخ السفر الفعلي : $entedabStartDate تاريخ العودة $entedabEndDate
""",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Row(
                    children: [
                      pw.Text(
                        "وسيلة السفر",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "الطائرة" == entedabWaselTsafar,
                        name: '1',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "الطائرة",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "القطار" == entedabWaselTsafar,
                        name: '2',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "القطار",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "سيارة حكومية" == entedabWaselTsafar,
                        name: '3',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "سيارة حكومية",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: "وسيلة أخرى" == entedabWaselTsafar,
                        name: '4',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "وسيلة أخرى",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: false,
                        name: '5',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "نعم",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Checkbox(
                        value: false,
                        name: '6',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                      pw.SizedBox(width: 4),
                      pw.Text(
                        "لا",
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
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـل تم تـأمـين وسيلـة الـسفر",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: travelVehicleTameen,
                          name: '7',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هل استعملت سيارة حكومية من الجهة المنتدب منها أو المنتدب إليها للتنقلات الداخلية",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: usingCar,
                          name: '8',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هل تم تكليفـك بالعمـل خـارج وقـت الــدوام خـلال فتـرة الانتــداب",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: workOutDawam,
                          name: '9',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـــل تــم تأمـــين الســـكن و الطعـــام أو أحـــدهمـــا",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: housingOrFood,
                          name: '10',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "هـل سبق أن صـرف سلفة نقدية على حسـاب المصاريف السفرية و ما مقـدارها",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Checkbox(
                          value: solfahNaqdeah,
                          name: '11',
                          checkColor: PdfColors.blue,
                          activeColor: PdfColors.black,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.SizedBox(
                    width: 450,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          "كـــم تبعـــد جهـــة الانتـــداب عـــن مقـــر العمـــل",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: arabicFont,
                            fontSize: 11,
                            lineSpacing: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          "$entedabDistence كـم",
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
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        """الموظف المختص
                           
التوقيع:""",
                        textAlign: pw.TextAlign.start,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        """مدير شؤون الموظفين
$edara
التوقيع:""",
                        textAlign: pw.TextAlign.start,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        """رئيس $name
                      
$bossName""",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 13,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'اركاب موظف.pdf',
    // );
  }

  // انتداب موظف
  Future<void> createEntedabEmployeeReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpEntedabController controller = Get.find<EmpEntedabController>();
    String entedabPlace = controller.place.text;
    String entedabPeriod = controller.period.text;
    String entedabStartDate = controller.datBeginGo.text;
    String entedabDay = controller.day.value;
    String entedabTask = controller.task.text;

    EmpEntedabDetController detController = Get.find<EmpEntedabDetController>();

    List<List<dynamic>> data = [];

    for (EmpEntedabDetModel item in detController.entedabDets) {
      late int jobId;
      late String cardId;
      late String jobName;
      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId!;
        cardId = r.cardId!;
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name!);

      data.add(
        [
          item.naqlBadal,
          entedabPeriod,
          item.salary,
          item.draga,
          item.fia,
          jobName,
          cardId,
          item.empName,
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "انتداب موظف");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // للغة العربية
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // عنوان التقرير
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
                        "الموضوع : إنتداب موظف",
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
                      0: const pw.FixedColumnWidth(200),
                      1: const pw.FixedColumnWidth(200),
                      2: const pw.FixedColumnWidth(200),
                      3: const pw.FixedColumnWidth(200),
                      4: const pw.FixedColumnWidth(200),
                      5: const pw.FixedColumnWidth(300),
                      6: const pw.FixedColumnWidth(350),
                      7: const pw.FixedColumnWidth(400),
                    },
                    headers: [
                      'بدل النقل',
                      'مدة الانتداب',
                      'الراتب',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'رقم السجل المدني',
                      'الاسم',
                    ],
                    data: data),
                pw.SizedBox(height: 10),
                pw.Text(
                  """المكرم الموضح اسمه اعلاه                                                                              المحترم
السلام عليكم ورحمة الله وبركاته""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 14,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """اعتمدوا التوجه إلى   $entedabPlace
لمدة ($entedabPeriod) أيام. اعتبارا من يوم $entedabDay الموافق: $entedabStartDate م
وذلك لأداء مهمة رسمية وهي   $entedabTask
مع إحضار  شهادة مراجعة.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
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
                        font: arabicFont,
                        fontSize: 13,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'انتداب موظف.pdf',
    // );
  }

  // قرار إنتداب
  Future<void> createQrarEntedabReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String edara = bladiaInfoController.partBoss.text;

    EmpEntedabController controller = Get.find<EmpEntedabController>();
    String entedabNumber = controller.qrarId.text;
    String entedabDate = controller.datQrar.text;
    String entedabPlace = controller.place.text;
    String entedabPeriod = controller.period.text;
    String entedabTask = controller.task.text;
    String entedabStartDate = controller.datBeginGo.text;
    String taskRa = controller.taskRa.value;
    String sarf = controller.sarf.value;

    EmpEntedabDetController detController = Get.find<EmpEntedabDetController>();

    List<List<dynamic>> data = [];

    for (EmpEntedabDetModel item in detController.entedabDets) {
      late int jobId;
      late String cardId;
      late String jobName;
      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId!;
        cardId = r.cardId!;
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name!);

      data.add(
        [
          item.entedabBadal,
          item.naqlBadal,
          entedabPeriod,
          item.salary,
          item.draga,
          item.fia,
          jobName,
          cardId,
          item.empName,
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار إنتداب");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // للغة العربية
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // عنوان التقرير
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
                        "الموضوع : قرار إنتداب موظف",
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
                    0: const pw.FixedColumnWidth(200),
                    1: const pw.FixedColumnWidth(200),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(200),
                    5: const pw.FixedColumnWidth(200),
                    6: const pw.FixedColumnWidth(300),
                    7: const pw.FixedColumnWidth(350),
                    8: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'مقدار البدل',
                    'بدل النقل',
                    'مدة الانتداب',
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
                pw.Center(
                  child: pw.Text(
                    "قرار إداري رقم ( $entedabNumber ) وتاريخ $entedabDate م",
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 12,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """جهة الإنتداب: $entedabPlace
مدة الإنتداب: ($entedabPeriod) أيام إعتبارت من يوم $entedabStartDate م
$entedabTask

إن رئيس $name بناءَ على الصلاحيات الممنوحة له

وبناء على خطابنا رقم : $entedabNumber وتاريخ : $entedabDate القاضي انتداب المذكور للجهة والمدة والمهمة المحددة
اعلاه واستنادا لقرار مجلس الخدمة المدنية رقم ) ٣٦٥ ( في ١٤٠٠/١٠/٢٩ هـ واستنادا للمادة ١/٢ من لائحة
الخدمة المدنية""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Center(
                  child: pw.Text(
                    "يقرر ما يلي:",
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 9,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """1:- يصرف له يوميا مبلغ وقدرة ) أعله ( ر استنادا للمادة ٢٢ ,١/ ٩ من اللوائح المشـار
إليها واستنادا لقرار مجلس الخدمة المدنية المشار إليه شريطة اتساع البند وعدم تكرار
الصرف لتلك الفترة وبناء على قرار مجلس الوزراء رقم ) ٨٦ ( في ١٤٠٨/٠٥/١٠ هـ
القاضي بتخفيض بدل الانتداب.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 500,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "2:- يصرف له يوميا بدل نقل إضافي بنسبة ٣٠/١ من بدل نقله الشهري بموجب المادة ٢/٢٧ من لئحة الخدمة المدنية.",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: sarf ==
                            ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري',
                        name: '1',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.SizedBox(
                  width: 500,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "3:- يصرف له مبلغ تعويضا عن تذكرة إركاب.",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 9,
                          lineSpacing: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Checkbox(
                        value: taskRa ==
                            'يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه',
                        name: '2',
                        checkColor: PdfColors.blue,
                        activeColor: PdfColors.black,
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """4:- على شئون الموظفين والمالية اعتماد هذا القرار وإنفاذ موجبة.""",
                  textAlign: pw.TextAlign.start,
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 9,
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
                        font: arabicFont,
                        fontSize: 13,
                        lineSpacing: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار انتداب موظف.pdf',
    // );
  }

  // استحقاق راتب
  Future<void> createEsthqaqRatebReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String empName = bladiaInfoController.emp.text;
    String edara = bladiaInfoController.partBoss.text;
    String modaqeq = bladiaInfoController.part2Boss.text;
    String malia = bladiaInfoController.maliaBoss.text;

    EmpEntedabController controller = Get.find<EmpEntedabController>();
    String entedabNumber = controller.qrarId.text;
    String entedabDate = controller.datQrar.text;
    String entedabStartDate = controller.datBegin.text;
    String entedabEndDate = controller.datEnd.text;
    String entedabPeriod = controller.period.text;
    String entedabTaskra = controller.taskRaValue.text;

    EmpEntedabDetController detController = Get.find<EmpEntedabDetController>();

    List<List<dynamic>> data = [];

    double totalSalary = 0;
    double totalNqalBadal = 0;
    double totalBadalEntedabDaily = 0;
    double totalEntedabPrice = 0;
    double totalNqalBadalSafee = 0;
    double totalTaskRa = 0;
    double totalSafee = 0;

    for (EmpEntedabDetModel item in detController.entedabDets) {
      late int jobId;
      late String jobName;
      (await _employeeRepository.findById(item.empId!))
          .fold((l) => l, (r) => jobId = r.jobId!);
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name!);

      double entedabPrice = int.parse(entedabPeriod) * (item.entedabBadal ?? 0);
      double naqlBadalSafee =
          (int.parse(entedabPeriod) * ((item.naqlBadal ?? 0) / 30))
              .toPrecision(2);

      totalSalary += item.salary ?? 0;
      totalNqalBadal += item.naqlBadal ?? 0;
      totalBadalEntedabDaily += item.entedabBadal ?? 0;
      totalEntedabPrice += entedabPrice;
      totalNqalBadalSafee += naqlBadalSafee;
      totalTaskRa += double.parse(entedabTaskra);
      totalSafee +=
          (entedabPrice + double.parse(entedabTaskra) + naqlBadalSafee)
              .toPrecision(2);

      data.add(
        [
          "",
          "",
          entedabPrice + double.parse(entedabTaskra) + naqlBadalSafee,
          entedabTaskra,
          naqlBadalSafee,
          entedabPrice,
          entedabPeriod,
          item.entedabBadal,
          item.naqlBadal,
          item.salary,
          item.draga,
          item.fia,
          jobName,
          item.empName,
        ],
      );
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "استحقاق راتب");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl, // للغة العربية
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // عنوان التقرير
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
                        "سند إفرادي يوضح إستحقاق إنتداب موظف",
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
                      """عن المدة من:      $entedabStartDate      الى      $entedabEndDate
بموجب قرار رقم      $entedabNumber      و تاريخ      $entedabDate
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
                    0: const pw.FixedColumnWidth(200),
                    1: const pw.FixedColumnWidth(200),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(200),
                    6: const pw.FixedColumnWidth(200),
                    7: const pw.FixedColumnWidth(300),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(300),
                    10: const pw.FixedColumnWidth(200),
                    11: const pw.FixedColumnWidth(200),
                    12: const pw.FixedColumnWidth(300),
                    13: const pw.FixedColumnWidth(400),
                  },
                  headers: [
                    'الملاحظات',
                    'التوقيع',
                    'الصافي',
                    'تعويض التذاكر',
                    'بدل النقل الصافي',
                    'مبلغ الإنتداب',
                    'مدة الإنتداب',
                    'بدل الإنتداب اليومي',
                    'بدل النقل الشهري',
                    'الراتب الشهري',
                    'الدرجة',
                    'المرتبة',
                    'الوظيفة',
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
                    0: const pw.FixedColumnWidth(200),
                    1: const pw.FixedColumnWidth(200),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(200),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(200),
                    6: const pw.FixedColumnWidth(200),
                    7: const pw.FixedColumnWidth(300),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(1400),
                  },
                  headers: [
                    '',
                    '',
                    totalSafee,
                    totalTaskRa,
                    totalNqalBadalSafee.toPrecision(2),
                    totalEntedabPrice,
                    entedabPeriod,
                    totalBadalEntedabDaily,
                    totalNqalBadal,
                    'المجموع:   $totalSalary'
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
                )
              ],
            ),
          );
        },
      ),
    );

    // Generate the PDF bytes
    final pdfBytes = await pdf.save();

    // Open in new tab
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) => pdfBytes,
    //   format: PdfPageFormat.a4.landscape,
    //   // usePrinterSettings: , // يعرض مباشرة بدون خيارات الطابعة
    //   dynamicLayout: false,
    // );

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'استحقاق راتب.pdf',
    // );
  }
}
