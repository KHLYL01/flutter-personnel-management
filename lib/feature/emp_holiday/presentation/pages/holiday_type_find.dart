import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_type_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/pluto_config.dart';

class HolidayTypeFind extends StatelessWidget {
  const HolidayTypeFind({
    super.key,
    required this.onRowDoubleTap,
  });

  final PlutoOnRowDoubleTapEventCallback onRowDoubleTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHolidayTypeController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    return Dialog(
      child: ListView(
        children: [
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
                  rows: controller.empHolidaysType
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
                      title: 'اسم الإجازة',
                      field: 'name',
                      type: PlutoColumnType.text(),
                    ),
                  ],
                  mode: PlutoGridMode.selectWithOneTap,
                  onRowDoubleTap: onRowDoubleTap,
                );
              },
            ),
          ).paddingAll(20)
        ],
      ),
    );
  }
}
