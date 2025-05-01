import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_entedab_det_controller.dart';
import '../controllers/emp_entedab_search_controller.dart';
import 'update_entedab.dart';

class EntedabSearch extends StatelessWidget {
  const EntedabSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEntedabSearchController>();
    final controllerDet = Get.find<EmpEntedabDetController>();
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
                    controller: controller.employeeName,
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
                  CustomTextField(
                    controller: controller.entedabPlace,
                    label: 'جهة الانتداب',
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
                      rows: controller.empEntedabs
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "cardId": PlutoCell(value: item.cardId),
                                  "employeeName":
                                      PlutoCell(value: item.employeeName),
                                  "jobTitle": PlutoCell(value: item.jobTitle),
                                  "entedabPlace":
                                      PlutoCell(value: item.entedabPlace),
                                  "period": PlutoCell(value: item.period),
                                  "assignmentStartDate": PlutoCell(
                                      value: item.assignmentStartDate),
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
                          field: 'jobTitle',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'جهة الانتداب',
                          field: 'entedabPlace',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المدة',
                          field: 'period',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ بداية الانتداب',
                          field: 'assignmentStartDate',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onRowDoubleTap: (event) async {
                        int entedabId = event.row.cells['id']!.value;
                        await controller.findById(entedabId);
                        await controllerDet.getEntedabDetByEntedabId(entedabId);
                        Get.dialog(const UpdateEntedab());
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
