import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_hasmiat_det_controller.dart';
import '../controllers/emp_hasmiat_search_controller.dart';
import 'update_hasmiat.dart';

class HasmiatSearch extends StatelessWidget {
  const HasmiatSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHasmiatSearchController>();
    final controllerDet = Get.find<EmpHasmiatDetController>();
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
                    label: 'الاسم',
                    customHeight: 25,
                    customWidth: 300,
                  ),
                  CustomTextField(
                    controller: controller.cardId,
                    label: 'رقم السجل المدني',
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
              const SizedBox(height: 16), // Add spacing
              Obx(
                () => Text("عدد السجلات المسترجعة: ${controller.length}"),
              ).center(),
              SizedBox(
                height: currentHeight - 100, // Define fixed height
                // width: currentWidth * 0.95, // Define fixed width
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const CustomProgressIndicator();
                    }

                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controller.empHasmiats
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "cardId":
                                    PlutoCell(value: item.cardId.getValue()),
                                "employeeName": PlutoCell(
                                    value: item.employeeName.getValue()),
                                "jobName":
                                    PlutoCell(value: item.jobName.getValue()),
                                "qrarId":
                                    PlutoCell(value: item.qrarId.getValue()),
                                "datQrar":
                                    PlutoCell(value: item.datQrar.getValue()),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'الرمز',
                          field: 'id',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم السجل المدني',
                          field: 'cardId',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'اسم الموظف',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الوظيفة',
                          field: 'jobName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم القرار',
                          field: 'qrarId',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ القرار',
                          field: 'datQrar',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onRowDoubleTap: (event) async {
                        int hasmiatId = int.parse(event.row.cells['id']!.value);
                        await controller.findById(hasmiatId);
                        await controllerDet.getHasmiatDetByHasmiatId(hasmiatId);
                        controllerDet.resetSelectedRow();
                        Get.dialog(const UpdateHasmiat());
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
