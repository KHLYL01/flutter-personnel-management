import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_report_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';

class EndReport extends StatelessWidget {
  const EndReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEndSearchReportController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomTextField(
                          controller: controller.name,
                          label: 'اسم الموظف',
                          customHeight: 25,
                          customWidth: 300),
                    ],
                  ),
                ],
              ).scrollDirection(Axis.horizontal).paddingAll(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "بحث",
                    onPressed: () => controller.report(),
                    height: 25,
                    width: 100,
                  ),
                  CustomButton(
                    text: "تقرير",
                    onPressed: () => null,
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
                      rows: controller.empEnds
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "qrarId":
                                    PlutoCell(value: item.qrarId.getValue()),
                                "qrarDate":
                                    PlutoCell(value: item.qrarDate.getValue()),
                                "employeeName": PlutoCell(
                                    value: item.employeeName.getValue()),
                                "terminationDate": PlutoCell(
                                    value: item.terminationDate.getValue()),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'م',
                          field: 'id',
                          type: PlutoColumnType.number(),
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
                          title: 'اسم الموظف',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ الانتهاء',
                          field: 'terminationDate',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
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
