import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:personnel_management/feature/employee/presentation/pages/employee_find.dart';
import 'package:personnel_management/feature/tarmeez_jobs/presentation/controllers/jobs_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../tarmeez_jobs/presentation/pages/jobs_find.dart';
import '../../../tarmeez_parts/presentation/controllers/parts_controller.dart';
import '../../../tarmeez_parts/presentation/pages/parts_find.dart';
import '../controllers/employee_find_controller.dart';
import '../controllers/employee_search_controller.dart';
import 'update_employee.dart';

class EmployeesSearch extends StatelessWidget {
  const EmployeesSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeSearchController>();
    final findController = Get.find<EmployeeFindController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextField(
                            enabled: false,
                            controller: controller.id,
                            label: 'الموظف',
                            customHeight: 35,
                            customWidth: 70,
                          ),
                          CustomTextField(
                            enabled: false,
                            controller: controller.empName,
                            label: '',
                            customHeight: 35,
                            customWidth: 240,
                          ),
                          CustomButton(
                            text: "اختر",
                            onPressed: () {
                              findController.clearControllers();
                              Get.dialog(
                                EmployeesFind(
                                  onSelected: (event) {
                                    Map<String, PlutoCell> cells =
                                        event.row!.cells;
                                    controller.id.text =
                                        cells['id']!.value.toString();
                                    controller.empName.text =
                                        cells['name']!.value.toString();
                                    Get.back();
                                  },
                                ),
                              );
                              findController.findEmployee();
                            },
                            height: 35,
                            width: 100,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextField(
                            enabled: false,
                            controller: controller.jobId,
                            label: 'الوظيفة',
                            customHeight: 35,
                            customWidth: 70,
                          ),
                          CustomTextField(
                            enabled: false,
                            controller: controller.jobName,
                            label: '',
                            customHeight: 35,
                            customWidth: 240,
                          ),
                          CustomButton(
                            text: "اختر",
                            onPressed: () {
                              Get.find<JobsController>()
                                  .clearControllersForSearch();
                              Get.dialog(
                                JobsFind(
                                  onSelected: (event) {
                                    Map<String, PlutoCell> cells =
                                        event.row!.cells;
                                    controller.jobId.text =
                                        cells['id']!.value.toString();
                                    controller.jobName.text =
                                        cells['name']!.value.toString();
                                    Get.back();
                                  },
                                ),
                              );
                              Get.find<JobsController>().findAll();
                            },
                            height: 35,
                            width: 100,
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextField(
                            enabled: false,
                            controller: controller.partId,
                            label: 'القسم',
                            customHeight: 35,
                            customWidth: 70,
                          ),
                          CustomTextField(
                            enabled: false,
                            controller: controller.partName,
                            label: '',
                            customHeight: 35,
                            customWidth: 240,
                          ),
                          CustomButton(
                            text: "اختر",
                            onPressed: () {
                              Get.find<PartsController>()
                                  .clearControllersForSearch();
                              Get.dialog(
                                PartsFind(
                                  onSelected: (event) {
                                    Map<String, PlutoCell> cells =
                                        event.row!.cells;
                                    controller.partId.text =
                                        cells['id']!.value.toString();
                                    controller.partName.text =
                                        cells['name']!.value.toString();
                                    Get.back();
                                  },
                                ),
                              );
                              Get.find<PartsController>().findAll();
                            },
                            height: 35,
                            width: 100,
                          )
                        ],
                      ),
                      CustomTextField(
                        controller: controller.draga,
                        label: 'الدرجة',
                        customHeight: 35,
                        customWidth: 200,
                      ),
                      CustomDropdownButton(
                        label: 'حالة الوظيفة',
                        list: controller.jobStateList,
                        item: controller.jobState,
                        onChanged: controller.onChangedJobState,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: controller.name,
                        label: 'الاسم',
                        customHeight: 35,
                        customWidth: 200,
                      ),
                      CustomTextField(
                        controller: controller.cardId,
                        label: 'رقم السجل المدني',
                        customHeight: 35,
                        customWidth: 200,
                      ),
                      CustomTextField(
                        controller: controller.fia,
                        label: 'المرتبة',
                        customHeight: 35,
                        customWidth: 200,
                      ),
                      CustomDropdownButton(
                        label: 'نوع الوظيفة',
                        list: controller.empTypeList,
                        item: controller.empType,
                        onChanged: controller.onChangedJobWork,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: "بحث جديد",
                        onPressed: () => controller.clearControllers(),
                        height: 35,
                        width: 200,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20), // Add spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "بحث ",
                    onPressed: () => controller.findAll(),
                    height: 35,
                    width: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20), // Add spacing
              SizedBox(
                height: currentHeight - 100, // Define fixed height
                width: currentWidth - 40, // Define fixed width
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }
                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controller.employees
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "name": PlutoCell(value: item.name),
                                  "cardId": PlutoCell(value: item.cardId),
                                  "jobName": PlutoCell(value: item.jobName),
                                  "partName": PlutoCell(value: item.partName),
                                  "fia": PlutoCell(value: item.fia),
                                  "salary": PlutoCell(value: item.salary),
                                  "draga": PlutoCell(value: item.draga),
                                  "jobState": PlutoCell(value: item.jobState),
                                  "workJob": PlutoCell(value: item.workJob),
                                },
                              ))
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'الرمز',
                          field: 'id',
                          type: PlutoColumnType.text(),
                        ),
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
                          title: 'اسم القسم',
                          field: 'partName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفئة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب',
                          field: 'salary',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الدرجة',
                          field: 'draga',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حالة الوظيفة',
                          field: 'jobState',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'العمل المكلف به',
                          field: 'workJob',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onSelected: (event) {
                        controller.findById(event.row!.cells['id']!.value);
                        Get.dialog(const UpdateEmployee());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
