import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_det_controller.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/pages/takleef_det.dart';
import '../../../../../../core/functions/hijri_picker.dart';

import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/emp_takleef_report_controller.dart';
import '../controllers/emp_takleef_controller.dart';

class UpdateTakleef extends StatelessWidget {
  const UpdateTakleef({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpTakleefController>();
    final controllerDet = Get.find<EmpTakleefDetController>();
    final controllerReport = Get.find<EmpTakleefReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    late HijriPicker qararDate =
        HijriPicker(controller.datQrar, controller.datQrarGo);
    late HijriPicker khitabDate =
        HijriPicker(controller.datKhetab, controller.datKhetabGo);
    late HijriPicker startDateKharij =
        HijriPicker(controller.datBegin, controller.datBeginGo);
    late HijriPicker endDateKharij =
        HijriPicker(controller.datEnd, controller.datEndGo);
    return Dialog(
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: controller.id,
                        label: "مسلسل",
                        customHeight: 25,
                        customWidth: 200,
                      ),
                      CustomTextField(
                        controller: controller.qrarId,
                        label: "رقم القرار",
                        customHeight: 25,
                        customWidth: 200,
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            onTap: () => qararDate.pickHijriDate(context),
                            controller: controller.datQrar,
                            label: "تاريخ القرار",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            controller: controller.datQrarGo,
                            label: "",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCheckbox(
                              label: 'صورة',
                              value: controller.isPicture.value,
                              onChanged: (value) {
                                controller.onChangedPicture();
                              },
                            ),
                            CustomCheckbox(
                              label: 'عيد الفطر',
                              value: controller.isEidFutur.value,
                              onChanged: (value) {
                                controller.onChangedEidFutur();
                              },
                            ),
                            CustomCheckbox(
                              label: 'عيد الأضحى',
                              value: controller.isEidAdhaa.value,
                              onChanged: (value) {
                                controller.onChangedEidAdhaa();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ).scrollDirection(Axis.horizontal),
                  Row(
                    children: [
                      CustomTextField(
                        controller: controller.place,
                        label: "اسم القسم ",
                        customHeight: 25,
                        customWidth: 400,
                      ),
                      CustomTextField(
                        controller: controller.task,
                        label: "اسم المهمة ",
                        customHeight: 25,
                        customWidth: 400,
                      ).scrollDirection(
                        Axis.horizontal,
                      ),
                    ],
                  ).scrollDirection(Axis.horizontal),
                  Row(
                    children: [
                      CustomTextField(
                        controller: controller.periodOthersDay,
                        label: "عدد الايام",
                        customHeight: 25,
                        customWidth: 200,
                      ),
                      CustomTextField(
                        controller: controller.hoursAvg,
                        label: "معدل عدد الساعات",
                        customHeight: 25,
                        customWidth: 200,
                      ),
                      CustomDropdownButton(
                        label: "اليوم",
                        list: controller.days,
                        item: controller.day,
                        onChanged: controller.onChangedDay,
                      ),
                    ],
                  ).scrollDirection(Axis.horizontal),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: controller.khetabId,
                        label: "رقم الخطاب",
                        customHeight: 25,
                        customWidth: currentWidth * 0.2,
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            onTap: () => khitabDate.pickHijriDate(context),
                            controller: controller.datKhetab,
                            label: "تاريخ الخطاب",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            controller: controller.datKhetabGo,
                            label: "",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            onTap: () => startDateKharij.pickHijriDate(context),
                            controller: controller.datBegin,
                            label: "تاريخ بداية خارج دوام",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            controller: controller.datBeginGo,
                            label: "",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            onTap: () => endDateKharij.pickHijriDate(context),
                            controller: controller.datEnd,
                            label: "تاريخ نهاية خارج دوام",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                          CustomTextField(
                            suffixIcon: const Icon(
                              Icons.date_range_sharp,
                              size: 15,
                            ),
                            controller: controller.datEndGo,
                            label: "",
                            customHeight: 25,
                            customWidth: 200,
                          ),
                        ],
                      )
                    ],
                  ).scrollDirection(Axis.horizontal),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: 'بيانات موظفي التكليف',
                          onPressed: () {
                            controllerDet.clearControllers();
                            controllerDet.getTakleefDetByTakleefId(
                                int.parse(controller.id.text));
                            controllerDet.datBegin.text =
                                controller.datBegin.text;
                            controllerDet.datEnd.text = controller.datEnd.text;
                            controllerDet.period.text =
                                controller.periodOthersDay.text;
                            Get.dialog(const TakleefDet());
                          },
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                          text: 'تعديل',
                          onPressed: () {
                            if (checkUpdatePermission()) {
                              controller.save();
                            }
                          },
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                          text: 'حذف',
                          onPressed: () {
                            if (checkDeletePermission()) {
                              controller.delete(int.parse(controller.id.text));
                            }
                          },
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                          text: 'طباعة قرار خارج الدوام',
                          onPressed: () =>
                              controllerReport.createQrarTakleefReport(),
                          height: 30,
                          width: 150,
                        ),
                        CustomButton(
                          text: 'مسير خارج الدوام',
                          onPressed: () =>
                              controllerReport.createMoserTakleefReport(),
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                          text: 'قرار صرف خارج ',
                          onPressed: () =>
                              controllerReport.createQrarSrfTakleefReport(),
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                          text: 'عودة',
                          onPressed: () => Get.back(),
                          height: 30,
                          width: 120,
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ).paddingAll(5),
            ],
          );
        },
      ),
    );
  }
}
