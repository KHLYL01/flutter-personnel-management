import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_controller.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/pages/update_kashf_tepy.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_kashf_tepy_search_controller.dart';

class KashfTepySearch extends StatelessWidget {
  const KashfTepySearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpKashfTepySearchController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      CustomTextField(
                          controller: controller.name,
                          label: 'الاسم',
                          customHeight: 35,
                          customWidth: 300),
                      CustomTextField(
                          controller: controller.cardId,
                          label: 'رقم السجل المدني',
                          customHeight: 35,
                          customWidth: 300),
                      CustomDropdownButton(
                        label: 'نوع الوظيفة',
                        item: controller.empType,
                        list: controller.empTypeList,
                        onChanged: controller.onChangedEmpType,
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

                      rows: controller.empKashfTepys
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "cardId": PlutoCell(value: item.cardId),
                                  "employeeName":
                                      PlutoCell(value: item.employeeName),
                                  "jobName": PlutoCell(value: item.jobName),
                                  "requestDate":
                                      PlutoCell(value: item.requestDate),
                                  "employeeStatus":
                                      PlutoCell(value: item.employeeStatus),
                                  "medicalUnitName":
                                      PlutoCell(value: item.medicalUnitName),
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
                          title: 'تاريخ الطلب',
                          field: 'requestDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'حالة الموظف',
                          field: 'employeeStatus',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الوحدة الصحية',
                          field: 'medicalUnitName',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onSelected: (event) {
                        controller.findById(event.row!.cells['id']!.value);
                        Get.dialog(const UpdateKashfTepy());
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
