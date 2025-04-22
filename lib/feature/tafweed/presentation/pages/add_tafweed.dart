import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_dropdown_button.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/tafweed_controller.dart';

class AddTafweed extends StatelessWidget {
  const AddTafweed({super.key});

  @override
  Widget build(BuildContext context) {
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    final controller = Get.find<TafweedController>();
    controller.clearControllers();

    late HijriPicker startDate = HijriPicker(controller.startDate);
    late HijriPicker endDate = HijriPicker(controller.endDate);
    return Scaffold(
      body: BaseScreen(
        widget: Obx(
          () {
            if (controller.isLoading.value) {
              return const CustomProgressIndicator();
            }
            return ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: controller.id,
                          label: "مسلسل",
                          customHeight: 35,
                          customWidth: 200,
                        ),
                        CustomTextField(
                          controller: controller.subject,
                          label: "الموضوع",
                          customHeight: 35,
                          customWidth: 400,
                        ),
                        CustomDropdownButton(
                          label: 'اليوم',
                          list: controller.dayList,
                          item: controller.selectedDay,
                          onChanged: controller.onChangedDay,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomTextField(
                              enabled: false,
                              controller: controller.empId,
                              label: 'الموظف',
                              customHeight: 35,
                              customWidth: 70,
                            ),
                            CustomTextField(
                              enabled: false,
                              controller: controller.empName,
                              label: '',
                              customHeight: 35,
                              customWidth: 240,
                            ),
                            CustomButton(
                              text: "اختر",
                              onPressed: () {
                                Get.find<EmployeeFindController>()
                                    .clearControllers();
                                Get.dialog(
                                  EmployeesFind(
                                    onSelected: (event) {
                                      Map<String, PlutoCell> cells =
                                          event.row!.cells;
                                      controller.empId.text =
                                          cells['id']!.value.toString();
                                      controller.empName.text =
                                          cells['name']!.value.toString();
                                      Get.back();
                                    },
                                  ),
                                );
                                Get.find<EmployeeFindController>()
                                    .findEmployee();
                              },
                              height: 35,
                              width: 100,
                            )
                          ],
                        ),
                        CustomTextField(
                          onTap: () => startDate.pickHijriDate(context),
                          suffixIcon: const Icon(Icons.date_range_sharp),
                          controller: controller.startDate,
                          label: "تاريخ البداية",
                          customHeight: 35,
                          customWidth: 200,
                        ),
                        CustomTextField(
                          onTap: () => endDate.pickHijriDate(context),
                          suffixIcon: const Icon(Icons.date_range_sharp),
                          controller: controller.endDate,
                          label: "تاريخ النهاية",
                          customHeight: 35,
                          customWidth: 200,
                        ),
                      ],
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                CustomTextField(
                  controller: controller.note,
                  label: 'ملاحظات',
                  customHeight: 200,
                  customWidth: 400,
                ),
                Row(
                  children: [
                    CustomButton(
                      text: 'حفظ',
                      onPressed: () => controller.save(),
                      height: 35,
                      width: 150,
                    ),
                    CustomButton(
                        text: 'تفويض جديد',
                        onPressed: () => controller.clearControllers(),
                        height: 35,
                        width: 150),
                    CustomButton(
                        text: 'التقرير',
                        onPressed: () {},
                        height: 35,
                        width: 150),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
              ],
            ).paddingAll(15);
          },
        ),
      ),
    );
  }
}
