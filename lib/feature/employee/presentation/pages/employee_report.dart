import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/tarmeez_parts/presentation/pages/parts_find.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../controllers/employee_search_report_controller.dart';

class EmployeeReport extends StatelessWidget {
  const EmployeeReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeSearchReportController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdownButton(
                    label: 'نوع الوظيفة',
                    list: controller.empTypeList,
                    item: controller.empType,
                    onChanged: controller.onChangedJobWork,
                  ),
                  const SizedBox(width: 32),
                  CustomDropdownButton(
                    label: 'حالة الوظيفة',
                    list: controller.jobStateList,
                    item: controller.jobState,
                    onChanged: controller.onChangedJobState,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.partId,
                    label: 'القسم',
                    customHeight: 25,
                    customWidth: currentWidth * 0.07,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.partName,
                    label: '',
                    customHeight: 25,
                    customWidth: 300,
                  ),
                  CustomButton(
                    text: 'اختر',
                    onPressed: () {
                      Get.find<EmployeeFindController>().clearControllers();
                      Get.dialog(
                        PartsFind(
                          onRowDoubleTap: (event) {
                            Map<String, PlutoCell> cells = event.row.cells;
                            controller.partId.text =
                                cells['id']!.value.toString();
                            controller.partName.text =
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
                      rows: controller.employees
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "name": PlutoCell(
                                  value: item.name.getValue(),
                                ),
                                "partName": PlutoCell(
                                  value: item.partName.getValue(),
                                ),
                                "fia": PlutoCell(
                                  value: item.fia.getValue(),
                                ),
                                "jobNo": PlutoCell(
                                  value: item.jobNo.getValue(),
                                ),
                                "draga": PlutoCell(
                                  value: item.draga.getValue(),
                                ),
                                "jobName": PlutoCell(
                                  value: item.jobName.getValue(),
                                ),
                                "jobState": PlutoCell(
                                  value: item.jobState.getValue(),
                                ),
                                "cardId": PlutoCell(
                                  value: item.cardId.getValue(),
                                ),
                                "bok": PlutoCell(
                                  value: item.bok.getValue(),
                                ),
                                "datBok": PlutoCell(
                                  value: item.datBok.getValue(),
                                ),
                                "datWork": PlutoCell(
                                  value: item.datWork.getValue(),
                                ),
                                "datJob": PlutoCell(
                                  value: item.datJob.getValue(),
                                ),
                                "education": PlutoCell(
                                  value: item.education.getValue(),
                                ),
                                "salary": PlutoCell(
                                  value: item.salary.getValue(),
                                ),
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
                          field: "name",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'القسم',
                          field: "partName",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المرتبة',
                          field: "fia",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم الوظيفة',
                          field: "jobNo",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الدرجة',
                          field: "draga",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مسمى الوظيفة',
                          field: "jobName",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حالة الوظيفة',
                          field: "jobState",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم السحل المدني',
                          field: "cardId",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم الحفيظة',
                          field: "bok",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ الحفيظة',
                          field: "datBok",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ بداية الخدمة',
                          field: "datWork",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ شغل الوظيفة',
                          field: "datJob",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المؤهل العلمي',
                          field: "education",
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب الأساسي',
                          field: "salary",
                          type: PlutoColumnType.text(),
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
