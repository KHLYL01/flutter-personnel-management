import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_degrees_find_controller.dart';

class EmpDegreesFindPage extends StatelessWidget {
  const EmpDegreesFindPage({
    super.key,
    required this.onRowDoubleTap,
  });

  final PlutoOnRowDoubleTapEventCallback onRowDoubleTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDegreesFindController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
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
                    controller: controller.martaba,
                    label: 'المرتبة',
                    customHeight: 30,
                    customWidth: currentWidth * 0.1,
                  ),
                  CustomTextField(
                    controller: controller.draga,
                    label: 'الدرجة',
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
                    text: 'بحث جديدة',
                    onPressed: () => controller.clearControllers(),
                    height: 40,
                    width: 140,
                  ),
                  CustomButton(
                    text: 'بحث',
                    onPressed: () => controller.findEmpDegrees(),
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
                  rows: controller.empDegreess
                      .map(
                        (item) => PlutoRow(cells: {
                          "id": PlutoCell(value: item.id),
                          "type": PlutoCell(value: item.type),
                          "martaba": PlutoCell(value: item.martaba),
                          "draga": PlutoCell(value: item.draga),
                          "salary": PlutoCell(value: item.salary),
                          "naqlBadal": PlutoCell(value: item.naqlBadal),
                          "elawa": PlutoCell(value: item.elawa),
                          "inEntedabBadal":
                              PlutoCell(value: item.inEntedabBadal),
                          "outEntedabadal":
                              PlutoCell(value: item.outEntedabadal),
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
                      title: 'الفئة',
                      field: 'type',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'المرتبة',
                      field: 'martaba',
                      type: PlutoColumnType.number(),
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
                      title: 'بدل النقل',
                      field: 'naqlBadal',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'علاوة',
                      field: 'elawa',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'بدل انتداب داخلي',
                      field: 'inEntedabBadal',
                      type: PlutoColumnType.number(),
                    ),
                    PlutoColumn(
                      title: 'بدل انتداب خارجي',
                      field: 'outEntedabadal',
                      type: PlutoColumnType.number(),
                    ),
                  ],
                  mode: PlutoGridMode.selectWithOneTap,
                  onRowDoubleTap: onRowDoubleTap,
                ),
              ).paddingAll(16)
            ],
          );
        },
      ),
    );
  }
}
