import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../employee/data/repository/employee_repository.dart';
import '../../../tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import 'emp_tarqea_controller.dart';

class EmpTarqeaReportController extends GetxController {
  final EmployeeRepository _empRepository;

  EmpTarqeaReportController(this._empRepository);

  // قرار ترقية
  Future<void> createQrarTarqeaReport(bool withWorkPercentage) async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;
    String amana = bladiaInfoController.amana.text;

    EmpTarqeaController controller = Get.find<EmpTarqeaController>();
    String tarqeaQrarNumber = controller.qrarId.text;
    String tarqeaQrarDate = controller.qrarDate.text;
    String tarqeaKhetabNumber = controller.khetabId.text;
    String tarqeaKhetabDate = controller.khetabDate.text;
    String tarqeaMosadakaNumber = controller.mosadakaId.text;
    String tarqeaMosadakaDate = controller.mosadakaDate.text;
    String tarqeaMahdarNumber = controller.mahdarId.text;
    String tarqeaMahdarDate = controller.mahdarDate.text;
    String tarqeaPercent = controller.percent.text;

    String employeeName = controller.empName.text;

    String oldJobName = controller.oldJobName.text;
    String oldFia = controller.oldFia.text;
    String oldNo = controller.oldNo.text;
    String oldSalary = controller.oldSalary.text;
    String oldJobBadalat = controller.oldJobBadalat.text;
    String oldPartName = controller.oldPartName.text;

    String newJobName = controller.newJobName.text;
    String newFia = controller.newFia.text;
    String newNo = controller.newNo.text;
    String newSalary = controller.newSalary.text;
    String newJobBadalat = controller.newJobBadalat.text;
    String newPartName = controller.newPartName.text;

