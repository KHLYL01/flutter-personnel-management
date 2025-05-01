import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_dowra_controller.dart';

class UpdateDowra extends StatelessWidget {
  const UpdateDowra({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDowraController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    HijriPicker startCycleDate = HijriPicker(controller.startDate);
    HijriPicker endCycleDate = HijriPicker(controller.endDate);
    HijriPicker decisionDate = HijriPicker(controller.decisionDate);
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomTextField(
                          enabled: false,
                          controller: controller.id,
                          label: 'مسلسل',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          controller: controller.decisionNumber,
                          label: 'رقم القرار',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          controller: controller.courseDays,
                          label: 'عدد أيام الدورة',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          controller: controller.title,
                          label: 'عنوان بيان دورة',
                          customHeight: 60,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          controller: controller.footer,
                          label: 'بيان قرار دورة',
                          customHeight: 60,
                          customWidth: 300,
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        CustomTextField(
                          controller: controller.extraDays,
                          label: 'أيام تعويضية',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => startCycleDate.pickHijriDate(context),
                          controller: controller.startDate,
                          label: 'تاريخ بداية دورة',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => endCycleDate.pickHijriDate(context),
                          controller: controller.endDate,
                          label: 'تاريخ نهاية دورة',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => decisionDate.pickHijriDate(context),
                          controller: controller.decisionDate,
                          label: ' تاريخ القرار ',
                          customHeight: 35,
                          customWidth: 300,
                        ),
                      ],
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "إضافة موظف",
                      onPressed: () => null,
                      height: 35,
                      width: 150,
                    ),
                    // CustomButton(
                    //   text: "طباعة بيان مخالفة",
                    //   onPressed: () {},
                    //   height: 35,
                    //   width: 150,
                    // ),

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
                        title: 'مقدار المكافأة',
                        field: ' ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'بدل انتداب',
                        field: '  ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'بدل نقل',
                        field: '   ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'بدل تذاكر',
                        field: '',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {},
                  ),
                ).paddingAll(15),
              ],
            ).scrollDirection(Axis.vertical).paddingAll(15);
          },
        ));
  }
}
