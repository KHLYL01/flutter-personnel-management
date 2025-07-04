import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/dissent_controller.dart';

class DissentPage extends StatelessWidget {
  const DissentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DissentController>();
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
                CustomTextField(
                  enabled: false,
                  controller: controller.id,
                  label: "رمز المخالفة",
                  customHeight: 30,
                  customWidth: currentWidth / 5,
                ).marginOnly(right: 20),
                CustomTextField(
                  controller: controller.name,
                  label: "اسم المخالفة",
                  customHeight: 30,
                  customWidth: currentWidth / 3,
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
                      onPressed: () {
                        if (checkSavePermission()) {
                          controller.save();
                        }
                      },
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
                    rows: controller.dissents
                        .map(
                          (item) => PlutoRow(cells: {
                            "id": PlutoCell(value: item.id?.getValue()),
                            "name": PlutoCell(value: item.name.getValue()),
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
                                if (checkDeletePermission()) {
                                  controller.confirmDelete(
                                      rendererContext.cell.value);
                                }
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
                        title: 'اسم المخالفة',
                        field: 'name',
                        type: PlutoColumnType.text(),
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
