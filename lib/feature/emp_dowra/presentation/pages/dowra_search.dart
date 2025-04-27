import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/pages/update_dowra.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_dowra_search_controller.dart';

class DowraSearch extends StatelessWidget {
  const DowraSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDowraSearchController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                    height: 25,
                    onPressed: () => controller.clearControllers(),
                    width: 100,
                  )
                ],
              ),
              const SizedBox(height: 16), // Add spacing
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
                      rows: controller.empDowras
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "dowraId": PlutoCell(value: item.dowraId),
                                "employeeName":
                                    PlutoCell(value: item.employeeName),
                                "fia": PlutoCell(value: item.fia),
                                "draga": PlutoCell(value: item.draga),
                                "salary": PlutoCell(value: item.salary),
                                "naqlBadal": PlutoCell(value: item.naqlBadal),
                                "jobName": PlutoCell(value: item.jobName),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'رمز القرار',
                          field: 'dowraId',
                          type: PlutoColumnType.number(),
                        ),
                        PlutoColumn(
                          title: 'اسم الموظف',
                          field: 'employeeName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفئة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
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
                          title: 'الوظيفة',
                          field: 'jobName',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onSelected: (event) {
                        controller.findById(event.row?.cells['dowraId']?.value);
                        Get.dialog(const UpdateDowra());
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
