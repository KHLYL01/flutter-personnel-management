import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/nations_controller.dart';

class NationsFind extends StatelessWidget {
  const NationsFind({
    super.key,
    required this.onRowDoubleTap,
  });

  final PlutoOnRowDoubleTapEventCallback onRowDoubleTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NationsController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: ListView(
        children: [
          Row(
            children: [
              CustomTextField(
                controller: controller.id,
                label: "رمز الجنسية",
                customHeight: 30,
                customWidth: currentWidth / 5,
              ),
            ],
          ).marginOnly(right: 20),
          Row(
            children: [
              CustomTextField(
                controller: controller.name,
                label: "اسم الجنسية",
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
                text: 'بحث جديد',
                onPressed: () => controller.clearControllersForSearch(),
                height: 40,
                width: 140,
              ),
              CustomButton(
                text: 'بحث',
                onPressed: () => controller.findNations(),
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
            width: currentWidth - 140,
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const CustomProgressIndicator();
                }
                return PlutoGrid(
                  configuration: getPlutoConfig(),
                  rows: controller.nations
                      .map(
                        (item) => PlutoRow(cells: {
                          "id": PlutoCell(value: item.id.getValue()),
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
                    ),
                    PlutoColumn(
                      title: 'اسم الجنسية',
                      field: 'name',
                      type: PlutoColumnType.text(),
                    ),
                  ],
                  mode: PlutoGridMode.selectWithOneTap,
                  onRowDoubleTap: onRowDoubleTap,
                );
              },
            ),
          ).paddingAll(16)
        ],
      ),
    );
  }
}
