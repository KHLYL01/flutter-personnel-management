import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_report_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/employee_find_controller.dart';
import '../controllers/mosaeer_salary_controller.dart';

class MosaeerSalary extends StatelessWidget {
  const MosaeerSalary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MosaeerSalaryController>();
    final controllerReport = Get.find<EmployeeReportController>();

    double currentHeight = Get.height;
    double currentWidth = Get.width;

    HijriPicker startDate = HijriPicker(controller.startDate);
    HijriPicker endDate = HijriPicker(controller.endDate);

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDropdownButton(
                label: 'نوع الوظيفة',
                width: 400,
                list: controller.empTypeList,
                item: controller.empType,
                onChanged: controller.onChangedJobWork,
              ).paddingSymmetric(horizontal: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("الفترة من: ").paddingOnly(bottom: 6),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => startDate.pickHijriDate(context),
                    controller: controller.startDate,
                    label: "",
                    customHeight: 25,
                    customWidth: 150,
                  ),
                  const SizedBox(width: 8),
                  const Text("إلى: ").paddingOnly(bottom: 6),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => endDate.pickHijriDate(context),
                    controller: controller.endDate,
                    label: "",
                    customHeight: 25,
                    customWidth: 150,
                  ),
                  const SizedBox(width: 24),
                ],
              ).paddingSymmetric(horizontal: 40),
              const SizedBox(height: 20), // Add spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "عرض",
                    onPressed: () => controller.getMosaeer(),
                    height: 25,
                    width: 100,
                  ),
                  CustomButton(
                    text: "تقرير",
                    onPressed: () {
                      if (controller.empType.value == "عامل نظافة - عقد") {
                        controllerReport.mosaeerSalaryWorkerReport();
                      } else {
                        controllerReport.mosaeerSalaryReport();
                      }
                    },
                    height: 25,
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add spacing
              Obx(
                () => Text("عدد السجلات المسترجعة: ${controller.length}"),
              ).center(),
              SizedBox(
                height: currentHeight / 2 + 50, // Define fixed height
                width: currentWidth - 140, // Define fixed width
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }

                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controller.mosaeer
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id?.getValue()),
                                  "name":
                                      PlutoCell(value: item.name.getValue()),
                                  "cardId":
                                      PlutoCell(value: item.cardId?.getValue()),
                                  "jobName": PlutoCell(
                                      value: item.jobName?.getValue()),
                                  "fia": PlutoCell(value: item.fia.getValue()),
                                  "draga":
                                      PlutoCell(value: item.draga.getValue()),
                                  "salary":
                                      PlutoCell(value: item.salary.getValue()),
                                  "mosta7qSalary": PlutoCell(
                                      value: item.mosta7qSalary.getValue()),
                                  "naqlBadal": PlutoCell(
                                      value: item.naqlBadal.getValue()),
                                  "jobBadalat": PlutoCell(
                                      value: item.jobBadalat.getValue()),
                                  "ma3esha":
                                      PlutoCell(value: item.ma3esha.getValue()),
                                  "addDays":
                                      PlutoCell(value: item.addDays.getValue()),
                                  "mosta7qTotal": PlutoCell(
                                      value: item.mosta7qTotal.getValue()),
                                  "taka3ed":
                                      PlutoCell(value: item.taka3ed.getValue()),
                                  "taka3odM": PlutoCell(
                                      value: item.taka3odM.getValue()),
                                  "gza": PlutoCell(value: item.gza.getValue()),
                                  "bank":
                                      PlutoCell(value: item.bank.getValue()),
                                  "sandok":
                                      PlutoCell(value: item.sandok.getValue()),
                                  "zeraee":
                                      PlutoCell(value: item.zeraee.getValue()),
                                  "hasmTotal": PlutoCell(
                                      value: item.hasmTotal.getValue()),
                                  "safy":
                                      PlutoCell(value: item.safy.getValue()),
                                  "comments": PlutoCell(
                                      value: item.comments.getValue()),
                                  "holidays": PlutoCell(
                                      value: item.holidays.getValue()),
                                  "badal1":
                                      PlutoCell(value: item.badal1.getValue()),
                                  "badal2":
                                      PlutoCell(value: item.badal2.getValue()),
                                  "badal3":
                                      PlutoCell(value: item.badal3.getValue()),
                                  "badal4":
                                      PlutoCell(value: item.badal4.getValue()),
                                  "hasm1":
                                      PlutoCell(value: item.hasm1.getValue()),
                                  "hasm2":
                                      PlutoCell(value: item.hasm2.getValue()),
                                  "isHasm3":
                                      PlutoCell(value: item.isHasm3.getValue()),
                                  "hasm3":
                                      PlutoCell(value: item.hasm3.getValue()),
                                  "check": PlutoCell(value: false),
                                },
                              ))
                          .toList(),
                      columns: [
                        PlutoColumn(
                            title: 'رقم الموظف',
                            field: 'id',
                            type: PlutoColumnType.text(),
                            hide: true),
                        PlutoColumn(
                          title: 'اسم الموظف',
                          field: 'name',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم السجل المدني',
                          field: 'cardId',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الوظيفة',
                          field: 'jobName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفئة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الدرجة',
                          field: 'draga',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب الأساسي',
                          field: 'salary',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب المستحق',
                          field: 'mosta7qSalary',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل النقل',
                          field: 'naqlBadal',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل طبيعية العمل',
                          field: 'jobBadalat',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل غلاء المعيشة',
                          field: 'ma3esha',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'أيام الزيادة',
                          field: 'addDays',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مجموع المستحقات',
                          field: 'mosta7qTotal',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تقاعد 9%',
                          field: 'taka3ed',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تقاعد معاد',
                          field: 'taka3odM',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'جزاءات',
                          field: 'gza',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بنك التسليف',
                          field: 'bank',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الصندوق',
                          field: 'sandok',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'البنك الزراعي',
                          field: 'zeraee',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مجموع الحسميات',
                          field: 'hasmTotal',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الصافي',
                          field: 'safy',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الملاحظات',
                          field: 'comments',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الإجازات',
                          field: 'holidays',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل 1',
                          field: 'badal1',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل 2',
                          field: 'badal2',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل 3',
                          field: 'badal3',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل 4',
                          field: 'badal4',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حسم 1',
                          field: 'hasm1',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حسم 2',
                          field: 'hasm2',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حسم 3 نعم/لا',
                          field: 'isHasm3',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حسم 3',
                          field: 'hasm3',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'لا يظهر',
                          field: 'check',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      // onRowDoubleTap: onRowDoubleTap,
                    );
                  },
                ),
              ).center(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
