import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_entedab_search_report_controller.dart';

class EntedabReport extends StatelessWidget {
  const EntedabReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEntedabSearchReportController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker fromDate =
        HijriPicker(controller.fromDate, controller.fromDateGo);
    HijriPicker toDate = HijriPicker(controller.toDate, controller.toDateGo);

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.empId,
                    label: 'الموظف',
                    customHeight: 25,
                    customWidth: currentWidth * 0.07,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.empName,
                    label: '',
                    customHeight: 25,
                    customWidth: 300,
                  ),
                  CustomButton(
                    text: 'اختر',
                    onPressed: () {
                      Get.find<EmployeeFindController>().clearControllers();
                      Get.dialog(
                        EmployeesFind(
                          onRowDoubleTap: (event) {
                            Map<String, PlutoCell> cells = event.row.cells;
                            controller.empId.text =
                                cells['id']!.value.toString();
                            controller.empName.text =
                                cells['name']!.value.toString();
                            Get.back();
                          },
                        ),
                      );
                      Get.find<EmployeeFindController>().findEmployee();
                    },
                    height: 35,
                    width: 75,
                  ).paddingOnly(top: 15),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => fromDate.pickHijriDate(context),
                    controller: controller.fromDate,
                    label: 'الفترة من',
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  const Text("هـ"),
                  const SizedBox(width: 16),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => toDate.pickHijriDate(context),
                    controller: controller.toDate,
                    label: 'إلى',
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  const Text("هـ"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    controller: controller.fromDateGo,
                    label: '',
                    withLable: false,
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  const Text("مـ"),
                  const SizedBox(width: 16),
                  CustomTextField(
                    controller: controller.toDateGo,
                    label: '',
                    withLable: false,
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  const Text("مـ"),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "بحث",
                    onPressed: () => controller.search(),
                    height: 25,
                    width: 100,
                  ),
                  CustomButton(
                    text: "تقرير",
                    onPressed: () => controller.report(),
                    height: 25,
                    width: 100,
                  ),
                  CustomButton(
                    text: "بحث جديد",
                    onPressed: () => controller.clearControllers(),
                    height: 25,
                    width: 100,
                  )
                ],
              ),
              const SizedBox(height: 16), // Add spacing
              Obx(
                () => Text("عدد السجلات المسترجعة: ${controller.length}"),
              ).center(),
              SizedBox(
                height: currentHeight - 100, // Define fixed height
                // width: currentWidth * 0.95, // Define fixed width
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }

                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controller.empEntedabs
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "employeeName": PlutoCell(
                                    value: item.employeeName.getValue()),
                                "jobTitle":
                                    PlutoCell(value: item.jobTitle.getValue()),
                                "fia": PlutoCell(value: item.fia.getValue()),
                                "entedabPlace": PlutoCell(
                                    value: item.entedabPlace.getValue()),
                                "task": PlutoCell(value: item.task.getValue()),
                                "period":
                                    PlutoCell(value: item.period.getValue()),
                                "assignmentStartDate": PlutoCell(
                                    value: item.assignmentStartDate.getValue()),
                                "prevPeriod": PlutoCell(
                                    value: item.prevPeriod.getValue()),
                                "sumPeriod":
                                    PlutoCell(value: item.sumPeriod.getValue()),
                                "empId":
                                    PlutoCell(value: item.empId.getValue()),
                                "dateBeginGo": PlutoCell(
                                    value: item.dateBeginGo.getValue()),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'م',
                          field: 'id',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الاسم',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مسمى الوظيفة',
                          field: 'jobTitle',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المرتبة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'جهة الإنتداب',
                          field: 'entedabPlace',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المهمة',
                          field: 'task',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المدة',
                          field: 'period',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ بداية الإنتداب',
                          field: 'assignmentStartDate',
                          type: PlutoColumnType.date(),
                        ),
                        PlutoColumn(
                          title: 'المدة السابقة',
                          field: 'prevPeriod',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'مجموع المدة',
                          field: 'sumPeriod',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'رمز الموظف',
                          field: 'empId',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ البداية',
                          field: 'dateBeginGo',
                          type: PlutoColumnType.date(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                    );
                  },
                ),
              ).paddingAll(15),
            ],
          ),
        ),
      ),
    );
  }
}
