import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import '../../../../../core/functions/hijri_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/bladia_info_controller.dart';

class BladiaInfo extends StatelessWidget {
  const BladiaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BladiaInfoController>();

    late HijriPicker picker1 = HijriPicker(controller.datBegin);
    late HijriPicker picker2 = HijriPicker(controller.datEnd);
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    return BaseScreen(
      widget: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }

          log("message : ${controller.bladia.value.bladiaInfo?.nameAr}");
          return ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomTextField(
                              controller: controller.name,
                              label: 'اسم البلدية',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.boss,
                              label: 'اسم رئيس البلدية',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.bossAssistant,
                              label: 'اسم نائب رئيس البلدية',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                        ],
                      ).scrollDirection(Axis.horizontal),
                      Row(
                        children: [
                          CustomTextField(
                              controller: controller.edariaBoss,
                              label: 'مدير إدارة الشؤون المالية والإدارية ',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.partBoss,
                              label: 'اسم مدير قسم شؤون الوظفين',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.part2Boss,
                              label: 'اسم المدقق',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                        ],
                      ).scrollDirection(Axis.horizontal),
                      Row(
                        children: [
                          CustomTextField(
                              controller: controller.maliaBoss,
                              label: 'اسم مدير الشؤون المالية',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.emp,
                              label: 'اسم الموظف المختص',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.empHelp,
                              label: 'اسم الموظف المختص المساعد',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                        ],
                      ).scrollDirection(Axis.horizontal),
                      Row(
                        children: [
                          CustomTextField(
                              controller: controller.ma3esha,
                              label: 'نسبة بدل غلاء المعيشة',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.workStationBoss,
                              label: 'رئيس قسم الحركة والصيانة',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                          CustomTextField(
                              controller: controller.ipan,
                              label: 'IPAN البلدية',
                              customHeight: currentHeight / 20,
                              customWidth: currentWidth / 5),
                        ],
                      ).scrollDirection(Axis.horizontal),
                    ],
                  ),
                ],
              ).scrollDirection(Axis.horizontal).marginOnly(right: 16),
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CustomButton(
                              text: "ضبط التواريخ",
                              onPressed: () {
                                print(controller.workStationBoss.text);
                              },
                              height: 40,
                              width: 120),
                          CustomButton(
                              text: "العلاوات السنوية",
                              onPressed: () {},
                              height: 40,
                              width: 120),
                          CustomButton(
                              text: "تعديل ",
                              onPressed: () {},
                              height: 40,
                              width: 120),
                        ],
                      ).scrollDirection(Axis.vertical)),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              text: 'حفظ',
                              onPressed: () {
                                print(controller.datBegin.text);
                                print(controller.municipalitySymbol.value);
                              },
                              height: 40,
                              width: 120),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              CustomTextField(
                                label: 'تاريخ بداية الاضرارية',
                                onTap: () => picker1.pickHijriDate(context),
                                controller: controller.datBegin,
                                customHeight: 25,
                                customWidth: 200,
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      picker1.pickHijriDate(context),
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ).scrollDirection(Axis.horizontal),
                          Row(
                            children: [
                              CustomTextField(
                                label: 'تاريخ نهاية الاضرارية',
                                controller: controller.datEnd,
                                customHeight: 25,
                                customWidth: 200,
                                onTap: () => picker2.pickHijriDate(context),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      picker2.pickHijriDate(context),
                                  icon: const Icon(
                                    Icons.calendar_today,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ).scrollDirection(Axis.horizontal),
                        ],
                      )),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('شعار البلدية '),
                        Obx(() {
                          return Container(
                            width: currentHeight * 0.2,
                            height: currentHeight * 0.2,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(10),
                              image: controller
                                      .municipalitySymbol.value.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          controller.municipalitySymbol.value),
                                      fit: BoxFit.fill,
                                    )
                                  : null,
                            ),
                            child: controller.municipalitySymbol.value.isEmpty
                                ? const Icon(Icons.add_a_photo,
                                    size: 50, color: Colors.white)
                                : null,
                          );
                        }).onTap(controller.pickImage).paddingAll(15)
                      ],
                    ).scrollDirection(Axis.vertical),
                  ),
                ],
              ).scrollDirection(Axis.vertical).marginOnly(right: 100),
            ],
          );
        },
      ),
    );
  }
}
