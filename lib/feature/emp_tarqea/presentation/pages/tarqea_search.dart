import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_tarqea/presentation/pages/update_tarqea.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_tarqea_search_controller.dart';

class TarqeaSearch extends StatelessWidget {
  const TarqeaSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpTarqeaSearchController>();
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
                    label: 'اسم الموظف',
                    customHeight: 25,
                    customWidth: 300,
                  ),
                  CustomTextField(
                    controller: controller.qrarId,
                    label: 'رقم القرار',
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
              const SizedBox(height: 16),
              Obx(
                () => Text("عدد السجلات المسترجعة: ${controller.length}"),
              ).center(),
              SizedBox(
                height: currentHeight - 100,
                // width: currentWidth * 0.95,
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }
                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controller.empTarqeas
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "employeeName":
                                      PlutoCell(value: item.employeeName),
                                  "qrarId": PlutoCell(value: item.qrarId),
                                  "qrarDate": PlutoCell(value: item.qrarDate),
                                  "oldFia": PlutoCell(value: item.oldFia),
                                  "newFia": PlutoCell(value: item.newFia),
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
                          title: 'اسم الموظف',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم القرار',
                          field: 'qrarId',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ القرار',
                          field: 'qrarDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفئة القديمة',
                          field: 'oldFia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفئة الجديدة',
                          field: 'newFia',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onRowDoubleTap: (event) {
                        controller.findById(event.row.cells['id']!.value);
                        Get.dialog(const UpdateTarqea());
                      },
                    );
                  },
                ),
              ).paddingAll(15),
            ],
          ),
        ),
      ),
    );
  }
}
