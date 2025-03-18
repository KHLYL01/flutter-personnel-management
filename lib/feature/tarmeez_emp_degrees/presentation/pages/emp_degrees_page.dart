import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/emp_degrees_controller.dart';

// ToDo ==================================== check this

class EmpDegreesPage extends StatelessWidget {
  const EmpDegreesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDegreesController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    return Scaffold(
      body: BaseScreen(
        widget: Obx(
          () {
            if (controller.isLoading.value) {
              return const CustomProgressIndicator();
            }

            return ListView(
              children: [
                Row(
                  children: [
                    CustomTextField(
                      enabled: false,
                      controller: controller.id,
                      label: "الرمز",
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.martaba,
                      label: 'المرتبة',
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.salary,
                      label: 'الراتب',
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.type,
                      label: "الفئة",
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.naqlBadal,
                      label: 'بدل النقل',
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.elawa,
                      label: 'العلاوة',
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                  ],
                )
                    .scrollDirection(Axis.horizontal)
                    .marginOnly(right: 100, left: 100),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'اضافة جديدة',
                      onPressed: () => controller.clearControllers(),
                      height: 40,
                      width: 140,
                    ),
                    CustomButton(
                      text: 'حفظ',
                      onPressed: () => controller.save(),
                      height: 40,
                      width: 80,
                    ),
                  ],
                ),
                SizedBox(
                  height: currentHeight - 100,
                  child: PlutoGrid(
                    configuration: const PlutoGridConfiguration(
                      // style: PlutoGridStyleConfig.dark()
                      columnSize: PlutoGridColumnSizeConfig(
                        autoSizeMode: PlutoAutoSizeMode.equal,
                      ),
                    ),
                    rows: controller.empDegrees
                        .map(
                          (item) => PlutoRow(cells: {
                            "id": PlutoCell(value: item.id),
                            "type": PlutoCell(value: item.type),
                            "martaba": PlutoCell(value: item.martaba),
                            "salary": PlutoCell(value: item.salary),
                            "naqlBadal": PlutoCell(value: item.naqlBadal),
                            "elawa": PlutoCell(value: item.elawa),
                          }),
                        )
                        .toList(),
                    columns: [
                      PlutoColumn(
                        // enableRowChecked: true,
                        title: 'الرمز',
                        field: 'id',
                        type: PlutoColumnType.number(),
                        renderer: (rendererContext) => Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                controller
                                    .confirmDelete(rendererContext.cell.value);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Text(rendererContext.cell.value.toString()),
                          ],
                        ),
                      ),
                      PlutoColumn(
                        title: 'الفئة',
                        field: 'type',
                        type: PlutoColumnType.number(),
                      ),
                      PlutoColumn(
                        title: 'الدرجة',
                        field: 'martaba',
                        type: PlutoColumnType.number(),
                      ),
                      PlutoColumn(
                        title: 'الراتب',
                        field: 'salary',
                        type: PlutoColumnType.number(),
                      ),
                      PlutoColumn(
                        title: 'العلاوة',
                        field: 'elawa',
                        type: PlutoColumnType.number(),
                      ),
                      PlutoColumn(
                        title: 'بدل النقل',
                        field: 'naqlBadal',
                        type: PlutoColumnType.number(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {
                      controller.fillControllers(event.row!.cells);
                    },
                  ),
                ).paddingAll(20)
              ],
            );
          },
        ),
      ),
    );
  }
}
