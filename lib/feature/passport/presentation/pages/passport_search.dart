import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_controller.dart';
import 'package:personnel_management/feature/passport/presentation/pages/update_passport.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/passport_search_controller.dart';

class PassportSearch extends StatelessWidget {
  const PassportSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PassportSearchController>();
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
                    controller: controller.passportNumber,
                    label: 'رقم الجواز',
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
                      rows: controller.passports
                          .map((item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id.getValue()),
                                  "name":
                                      PlutoCell(value: item.name.getValue()),
                                  "declarationDate": PlutoCell(
                                      value: item.declarationDate.getValue()),
                                  "nationality": PlutoCell(
                                      value: item.nationality.getValue()),
                                  "passportNumber": PlutoCell(
                                      value: item.passportNumber.getValue()),
                                  "issuedBy": PlutoCell(
                                      value: item.issuedBy.getValue()),
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
                          title: 'الاسم',
                          field: 'name',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'تاريخ الإقرار',
                          field: 'declarationDate',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الجنسية',
                          field: 'nationality',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'رقم الجواز',
                          field: 'passportNumber',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'صادر عن',
                          field: 'issuedBy',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onRowDoubleTap: (event) {
                        controller
                            .findById(int.parse(event.row.cells['id']!.value));
                        Get.find<PassportController>().nationalName.text =
                            event.row.cells["nationality"]!.value.toString();
                        Get.dialog(const UpdatePassport());
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
