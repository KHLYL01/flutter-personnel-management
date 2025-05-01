import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/badal_countries_controller.dart';

class BadalCountriesPage extends StatelessWidget {
  const BadalCountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BadalCountriesController>();
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
                  label: "رمز التصنيف",
                  customHeight: 30,
                  customWidth: currentWidth / 5,
                ).marginOnly(right: 20),
                CustomTextField(
                  controller: controller.name,
                  label: "اسم الدولة",
                  customHeight: 30,
                  customWidth: currentWidth / 5,
                ).marginOnly(right: 20),
                CustomTextField(
                  controller: controller.countryClass,
                  label: "الفئة",
                  customHeight: 30,
                  customWidth: currentWidth / 5,
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
                const SizedBox(height: 16),
                Obx(
                  () => Text("عدد السجلات المسترجعة: ${controller.length}"),
                ).center(),
                SizedBox(
                  height: currentHeight - 100,
                  child: PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.badalCountries
                        .map(
                          (item) => PlutoRow(cells: {
                            "id": PlutoCell(value: item.id),
                            "name": PlutoCell(value: item.name),
                            "countryClass": PlutoCell(value: item.countryClass),
                          }),
                        )
                        .toList(),
                    columns: [
                      PlutoColumn(
                        // enableRowChecked: true,
                        title: 'رمز التصنيف',
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
                        title: 'اسم الدولة',
                        field: 'name',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الفئة',
                        field: 'countryClass',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onRowDoubleTap: (event) {
                      controller.fillControllers(event.row.cells);
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
