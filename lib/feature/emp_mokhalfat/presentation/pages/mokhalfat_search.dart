import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/pages/update_mokhalfat.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_mokhalfat_search_controller.dart';

class MokhalfatSearch extends StatelessWidget {
  const MokhalfatSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMokhalfatSearchController>();
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
                  customWidth: 300,
                ),
                CustomTextField(
                  controller: controller.cardId,
                  label: 'رقم السجل المدني',
                  customHeight: 25,
                  customWidth: 300,
                ),
              ],
            ).scrollDirection(Axis.horizontal).paddingAll(15),
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
            const SizedBox(height: 16), // Add spacing
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
                    rows: controller.empMokhalfats
                        .map((item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id),
                                "cardId": PlutoCell(value: item.cardId),
                                "employeeName":
                                    PlutoCell(value: item.employeeName),
                                "jobName": PlutoCell(value: item.jobName),
                                "periodFrom": PlutoCell(value: item.periodFrom),
                                "periodTo": PlutoCell(value: item.periodTo),
                                "mokhalfaType":
                                    PlutoCell(value: item.mokhalfaType),
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
                        title: 'الفترة من',
                        field: 'periodFrom',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'إلى',
                        field: 'periodTo',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'نوع المخالفة',
                        field: 'mokhalfaType',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {
                      controller.findById(event.row!.cells['id']!.value);
                      Get.dialog(const UpdateMokhalfat());
                    },
                  );
                },
              ),
            ).paddingAll(15),
          ],
        ),
      )),
    );
  }
}
