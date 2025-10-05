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
import '../controllers/emp_mobashra_search_report_controller.dart';

class MobashraReport extends StatelessWidget {
  const MobashraReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMobashraSearchReportController>();
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
                              enabled: controller.all.isFalse,
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
                                color: controller.all.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomTextField(
                              enabled: controller.all.isFalse,
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
                                color: controller.all.isFalse
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
                              enabled: controller.all.isFalse,
                              controller: controller.fromDateGo,
                              label: '',
                              withLable: false,
                              customHeight: 25,
                              customWidth: 200,
                            ),
                            Text(
                              "مـ",
                              style: TextStyle(
                                color: controller.all.isFalse
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 16),
                            CustomTextField(
                              enabled: controller.all.isFalse,
                              controller: controller.toDateGo,
                              label: '',
                              withLable: false,
                              customHeight: 25,
                              customWidth: 200,
                            ),
                            Text(
                              "مـ",
                              style: TextStyle(
                                color: controller.all.isFalse
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
                          value: controller.all.value,
                          onChanged: (value) {
                            controller.all(value);
                          },
                        ),
                      ],
                    )
                  ],
                ),
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
                      rows: controller.empMobashras
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
                                "cardId": PlutoCell(
                                  value: item.cardId.getValue(),
                                ),
                                "fia": PlutoCell(
                                  value: item.fia.getValue(),
                                ),
                                "draga": PlutoCell(
                                  value: item.draga.getValue(),
                                ),
                                "salary": PlutoCell(
                                  value: item.salary.getValue(),
                                ),
                                "naqlBadal": PlutoCell(
                                  value: item.naqlBadal.getValue(),
                                ),
                                "datMobashra": PlutoCell(
                                  value: item.datMobashra.getValue(),
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
                          title: 'رقم السجل / الإقامة',
                          field: 'cardId',
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
                          title: 'الراتب',
                          field: 'salary',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل النقل',
                          field: 'naqlBadal',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ المباشرة',
                          field: 'datMobashra',
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
