import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/employee_find_controller.dart';

class EmployeesFind extends StatelessWidget {
  const EmployeesFind({
    super.key,
    required this.onSelected,
  });

  final PlutoOnSelectedEventCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeFindController>();

    double currentHeight = Get.height;
    double currentWidth = Get.width;

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: "رقم الموظف",
              customHeight: 25,
              controller: controller.id,
              customWidth: 200,
            ).paddingSymmetric(horizontal: 40),
            CustomTextField(
              label: "اسم الموظف",
              controller: controller.name,
              customHeight: 25,
              customWidth: 200,
            ).paddingSymmetric(horizontal: 40),
            CustomTextField(
              label: "رقم السجل المدني",
              controller: controller.cardId,
              customHeight: 25,
              customWidth: 200,
            ).paddingSymmetric(horizontal: 40),
            CustomDropdownButton(
              label: 'نوع الوظيفة',
              list: controller.empTypeList,
              item: controller.empType,
              onChanged: controller.onChangedJobWork,
            ).paddingSymmetric(horizontal: 40),

            const SizedBox(height: 20), // Add spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "بحث ",
                  onPressed: () => controller.findEmployee(),
                  height: 25,
                  width: 100,
                ),
                CustomButton(
                  text: "بحث جديد",
                  onPressed: () => controller.clearControllers(),
                  height: 25,
                  width: 200,
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing
            SizedBox(
              height: currentHeight - 160, // Define fixed height
              width: currentWidth - 140, // Define fixed width
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const CustomProgressIndicator();
                  }
                  return PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.findEmployees
                        .map((item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id),
                                "name": PlutoCell(value: item.name),
                                "fia": PlutoCell(value: item.fia),
                                "draga": PlutoCell(value: item.draga),
                                "salary": PlutoCell(value: item.salary),
                                "naqlBadal": PlutoCell(value: item.naqlBadal),
                                "intentedabBadal":
                                    PlutoCell(value: item.intentedabBadal),
                                "empType": PlutoCell(value: item.empType),
                                "badal1": PlutoCell(value: item.badal1),
                                "badal2": PlutoCell(value: item.badal2),
                                "badal3": PlutoCell(value: item.badal3),
                                "badal4": PlutoCell(value: item.badal4),
                                "jobBadalat": PlutoCell(value: item.jobBadalat),
                                "maeesha": PlutoCell(value: item.maeesha),
                              },
                            ))
                        .toList(),
                    columns: [
                      PlutoColumn(
                        title: 'رقم الموظف',
                        field: 'id',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'اسم الموظف',
                        field: 'name',
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
                        title: 'بدل الانتداب',
                        field: 'intentedabBadal',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'نوع الوظيفة',
                        field: 'empType',
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
                        title: 'بدلات العمل',
                        field: 'jobBadalat',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'المعيشة',
                        field: 'maeesha',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: onSelected,
                  );
                },
              ),
            ).center(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
