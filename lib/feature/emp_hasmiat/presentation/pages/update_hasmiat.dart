import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';

class UpdateHasmiat extends StatelessWidget {
  const UpdateHasmiat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHasmiatController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDatePicker = HijriPicker(controller.datQrar);
    HijriPicker startHasemDatePicker = HijriPicker(controller.datBegin);
    HijriPicker endHasemDatePicker = HijriPicker(controller.datEnd);

    return Dialog(
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.id,
                    label: 'مسلسل',
                    customHeight: 25,
                    customWidth: currentWidth * 0.3,
                  ),
                  CustomTextField(
                    controller: controller.qrarId,
                    label: 'رقم القرار',
                    customHeight: 25,
                    customWidth: currentWidth * 0.3,
                  ),
                  Obx(
                    () => SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          CustomRadioListTile<String>(
                            value: "حسم عن غياب",
                            groupValue: controller.hasmType.value,
                            title: "حسم عن غياب",
                            onChanged: (value) {
                              controller.updateRadioListTileValue(value);
                            },
                          ),
                          CustomRadioListTile<String>(
                            value: "حسم عن تأخير",
                            groupValue: controller.hasmType.value,
                            title: "حسم عن تأخير",
                            onChanged: (value) {
                              controller.updateRadioListTileValue(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.month1,
                    label: 'خلاصة الشهر',
                    customHeight: 25,
                    customWidth: currentWidth * 0.3,
                  ),
                  CustomTextField(
                    controller: controller.year2,
                    label: 'عام',
                    customHeight: 25,
                    customWidth: currentWidth * 0.3,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.month2,
                    label: 'شهر الحسم',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                  CustomTextField(
                    controller: controller.year2,
                    label: 'عام',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                  CustomTextField(
                    controller: controller.dependOn,
                    label: 'بناءً على خطاب',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                    onTap: () => decisionDatePicker.pickHijriDate(context),
                    controller: controller.datQrar,
                    label: 'تاريخ القرار',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                    onTap: () => startHasemDatePicker.pickHijriDate(context),
                    controller: controller.datBegin,
                    label: 'تاريخ بداية الحسم',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                    onTap: () => endHasemDatePicker.pickHijriDate(context),
                    controller: controller.datEnd,
                    label: 'تاريخ نهاية الحسم',
                    customHeight: 25,
                    customWidth: currentWidth * 0.25,
                  ),
                  Obx(
                    () => CustomCheckbox(
                      label: "صورة",
                      value: controller.isPicture.value,
                      onChanged: (value) {
                        controller.onChangedPicture();
                      },
                    ).paddingOnly(top: 20),
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  // CustomButton(
                  //   text: "طباعة قرار حسم",
                  //   onPressed: () {},
                  //   height: 35,
                  //   width: 120,
                  // ),
                  CustomButton(
                    text: "إضافة موظف",
                    onPressed: () {},
                    height: 35,
                    width: 120,
                  ),
                  CustomButton(
                    text: "حذف موظف",
                    onPressed: () {},
                    height: 35,
                    width: 120,
                  ),
                  CustomButton(
                    text: "حفظ",
                    onPressed: () => controller.save(),
                    height: 35,
                    width: 120,
                  ),

                  CustomButton(
                    text: "حذف",
                    onPressed: () => controller.confirmDelete(
                      int.parse(controller.id.text),
                      withGoBack: true,
                    ),
                    height: 35,
                    width: 120,
                  ),
                ],
              ).scrollDirection(Axis.horizontal).center(),
              SizedBox(
                height: currentHeight / 1.5,
                width: currentWidth - 140,
                child: PlutoGrid(
                  configuration:getPlutoConfig(),

                  rows: [],
                  columns: [
                    PlutoColumn(
                      title: 'الاسم',
                      field: 'name',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'الراتب',
                      field: 'salary',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'بدل النقل',
                      field: 'badal_naqel',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'الغياب - عدم المباشرة',
                      field: '  ',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'ساعات التجميع',
                      field: ' ',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'الدقائق',
                      field: '',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'الجزاء',
                      field: '      ',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'ملاحظات',
                      field: '    ',
                      type: PlutoColumnType.text(),
                    ),
                  ],
                  mode: PlutoGridMode.selectWithOneTap,
                  onSelected: (event) {},
                ),
              ).paddingAll(15),
            ],
          ).scrollDirection(Axis.vertical);
        },
      ),
    );
  }
}
