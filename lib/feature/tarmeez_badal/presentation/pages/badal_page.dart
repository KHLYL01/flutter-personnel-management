import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/badal_controller.dart';

class BadalPage extends StatelessWidget {
  const BadalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BadalController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(body: BaseScreen(widget: Center(
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }

          return ListView(
            children: [
              Row(
                children: [
                  CustomTextField(
                    controller: controller.id,
                    label: "الرمز",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                    enabled: false,
                  ),
                  CustomTextField(
                    controller: controller.martaba,
                    label: "المرتبة",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                  CustomTextField(
                    controller: controller.internal,
                    label: "داخلي",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                ],
              ).scrollDirection(Axis.horizontal).marginOnly(right: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: controller.classA,
                    label: "الفئة أ ",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                  CustomTextField(
                    controller: controller.classB,
                    label: "الفئة ب",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                  CustomTextField(
                    controller: controller.classC,
                    label: "الفئة ج",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                  CustomTextField(
                    controller: controller.highLiving,
                    label: "مرتفعة المعيشة ",
                    customHeight: 25,
                    customWidth: currentWidth / 10,
                  ),
                ],
              ).scrollDirection(Axis.horizontal).marginOnly(right: 20),
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
                  rows: controller.badals
                      .map(
                        (item) => PlutoRow(cells: {
                          "id": PlutoCell(value: item.id),
                          "classA": PlutoCell(value: item.classA),
                          "classB": PlutoCell(value: item.classB),
                          "classC": PlutoCell(value: item.classC),
                          "martaba": PlutoCell(value: item.martaba),
                          "highLiving": PlutoCell(value: item.highLiving),
                          "internal": PlutoCell(value: item.internal),
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
                      title: 'المرتبة',
                      field: 'martaba',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'داخلي',
                      field: 'internal',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'الفئة أ',
                      field: 'classA',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'الفئة ب',
                      field: 'classB',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'الفئة ج',
                      field: 'classC',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'مرتفعة المعيشة',
                      field: 'highLiving',
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
    )));
  }
}