    late String cardId;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) => cardId = r.cardId ?? '');

    List<List<dynamic>> data1 = [
      [
        oldPartName,
        oldJobBadalat,
        oldSalary,
        oldNo,
        oldFia,
        oldJobName,
      ],
    ];

    List<List<dynamic>> data2 = [
      [
        newPartName,
        newJobBadalat,
        newSalary,
        newNo,
        newFia,
        newJobName,
      ],
    ];

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(
        title: withWorkPercentage
            ? "قرار ترقية مع نسبة طبيعة العمل"
            : "قرار ترقية");

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
                  "الموضوع: قرار ترقية",
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

          pw.Center(
            child: pw.Text(
              "قرار رقم  $tarqeaQrarNumber و تاريخ $tarqeaQrarDate هـ",
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

          pw.Text(
            """إن رئيس $name :-
بناء على الصلحيات المخولة له بموجب القرار الداري رقم 2314 تاريخ 1426/3/15 و بناء على خطاب سعادة مدير عام الشئون الدارية و المالية بأمانة $amana رقم $tarqeaKhetabNumber و تاريخ $tarqeaKhetabDate هـ المبني على مصادقة مدير إدارة الترقيات و النقل المدنية رقم $tarqeaMosadakaNumber و تاريخ $tarqeaMosadakaDate هـ  المتضمن المصادقة على محضر الترقيات رقم $tarqeaMahdarNumber و تاريخ $tarqeaMahdarDate هـ
بشأن ترقية الموظف الموضح اسمه أدناه و بناء على لائحة الترقيات بنظام الخدمة المدنية و تنفيذ المادة /18ب من النظام المتعلقة بالعلاوة الضافية و المادة 17/27 التي تشير لبدل طبيعة عليه يقرر ما يلي: """,
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            "(1) ترقية  $employeeName   برقم بطاقة  $cardId  وفقاً للبيانات الموضحة",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            "الوظيفة التي يشغلها:",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
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
              0: const pw.FixedColumnWidth(300),
              1: const pw.FixedColumnWidth(300),
              2: const pw.FixedColumnWidth(400),
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(400),
            },
            headers: [
              'مقرها',
              'طبيعة العمل',
              'الراتب',
              'الرقم',
              'المرتبة',
              'مسمى الوظيفة',
            ],
            data: data1,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            "الوظيفة المرقى إليها:",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
              lineSpacing: 10,
              fontWeight: pw.FontWeight.bold,
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
              0: const pw.FixedColumnWidth(300),
              1: const pw.FixedColumnWidth(300),
              2: const pw.FixedColumnWidth(400),
              3: const pw.FixedColumnWidth(300),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(400),
            },
            headers: [
              'مقرها',
              'طبيعة العمل',
              'الراتب',
              'الرقم',
              'المرتبة',
              'مسمى الوظيفة',
            ],
            data: data2,
          ),
          pw.SizedBox(height: 10),
          withWorkPercentage
              ? pw.Text(
                  """(2) منحه العلاوة الإضافية المنصوص عليها بالمادة /18ب من نظام الخدمة المدنية.
(3) يمنح المذكور بدل طبيعة عمل $tarqeaPercent % من أول مربوط 38 مبلغ و 0 ريال.
(4) تكون ترقية المذكور من تاريخ مباشرته عمل الوظيفة المرقى عليها بعد صدور هذا القرار.
(5) يبلغ هذا القرار للجهات المختصة و على شؤون الموظفين إنفاذه بموجب النظام .""",
                  style: pw.TextStyle(
                    font: arabicFont,
                    fontSize: 11,
                    lineSpacing: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                )
              : pw.Text(
                  """(2) منحه العلاوة الإضافية المنصوص عليها بالمادة /18ب من نظام الخدمة المدنية.
(3) تكون ترقية المذكور من تاريخ مباشرته عمل الوظيفة المرقى عليها بعد صدور هذا القرار.
(4) يبلغ هذا القرار للجهات المختصة و على شؤون الموظفين إنفاذه بموجب النظام .""",
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
              "والله الموفق....",
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
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, '_blank');

    // // حفظ أو مشاركة الملف
    // await Printing.sharePdf(
    //   bytes: await pdf.save(),
    //   filename: 'قرار حسم.pdf',
    // );
  }

  // قرار مباشرة
  Future<void> createQrarMobashraReport() async {
    BladiaInfoController bladiaInfoController =
        Get.find<BladiaInfoController>();
    String name = bladiaInfoController.name.text;
    String bossName = bladiaInfoController.boss.text;

    EmpTarqeaController controller = Get.find<EmpTarqeaController>();
    String tarqeaQrarNumber = controller.qrarId.text;
    String tarqeaQrarDate = controller.qrarDate.text;
    String partBoss = controller.newPartName.text;
    String partBossKhetabNumber = controller.mKhetabId.text;
    String partBossKhetabDate = controller.mKhetabDate.text;
    String mobashraDay = controller.mobasharaDay.value;
    String mobashraDate = controller.mobasharaDate.text;

    String employeeName = controller.empName.text;
    String newJobName = controller.newJobName.text;
    String newFia = controller.newFia.text;
    String newNo = controller.newNo.text;
    String newSalary = controller.newSalary.text;
    String newNaqlBadal = controller.newNaqlBadal.text;

    late String cardId;

    (await _empRepository.findById(int.parse(controller.empId.text)))
        .fold((l) => l, (r) => cardId = r.cardId ?? '');

    List<List<dynamic>> data = [
      [
        newNaqlBadal,
        newSalary,
        newNo,
        newFia,
        newJobName,
        cardId,
        employeeName,
      ],
    ];

    // إنشاء مستند PDF جديد
    final pdf = pw.Document(title: "قرار مباشرة");

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
                  "الموضوع: قرار مباشرة",
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
              0: const pw.FixedColumnWidth(300),
              1: const pw.FixedColumnWidth(200),
              2: const pw.FixedColumnWidth(200),
              3: const pw.FixedColumnWidth(200),
              4: const pw.FixedColumnWidth(300),
              5: const pw.FixedColumnWidth(400),
              6: const pw.FixedColumnWidth(400),
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
            data: data,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            """المكرم مدير الموارد البشرية                                                 المحترم
السلام عليكم ورحمة الله و بركاته ,
إلحاقا لقرارنا الإداري رقم $tarqeaQrarNumber و تاريخ $tarqeaQrarDate  هـ القاضي بترقية الموضح اسمه و بياناته أعلاه على الوظيفة المحاذية لاسمه و بناء على ما رفعه لنا رئيس قسم $partBoss في خطابه $partBossKhetabNumber و بتاريخ $partBossKhetabDate هـ والذي أفاد فيه عن مباشرة المذكور عمله لدى القسم اعتبارا من يوم $mobashraDay الموافق $mobashraDate هـ

لذا اعتمدوا التأشير  بذلك و تزويد الجهات المختصة بصورة منه .
والسلام عليكم ورحمة الله وبركاته ,""",
            style: pw.TextStyle(
              font: arabicFont,
              fontSize: 11,
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
