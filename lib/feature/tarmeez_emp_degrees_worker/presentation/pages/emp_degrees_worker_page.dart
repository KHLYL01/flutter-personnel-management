import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_degrees_worker_controller.dart';

class EmpDegreesWorkerPage extends StatelessWidget {
  const EmpDegreesWorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDegreesWorkerController>();
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
                      controller: controller.fia,
                      label: "الفئة",
                      customHeight: 30,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      controller: controller.draga,
                      label: 'الدرجة',
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
                const SizedBox(height: 16),
                Obx(
                  () => Text("عدد السجلات المسترجعة: ${controller.length}"),
                ).center(),
                SizedBox(
                  height: currentHeight - 100,
                  child: PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.empDegreesWorker
                        .map(
                          (item) => PlutoRow(cells: {
                            "id": PlutoCell(value: item.id.getValue()),
                            "fia": PlutoCell(value: item.fia.getValue()),
                            "draga": PlutoCell(value: item.draga.getValue()),
                            "salary": PlutoCell(value: item.salary.getValue()),
                            "naqlBadal":
                                PlutoCell(value: item.naqlBadal.getValue()),
                            "elawa": PlutoCell(value: item.elawa.getValue()),
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
                        field: 'fia',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الدرجة',
                        field: 'draga',
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
                ).paddingAll(16)
              ],
            );
          },
        ),
      ),
    );
  }
}
