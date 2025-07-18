import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/emp_eqrar_controller.dart';
import '../controllers/emp_eqrar_report_controller.dart';

class UpdateEqrar extends StatelessWidget {
  const UpdateEqrar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEqrarController>();
    final controllerReport = Get.find<EmpEqrarReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;
    HijriPicker iqrarDate = HijriPicker(controller.decisionDate);
    HijriPicker khitabDate = HijriPicker(controller.letterDate);
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return ListView(
            shrinkWrap: true,
            children: [
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
                        onTap: () => khitabDate.pickHijriDate(context),
                        controller: controller.letterDate,
                        label: "تاريخ الخطاب",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.decisionName,
                        label: 'اسم المقر ',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.decisionPlace,
                        label: ' الحضور',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => iqrarDate.pickHijriDate(context),
                        controller: controller.decisionDate,
                        label: "تاريخ الإقرار",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.letterNumber,
                        label: "رقم الخطاب",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.letterName,
                        label: "مرسل الخطاب",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      Obx(() => CustomCheckbox(
                            label: 'صورة',
                            value: controller.isPicture.value,
                            onChanged: (value) => controller.onChangedPicture(),
                          ).paddingAll(20))
                    ],
                  ),
                ],
              ).paddingAll(5).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomButton(
                    text: 'تعديل',
                    onPressed: () {
                      if (checkUpdatePermission()) {
                        controller.save();
                      }
                    },
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'حذف',
                    onPressed: () {
                      if (checkDeletePermission()) {
                        controller.confirmDelete(
                          int.parse(controller.id.text),
                          withGoBack: true,
                        );
                      }
                    },
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'التقرير',
                    onPressed: () => controllerReport.createEqrarReport(),
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
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
