import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/users/presentation/controllers/user_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/actions_controller.dart';

class ActionsPage extends StatelessWidget {
  const ActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ActionsController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker fromDate = HijriPicker(controller.fromDate);
    HijriPicker toDate = HijriPicker(controller.toDate);

    return Scaffold(
      body: BaseScreen(
        widget: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomDropdownButton(
                      label: 'المستخدم',
                      list: controller.usernames,
                      item: controller.username,
                      onChanged: controller.onChangeUsername,
                      width: currentWidth / 6,
                    ),
                    const SizedBox(width: 32),
                    CustomTextField(
                      enabled: controller.all.isFalse,
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => fromDate.pickHijriDate(context),
                      controller: controller.fromDate,
                      label: 'الفترة من',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    Text(
                      "هـ",
                      style: TextStyle(
                        color:
                            controller.all.isFalse ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomTextField(
                      enabled: controller.all.isFalse,
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => toDate.pickHijriDate(context),
                      controller: controller.toDate,
                      label: 'إلى',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    Text(
                      "هـ",
                      style: TextStyle(
                        color:
                            controller.all.isFalse ? Colors.black : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        const Text("الكل"),
                        const SizedBox(width: 4),
                        Checkbox(
                          value: controller.all.value,
                          onChanged: (value) {
                            controller.all(value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(width: 32),
                    CustomDropdownButton(
                      label: 'نوع المعاملة',
                      list: controller.types,
                      item: controller.type,
                      onChanged: controller.onChangeType,
                      width: currentWidth / 6,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: controller.action,
                    label: 'الفعل',
                    customHeight: 25,
                    customWidth: 600,
                  ),
                  const SizedBox(width: 20),
                  CustomTextField(
                    controller: controller.id,
                    label: 'رقم المعالمة',
                    customHeight: 25,
                    customWidth: 150,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "بحث",
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
                      rows: controller.actions
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "username":
                                    PlutoCell(value: item.username.getValue()),
                                "action":
                                    PlutoCell(value: item.action.getValue()),
                                "dat": PlutoCell(value: item.dat.getValue()),
                                "tim": PlutoCell(value: item.tim.getValue()),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                          title: 'م',
                          field: 'id',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المستخدم',
                          field: 'username',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الفعل',
                          field: 'action',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'التاريخ',
                          field: 'dat',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الوقت',
                          field: 'tim',
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
