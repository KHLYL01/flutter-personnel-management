import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/pages/holiday_type_find.dart';
import 'package:personnel_management/feature/employee/data/repository/employee_repository.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_holiday_controller.dart';
import '../controllers/emp_holiday_search_report_controller.dart';

class HolidayReport extends StatelessWidget {
  const HolidayReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHolidaySearchReportController>();
    final controllerHoliday = Get.find<EmpHolidayController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker fromDate =
        HijriPicker(controller.fromDate, controller.fromDateGo);
    HijriPicker toDate = HijriPicker(controller.toDate, controller.toDateGo);

    HijriPicker dayDate = HijriPicker(controller.dayDate);
    HijriPicker startWorkDate = HijriPicker(controller.startWorkDate);

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
                    onPressed: () async {
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
                      final empRepoController = Get.find<EmployeeRepository>();
                      (await empRepoController
                              .findById(int.parse(controller.empId.text)))
                          .fold(
                        (l) => l,
                        (r) {
                          controller.empType = r.empType ?? "";
                          controller.takenHoliday = r.takenHolidays ?? 0;
                          controller.startWorkDate.text = r.datWork ?? "";

                          controllerHoliday.empId.text = controller.empId.text;
                          controllerHoliday.empType = r.empType ?? "";
                          controllerHoliday.takenHoliday = r.takenHolidays ?? 0;
                          controllerHoliday.startWorkDate.text =
                              r.datWork ?? "";
                        },
                      );
                    },
                    height: 35,
                    width: 75,
                  ).paddingOnly(top: 15),
                  CustomButton(
                    text: 'إلغاء',
                    onPressed: () {
                      controller.empId.clear();
                      controller.empName.clear();
                    },
                    height: 35,
                    width: 75,
                  ).paddingOnly(top: 15),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.holidayTypeId,
                    label: 'نوع الإجازة',
                    customHeight: 25,
                    customWidth: currentWidth * 0.07,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.holidayType,
                    label: '',
                    customHeight: 25,
                    customWidth: 300,
                  ),
                  CustomButton(
                    text: 'اختر',
                    onPressed: () {
                      Get.dialog(
                        HolidayTypeFind(
                          onRowDoubleTap: (event) {
                            Map<String, PlutoCell> cells = event.row.cells;
                            controller.holidayTypeId.text =
                                cells['id']!.value.toString();
                            controller.holidayType.text =
                                cells['name']!.value.toString();
                            Get.back();
                          },
                        ),
                      );
                    },
                    height: 35,
                    width: 75,
                  ).paddingOnly(top: 15),
                  CustomButton(
                    text: 'إلغاء',
                    onPressed: () {
                      controller.holidayTypeId.clear();
                      controller.holidayType.clear();
                    },
                    height: 35,
                    width: 75,
                  ).paddingOnly(top: 15),
                ],
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              enabled: controller.isAll.isFalse,
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
                            Text(
                              "هـ",
                              style: TextStyle(
                                color: controller.isAll.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomTextField(
                              enabled: controller.isAll.isFalse,
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
                            Text(
                              "هـ",
                              style: TextStyle(
                                color: controller.isAll.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              enabled: controller.isAll.isFalse,
                              controller: controller.fromDateGo,
                              label: '',
                              withLable: false,
                              customHeight: 25,
                              customWidth: 200,
                            ),
                            Text(
                              "مـ",
                              style: TextStyle(
                                color: controller.isAll.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomTextField(
                              enabled: controller.isAll.isFalse,
                              controller: controller.toDateGo,
                              label: '',
                              withLable: false,
                              customHeight: 25,
                              customWidth: 200,
                            ),
                            Text(
                              "مـ",
                              style: TextStyle(
                                color: controller.isAll.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        const Text("الكل"),
                        const SizedBox(width: 4),
                        Checkbox(
                          value: controller.isAll.value,
                          onChanged: (value) {
                            controller.isAll(value);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    controller: controller.fromPeriod,
                    label: 'الفترة من',
                    customHeight: 25,
                    customWidth: 150,
                  ),
                  Text(
                    "يوم",
                    style: TextStyle(
                      color:
                          controller.isAll.isFalse ? Colors.black : Colors.grey,
                    ),
                  ),
                  SizedBox(width: 16),
                  CustomTextField(
                    controller: controller.toPeriod,
                    label: 'إلى',
                    customHeight: 25,
                    customWidth: 150,
                  ),
                  Text(
                    "يوم",
                    style: TextStyle(
                      color:
                          controller.isAll.isFalse ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    enabled: controller.isAll.isFalse,
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => dayDate.pickHijriDate(context),
                    controller: controller.dayDate,
                    label: 'تاريخ اليوم',
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  Text(
                    "هـ",
                    style: TextStyle(
                      color:
                          controller.isAll.isFalse ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomTextField(
                    enabled: controller.isAll.isFalse,
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => startWorkDate.pickHijriDate(context),
                    controller: controller.startWorkDate,
                    label: 'تاريخ بداية الخدمة',
                    customHeight: 25,
                    customWidth: 200,
                  ),
                  Text(
                    "هـ",
                    style: TextStyle(
                      color:
                          controller.isAll.isFalse ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
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
                      rows: controller.empHolidays
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "employeeName": PlutoCell(
                                  value: item.employeeName.getValue(),
                                ),
                                "jobName": PlutoCell(
                                  value: item.jobName.getValue(),
                                ),
                                "startDate": PlutoCell(
                                  value: item.startDate.getValue(),
                                ),
                                "fia": PlutoCell(
                                  value: item.fia.getValue(),
                                ),
                                "draga": PlutoCell(
                                  value: item.draga.getValue(),
                                ),
                                "holidayType": PlutoCell(
                                  value: item.holidayType.getValue(),
                                ),
                                "period": PlutoCell(
                                  value: item.period.getValue(),
                                ),
                                // "tamdeedPeriod": PlutoCell(
                                //   value: item.tamdeedPeriod.getValue(),
                                // ),
                                // "tamdeedStartDate": PlutoCell(
                                //   value: item.tamdeedStartDate.getValue(),
                                // ),
                                // "tamdeedEndDate": PlutoCell(
                                //   value: item.tamdeedEndDate.getValue(),
                                // ),
                                "holidayStartDate": PlutoCell(
                                  value: item.holidayStartDate.getValue(),
                                ),
                                "holidayEndDate": PlutoCell(
                                  value: item.holidayEndDate.getValue(),
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
                          title: 'اسم',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'مسمى الوظيفة',
                          field: 'jobName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ بداية الخدمة',
                          field: 'startDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المرتبة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الدرجة',
                          field: 'draga',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'نوع الإجازة',
                          field: 'holidayType',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المدة',
                          field: 'period',
                          type: PlutoColumnType.text(),
                        ),
                        // PlutoColumn(
                        //   title: 'مدة التمديد',
                        //   field: 'tamdeedPeriod',
                        //   type: PlutoColumnType.text(),
                        // ),
                        // PlutoColumn(
                        //   title: 'تاريخ بداية التمديد',
                        //   field: 'tamdeedStartDate',
                        //   type: PlutoColumnType.text(),
                        // ),
                        // PlutoColumn(
                        //   title: 'تاريخ نهاية التمديد',
                        //   field: 'tamdeedEndDate',
                        //   type: PlutoColumnType.text(),
                        // ),
                        PlutoColumn(
                          title: 'تاريخ بداية الإجازة',
                          field: 'holidayStartDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ نهاية الإجازة',
                          field: 'holidayEndDate',
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
