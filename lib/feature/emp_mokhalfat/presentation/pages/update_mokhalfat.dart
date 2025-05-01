import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';

class UpdateMokhalfat extends StatelessWidget {
  const UpdateMokhalfat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMokhalfatController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    HijriPicker startDate = HijriPicker(controller.startDate);
    HijriPicker endDate = HijriPicker(controller.endDate);
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.id,
                label: 'مسلسل',
                customHeight: 35,
                customWidth: currentWidth * 0.5,
              ),
              CustomDropdownButton(
                label: "نوع المخالفة",
                list: controller.mokhalfaTypes,
                item: controller.mokhalfaType,
                onChanged: (value) {
                  controller
                      .onChangedDissentType(controller.mokhalfaType.value);
                },
              ),
              CustomTextField(
                controller: controller.description,
                label: 'بيان المخالفة',
                customHeight: 100,
                customWidth: currentWidth * 0.5,
              ),
              Row(
                children: [
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp),
                    onTap: () => startDate.pickHijriDate(context),
                    controller: controller.startDate,
                    label: 'عن الفترة من ',
                    customHeight: 35,
                    customWidth: currentWidth * 0.25,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp),
                    onTap: () => endDate.pickHijriDate(context),
                    controller: controller.endDate,
                    label: 'إلى',
                    customHeight: 35,
                    customWidth: currentWidth * 0.25,
                  ),
                  Obx(
                    () => CustomCheckbox(
                      label: "صورة",
                      value: controller.isPicture.value,
                      onChanged: (value) {
                        controller.onChangedPicture();
                      },
                    ).paddingAll(20),
                  )
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  // CustomButton(
                  //   text: "طباعة بيان مخالفة",
                  //   onPressed: () {},
                  //   height: 35,
                  //   width: 150,
                  // ),
                  CustomButton(
                    text: "إضافة موظف",
                    onPressed: () {},
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "تعديل",
                    onPressed: () => controller.save(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "حذف",
                    onPressed: () => controller.confirmDelete(
                      int.parse(controller.id.text),
                      withGoBack: true,
                    ),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "عودة",
                    onPressed: () => Get.back(),
                    height: 35,
                    width: 150,
                  ),
                ],
              ).scrollDirection(Axis.horizontal).center(),
              SizedBox(
                height: currentHeight / 1.5,
                width: currentWidth - 140,
                child: PlutoGrid(
                  configuration: getPlutoConfig(),
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
                      title: 'الدرجة',
                      field: 'degree',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'المرتبة',
                      field: 'rank',
                      type: PlutoColumnType.text(),
                    ),
                    PlutoColumn(
                      title: 'الجزاء',
                      field: '',
                      type: PlutoColumnType.text(),
                    ),
                  ],
                  mode: PlutoGridMode.selectWithOneTap,
                  onSelected: (event) {},
                ),
              ).paddingAll(15),
            ],
          ).scrollDirection(Axis.vertical).paddingSymmetric(horizontal: 16);
        },
      ),
    );
  }
}
