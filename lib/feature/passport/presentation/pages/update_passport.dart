import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_controller.dart';
import 'package:personnel_management/feature/tarmeez_nations/presentation/controllers/nations_controller.dart';
import 'package:personnel_management/feature/tarmeez_nations/presentation/pages/nations_find.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/passport_report_controller.dart';

class UpdatePassport extends StatelessWidget {
  const UpdatePassport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PassportController>();
    final controllerReport = Get.find<PassportReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker date = HijriPicker(controller.date);

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: BaseScreen(
        widget: Obx(
          () {
            if (controller.isLoading.value) {
              return const CustomProgressIndicator();
            }
            return ListView(shrinkWrap: true, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextField(
                        enabled: false,
                        controller: controller.id,
                        label: "مسلسل",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => date.pickHijriDate(context),
                        controller: controller.date,
                        label: "تاريخ الإقرار",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.name,
                        label: 'الاسم',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      Row(
                        children: [
                          CustomTextField(
                            controller: controller.nationalId,
                            label: 'الجنسية',
                            customHeight: 35,
                            customWidth: currentWidth * 0.1,
                          ),
                          CustomTextField(
                            controller: controller.nationalName,
                            label: '',
                            customHeight: 35,
                            customWidth: currentWidth * 0.23,
                          ),
                          CustomButton(
                                  text: "اختر",
                                  onPressed: () {
                                    Get.find<NationsController>()
                                        .clearControllersForSearch();
                                    Get.dialog(
                                      NationsFind(
                                        onRowDoubleTap: (event) {
                                          Map<String, PlutoCell> cells =
                                              event.row!.cells;
                                          controller.nationalId.text =
                                              cells['id']!.value.toString();
                                          controller.nationalName.text =
                                              cells['name']!.value.toString();
                                          Get.back();
                                        },
                                      ),
                                    );
                                    Get.find<NationsController>().findNations();
                                  },
                                  height: 35,
                                  width: 75)
                              .paddingOnly(top: 35)
                        ],
                      ),

                      // Row(
                      //   children: [
                      // Obx(
                      //   () => CustomCheckbox(
                      //     label: "صورة",
                      //     value: controller.isPicture.value,
                      //     onChanged: (value) {
                      //       controller.onChangedPicture();
                      //     },
                      //   ),
                      // ).paddingOnly(top: 20),
                      //   ],
                      // ),
                      CustomTextField(
                        controller: controller.documentNumber,
                        label: 'رقم الجواز',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.exportFrom,
                        label: 'صادر من',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.witness,
                        label: 'الشاهد',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                    ],
                  ),
                ],
              ).paddingAll(5).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomButton(
                    text: 'تعديل',
                    onPressed: () => controller.save(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'حذف',
                    onPressed: () =>
                        controller.delete(int.parse(controller.id.text)),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'التقرير',
                    onPressed: () => controllerReport.createReport(),
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
            ]).paddingSymmetric(horizontal: 16);
          },
        ),
      ),
    );
  }
}
