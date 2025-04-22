import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_type_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/pages/holiday_type_find.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/pages/update_holiday.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_find_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_holiday_search_controller.dart';

class HolidaySearch extends StatelessWidget {
  const HolidaySearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHolidaySearchController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextField(
                            enabled: false,
                            controller: controller.empId,
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
                              Get.find<EmployeeFindController>()
                                  .clearControllers();
                              Get.dialog(
                                EmployeesFind(
                                  onSelected: (event) {
                                    Map<String, PlutoCell> cells =
                                        event.row!.cells;
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
                            width: 100,
                          )
                        ],
                      ),
                      CustomTextField(
                        controller: controller.name,
                        label: 'البحث بإسم :',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        controller: controller.cardId,
                        label: 'رقم السجل المدني',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      // CustomTextField(
                      //   controller: controller.empType,
                      //   label: 'نوع بيانات الوظيفة',
                      //   customHeight: 35,
                      //   customWidth: 300,
                      // ),

                      CustomDropdownButton(
                        label: "نوع بيانات الوظيفة",
                        list: controller.empTypeList,
                        item: controller.empType,
                        onChanged: controller.onChangedEmpType,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomTextField(
                            enabled: false,
                            controller: controller.holidayTypeId,
                            label: 'نوع الإجازة',
                            customHeight: 35,
                            customWidth: 70,
                          ),
                          CustomTextField(
                            enabled: false,
                            controller: controller.holidayType,
                            label: '',
                            customHeight: 35,
                            customWidth: 240,
                          ),
                          CustomButton(
                            text: "اختر",
                            onPressed: () {
                              Get.dialog(
                                HolidayTypeFind(
                                  onSelected: (event) {
                                    Map<String, PlutoCell> cells =
                                        event.row!.cells;
                                    controller.holidayTypeId.text =
                                        cells['id']!.value.toString();
                                    controller.holidayType.text =
                                        cells['name']!.value.toString();
                                    Get.back();
                                  },
                                ),
                              );
                              Get.find<EmpHolidayTypeController>().findAll();
                            },
                            height: 35,
                            width: 100,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ).scrollDirection(Axis.horizontal).paddingAll(15),

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
                  CustomButton(
                    text: "بحث جديد",
                    onPressed: () => controller.clearControllers(),
                    height: 35,
                    width: 100,
                  )
                ],
              ),
              const SizedBox(height: 20), // Add spacing
              SizedBox(
                height: currentHeight - 100, // Define fixed height
                // width: currentWidth * 0.95, // Define fixed width
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }

                    return PlutoGrid(
                      configuration:getPlutoConfig(),

                      rows: controller.empHolidays
                          .map((item) => PlutoRow(cells: {
                                "id": PlutoCell(value: item.id),
                                // "startDate": PlutoCell(value: item.startDate),
                                "cardId": PlutoCell(value: item.cardId),
                                "employeeName":
                                    PlutoCell(value: item.employeeName),
                                "jobName": PlutoCell(value: item.jobName),
                                "holidayType":
                                    PlutoCell(value: item.holidayType),
                                "holidayStartDate":
                                    PlutoCell(value: item.holidayStartDate),
                                "holidayEndDate":
                                    PlutoCell(value: item.holidayEndDate),
                                "period": PlutoCell(value: item.period),
                                "employmentType":
                                    PlutoCell(value: item.employmentType),
                                "etemad": PlutoCell(
                                    value: item.etemad == 0 ? "لا" : "نعم"),
                                // "etemad": PlutoCell(value: item.etemad),
                              }))
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'الرمز',
                          field: 'id',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'رقم السجل المدني',
                          field: 'cardId',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'اسم الموظف',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الوظيفة',
                          field: 'jobName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'نوع الإجازة',
                          field: 'holidayType',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ بداية الإجازة',
                          field: 'holidayStartDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ انتهاء الإجازة',
                          field: 'holidayEndDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مدة الإجازة',
                          field: 'period',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'نوع الوظيفة',
                          field: 'employmentType',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الاعتماد',
                          field: 'etemad',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onSelected: (event) {
                        controller.findById(event.row!.cells['id']!.value);
                        Get.find<EmpHolidayController>().empName.text =
                            event.row!.cells['employeeName']!.value.toString();
                        Get.find<EmpHolidayController>().holidayTypeName.text =
                            event.row!.cells['holidayType']!.value.toString();
                        Get.dialog(const UpdateHoliday());
                      },
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
