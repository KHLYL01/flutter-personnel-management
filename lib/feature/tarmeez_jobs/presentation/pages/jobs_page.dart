import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/jobs_controller.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobsController>();
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
                      label: "رمز الوظيفة",
                      customHeight: 30,
                      customWidth: currentWidth / 5,
                    ),
                  ],
                ).marginOnly(right: 20),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.name,
                      label: "اسم الوظيفة",
                      customHeight: 30,
                      customWidth: currentWidth / 3,
                    ),
                  ],
                ).marginOnly(right: 20),
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
                    configuration: getPlutoConfig(),
                    rows: controller.jobs
                        .map(
                          (item) => PlutoRow(cells: {
                            "id": PlutoCell(value: item.id),
                            "name": PlutoCell(value: item.name),
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
                        title: 'اسم الوظيفة',
                        field: 'name',
                        type: PlutoColumnType.text(),
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
