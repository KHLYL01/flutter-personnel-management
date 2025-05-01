import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_controller.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_search_controller.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/pages/update_mobashra.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';

class MobashraSearch extends StatelessWidget {
  const MobashraSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMobashraSearchController>();
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
                  CustomTextField(
                      controller: controller.name,
                      label: 'الاسم',
                      customHeight: 25,
                      customWidth: 300),
                  CustomTextField(
                      controller: controller.cardId,
                      label: 'رقم السجل المدني',
                      customHeight: 25,
                      customWidth: 300),
                  CustomDropdownButton(
                    label: 'نوع الوظيفة',
                    item: controller.empType,
                    list: controller.empTypeList,
                    onChanged: controller.onChangedEmpType,
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
              const SizedBox(height: 20), // Add spacing
              Obx(
                () => Text("عدد السجلات المسترجعة: ${controller.length}"),
              ).center(),
              SizedBox(
                height: currentHeight - 100, // Define fixed height
                // width: currentWidth * 0.95, // Define fixed width
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomProgressIndicator();
                  }
                  return PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.empMobashras
                        .map((item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id),
                                "cardId": PlutoCell(value: item.cardId),
                                "employeeName":
                                    PlutoCell(value: item.employeeName),
                                "jobName": PlutoCell(value: item.jobName),
                                "fia": PlutoCell(value: item.fia),
                                "draga": PlutoCell(value: item.draga),
                                "salary": PlutoCell(value: item.salary),
                                "naqlBadal": PlutoCell(value: item.naqlBadal),
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
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onRowDoubleTap: (event) {
                      controller.findById(event.row.cells['id']!.value);
                      Get.find<EmpMobashraController>().empName.text =
                          event.row.cells['employeeName']!.value.toString();
                      Get.find<EmpMobashraController>().salary.text =
                          event.row.cells['salary']!.value.toString();
                      Get.find<EmpMobashraController>().draga.text =
                          event.row.cells['draga']!.value.toString();
                      Get.find<EmpMobashraController>().naqlBadal.text =
                          event.row.cells['naqlBadal']!.value.toString();
                      Get.find<EmpMobashraController>().mrtaba.text =
                          event.row.cells['fia']!.value.toString();
                      Get.dialog(const UpdateMobashra());
                    },
                  );
                }),
              ).paddingAll(15),
            ],
          ),
        ),
      ),
    );
  }
}
