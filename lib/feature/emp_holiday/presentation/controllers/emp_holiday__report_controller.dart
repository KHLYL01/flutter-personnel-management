import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:personnel_management/feature/employee/data/model/employee_model.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class EmpHolidayReportController extends GetxController {
  final EmployeeRepository _empRepository;

  EmpHolidayReportController(this._empRepository);

  Future<void> createQrarHolidayReport() async {
    final holidayController = Get.find<EmpHolidayController>();
    EmployeeModel? employeeModel;
    final data = await _empRepository.findById(
      int.parse(holidayController.empId.text),
    );

    data.fold((l) => l, (r) => employeeModel = r);

    // إنشاء مستند PDF جديد
    final pdf = pw.Document();

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
                        'إدارة الموارد البشرية',
                        style: pw.TextStyle(
                          font: arabicFont,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        'الموضوع: إجازة موظف',
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
                      fontSize: 11,
                    ),
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.grey600,
                    ),
                    cellStyle: pw.TextStyle(
                      font: arabicFont,
                      fontSize: 11,
                    ),
                    cellAlignment: pw.Alignment.center,
                    headerAlignment: pw.Alignment.center,
                    columnWidths: {
                      0: const pw.FixedColumnWidth(130),
                      1: const pw.FixedColumnWidth(130),
                      2: const pw.FixedColumnWidth(130),
                      3: const pw.FixedColumnWidth(130),
                      4: const pw.FixedColumnWidth(120),
                      5: const pw.FixedColumnWidth(250),
                      6: const pw.FixedColumnWidth(300),
                    },
                    headers: [
                      'بدل النقل',
                      'الراتب',
                      'الدرجة',
                      'المرتبة',
                      'الوظيفة',
                      'رقم السجل المدني',
                      'الاسم',
                    ],
                    data: [
                      [
                        employeeModel!.naqlBadal,
                        employeeModel!.salary,
                        employeeModel!.draga,
                        employeeModel!.fia,
                        employeeModel!.workJob,
                        employeeModel!.cardId,
                        employeeModel!.name,
                      ]
                    ]),

                pw.SizedBox(height: 30),

                // نص ختامي
                pw.Text(
                  """إن مساعد رئيس بلدية محافظة تيماء
بناءً على الصلاحيات الممنوحة لة بالقرار الاداري رقم (4400619615) وتاريخ 7 / 8/ 1444 هـ .
و إشارة إلى طلب الإجازة المرفق من الموضح اسمه و بياناته أعلاه وبناء على
المادة (130) من اللائحة التنفيذية للموارد البشرية بنظام الخدمة المدنية, يقرر ما يلي:

1- الموافقة على تمتع الموظف أعلاه منحة إجازة إعتيادي مرحل لمدة تسعة عشر  يوماً / أيام
اعتباراً من: 8 / 04 / 1441 هـ إلى 29 / 04 / 1441 هـ
2- لا يصرف راتبه/ها مقدما
3- يبلغ هذا القرار لمن يلزم لإنفاذه

""",
                  style: pw.TextStyle(
                      font: arabicFont, fontSize: 11, lineSpacing: 10),
                ),

                pw.Center(
                  child: pw.Text(
                    "والسلام عليكم ورحمة الله و بركاته ....",
                    style: pw.TextStyle(
                        font: arabicFont, fontSize: 11, lineSpacing: 10),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      """مساعد رئيس بلدية محافظة تيماء

المهندس / ماجد خلف الدوشان""",
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          font: arabicFont, fontSize: 11, lineSpacing: 10),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );

    // حفظ أو مشاركة الملف
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'قرار إجازة.pdf',
    );
  }

  Future<void> createMoserHolidayReport() async {
    final holidayController = Get.find<EmpHolidayController>();
    EmployeeModel? employeeModel;
    final data = await _empRepository.findById(
      int.parse(holidayController.empId.text),
    );

    data.fold((l) => l, (r) => employeeModel = r);

    // إنشاء مستند PDF جديد
    final pdf = pw.Document();

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

بلدية محافظة تيماء
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
                      pw.SizedBox(width: 150),
                      pw.Text(
                        """بسم الله الرحمن الرحيم

سند إفرادي يوضح استحقاق الموضح ادناه لقاء
عن المدة من 8 / 04 / 1441 هـ وتاريخ انتهاء الإجازة إعتباراٌ 29 / 8 / 1441 هـ
بموجب القرار رقم 387 وتاريخ 0 / 1441""",
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
                      0: const pw.FixedColumnWidth(150),
                      1: const pw.FixedColumnWidth(150),
                      2: const pw.FixedColumnWidth(160),
                      3: const pw.FixedColumnWidth(230),
                      4: const pw.FixedColumnWidth(230),
                      5: const pw.FixedColumnWidth(150),
                      6: const pw.FixedColumnWidth(160),
                      7: const pw.FixedColumnWidth(230),
                      8: const pw.FixedColumnWidth(230),
                      9: const pw.FixedColumnWidth(230),
                      10: const pw.FixedColumnWidth(160),
                      11: const pw.FixedColumnWidth(230),
                      12: const pw.FixedColumnWidth(230),
                      13: const pw.FixedColumnWidth(230),
                      14: const pw.FixedColumnWidth(130),
                      15: const pw.FixedColumnWidth(140),
                      16: const pw.FixedColumnWidth(230),
                      17: const pw.FixedColumnWidth(300),
                      18: const pw.FixedColumnWidth(50),
                    },
                    headers: [
                      'التوقيع',
                      'الصافي',
                      'المجموع',
                      'حسميات التسليف',
                      'حسميات العقاري',
                      'التقاعد',
                      'المجموع',
                      'قسط طبيعة العمل',
                      'قسط بدل النقل',
                      'قسط الراتب',
                      'المجموع',
                      'بدل طبيعة العمل',
                      'بدل النقل',
                      'الراتب الاساسي',
                      'الرقم',
                      'المرتبة',
                      'الوظيفة',
                      'الاسم',
                      ' م',
                    ],
                    data: [
                      [
                        "",
                        (employeeModel!.salary1 ?? 0.0) +
                            0 +
                            0 -
                            ((employeeModel!.hasm2 ?? 0) +
                                (employeeModel!.hasm1 ?? 0) +
                                (employeeModel!.taka3odM ?? 0)),
                        ((employeeModel!.hasm2 ?? 0) +
                            (employeeModel!.hasm1 ?? 0) +
                            (employeeModel!.taka3odM ?? 0)),
                        employeeModel!.hasm2 ?? 0,
                        employeeModel!.hasm1 ?? 0,
                        employeeModel!.taka3odM ?? 0,
                        (employeeModel!.salary1 ?? 0) + 0 + 0,
                        "",
                        "",
                        employeeModel!.salary1 ?? 0.0,
                        (employeeModel!.naqlBadal ?? 0.0) +
                            (employeeModel!.salary ?? 0.0) +
                            0,
                        "",
                        employeeModel!.naqlBadal ?? 0.0,
                        employeeModel!.salary ?? 0.0,
                        employeeModel!.id ?? 0,
                        employeeModel!.fia,
                        employeeModel!.workJob,
                        employeeModel!.name,
                        "1",
                      ]
                    ]),

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
                    0: const pw.FixedColumnWidth(150),
                    1: const pw.FixedColumnWidth(150),
                    2: const pw.FixedColumnWidth(160),
                    3: const pw.FixedColumnWidth(230),
                    4: const pw.FixedColumnWidth(230),
                    5: const pw.FixedColumnWidth(150),
                    6: const pw.FixedColumnWidth(160),
                    7: const pw.FixedColumnWidth(230),
                    8: const pw.FixedColumnWidth(230),
                    9: const pw.FixedColumnWidth(230),
                    10: const pw.FixedColumnWidth(160),
                    11: const pw.FixedColumnWidth(230),
                    12: const pw.FixedColumnWidth(230),
                    13: const pw.FixedColumnWidth(230),
                    14: const pw.FixedColumnWidth(850),
                  },
                  headers: [
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    '0.0',
                    'الإجمالي'
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
                          "فهد نايف العنزي",
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
                          "حمدان هجيج العنزي",
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
                          "عبدالله فهد العيادي",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              font: arabicFont, fontSize: 8, lineSpacing: 10),
                        ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          "رئيس بلدية مجافظة تيماء",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              font: arabicFont, fontSize: 8, lineSpacing: 10),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          "المهندس / حسن بن عبدالرحيم الغبان",
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
    // حفظ أو مشاركة الملف
    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'مسير إجازة.pdf',
    );
  }
}
