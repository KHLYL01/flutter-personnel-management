import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_find_controller.dart';
import 'package:personnel_management/feature/employee/presentation/pages/employee_find.dart';
import 'package:personnel_management/feature/tafweed/presentation/pages/update_tafweed.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/tafweed_controller.dart';
import '../controllers/tafweed_search_controller.dart';

class TafweedSearch extends StatelessWidget {
  const TafweedSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TafweedSearchController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.empId,
                    label: 'الموظف',
                    customHeight: 25,
                    customWidth: 70,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.empName,
                    label: '',
                    customHeight: 25,
                    customWidth: 240,
                  ),
                  CustomButton(
                    text: "اختر",
                    onPressed: () {
                      Get.find<EmployeeFindController>().clearControllers();
                      Get.dialog(
                        EmployeesFind(
                          onRowDoubleTap: (event) {
                            Map<String, PlutoCell> cells = event.row!.cells;
                            controller.empId.text =
                                cells['id']!.value.toString();
                            controller.empName.text =
                                cells['name']!.value.toString();
                            Get.back();
                          },
                        ),
                      );
                      Get.find<EmployeeFindController>().findEmployee();
                    },
                    height: 25,
                    width: 100,
                  )
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
                      rows: controller.tafweeds
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "employeeName":
                                      PlutoCell(value: item.employeeName),
                                  "startDate": PlutoCell(value: item.startDate),
                                  "endDate": PlutoCell(value: item.endDate),
                                  "subject": PlutoCell(value: item.subject),
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
                          title: 'تاريخ البداية',
                          field: 'startDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ النهاية',
                          field: 'endDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الموضوع',
                          field: 'subject',
                          type: PlutoColumnType.text(),
                        ),
                        // PlutoColumn(
                        //   title: 'بداية خارج الدوام',
                        //   field: 'dateBegin',
                        //   type: PlutoColumnType.text(),
                        // ),
                        // PlutoColumn(
                        //   title: 'القسم',
                        //   field: 'place',
                        //   type: PlutoColumnType.text(),
                        // ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onRowDoubleTap: (event) {
                        controller.findById(event.row.cells['id']?.value);
                        Get.dialog(const UpdateTafweed());
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
