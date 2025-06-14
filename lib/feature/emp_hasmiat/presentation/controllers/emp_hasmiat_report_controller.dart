import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../employee/data/repository/employee_repository.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../../tarmeez_jobs/data/repository/jobs_repository.dart';
import '../../data/model/emp_hasmiat_det_model.dart';
import 'emp_hasmiat_controller.dart';
import 'emp_hasmiat_det_controller.dart';

class EmpHasmiatReportController extends GetxController {
  final EmployeeRepository _employeeRepository;
  final JobsRepository _jobsRepository;

  EmpHasmiatReportController(this._employeeRepository, this._jobsRepository);

  // قرار حسم
  Future<void> createQrarHasmiatReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpHasmiatController controller = Get.find<EmpHasmiatController>();

    String hasmiatMonth1 = controller.month1.text;
    String hasmiatYear1 = controller.year1.text;
    String hasmiatMonth2 = controller.month2.text;
    String hasmiatYear2 = controller.year2.text;

    EmpHasmiatDetController detController = Get.find<EmpHasmiatDetController>();
    // await detController.getHasmiatDetByHasmiatId(int.parse(controller.id.text));

    List<List<dynamic>> data = [];

    int i = 1;
    for (EmpHasmiatDetModel item in detController.hasmialDets) {
      late int jobId;
      late String jobName;
      late String fia;

      (await _employeeRepository.findById(item.empId!)).fold((l) => l, (r) {
        jobId = r.jobId ?? 0;
        fia = r.fia ?? "";
      });
      (await _jobsRepository.findById(id: jobId))
          .fold((l) => l, (r) => jobName = r.name ?? "");

      data.add(
        [
          item.notes ?? "",
          item.gza ?? "",
          item.ghyab ?? "",
          item.tagmee3 ?? "",
          item.min ?? "",
          item.naqlBadal ?? 0,
          item.salary ?? 0,
          fia,
          jobName,
          item.employeeName ?? "",
          i,
        ],
      );
      i++;
    }

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار حسم");

    // تحميل خط عربي (اختياري)
    final arabicFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/tajawal.ttf"),
    );

    // إضافة صفحة إلى المستند
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        // orientation: pw.PageOrientation.landscape,
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
                        "الموضوع: قرار حسم",
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
                pw.SizedBox(height: 5),
                pw.Center(
                  child: pw.Text(
                    "قرار حسم الغياب و التأخير",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                      lineSpacing: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
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
                    0: const pw.FixedColumnWidth(250),
                    1: const pw.FixedColumnWidth(250),
                    2: const pw.FixedColumnWidth(300),
                    3: const pw.FixedColumnWidth(300),
                    4: const pw.FixedColumnWidth(300),
                    5: const pw.FixedColumnWidth(250),
                    6: const pw.FixedColumnWidth(200),
                    7: const pw.FixedColumnWidth(200),
                    8: const pw.FixedColumnWidth(300),
                    9: const pw.FixedColumnWidth(400),
                    10: const pw.FixedColumnWidth(200),
                  },
                  headers: [
                    'ملاحظات',
                    'مقدار الحسم بالريال',
                    'مدة الغياب و التأخير يوم',
                    'مدة الغياب و التأخير س',
                    'مدة الغياب و التأخير د',
                    'بدل النقل',
                    'الراتب',
                    'المرتبة',
                    'الوظيفة',
                    'الاسم',
                    ' م ',
                  ],
                  data: data,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  """إن رئيس $name
بناء على خطاب مدير عام شؤون الموظفين بالوزارة رقم (2962) و تاريخ 1435/02/14 هـ و المتضمنة تأخر و
تغيب الموظف الموضح اسمه أعلاه خلال خلاصة لشهر $hasmiatMonth1 عام $hasmiatYear1 هو استنادا للمادة رقم (21) من نظام الخدمة المدنية فقد تقرر ما يلي:
1:- يحسم من راتب الموظف الموضح اسمه أعلاه راتب و بدلات مدة الغياب و التأخير المحددة أمام اسمه من راتب شهر $hasmiatMonth2 لعام $hasmiatYear2
2:- يبلغ قرارنا هذا من يلزم لنفاذه .""",
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
                    "و السلام عليكم و رحمه الله و بركاته ,,,,,",
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
                    pw.Column(
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

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار حسم.pdf',
    // );
  }
}
