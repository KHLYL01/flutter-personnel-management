import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_taeen_report_controller.dart';

class AddTaeen extends StatelessWidget {
  const AddTaeen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpTaeenController>();
    final controllerReport = Get.find<EmpTaeenReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDate = HijriPicker(controller.qrarDate);
    HijriPicker mobasharahDate = HijriPicker(controller.mKhetabDate);
    HijriPicker litterDate = HijriPicker(controller.khetabDate);
    HijriPicker dateOfBirth = HijriPicker(controller.birthDate);
    return Scaffold(
      body: BaseScreen(
        widget: Obx(
          () {
            if (controller.isLoading.value) {
              return const CustomProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextField(
                      enabled: false,
                      controller: controller.id,
                      label: 'مسلسل',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.qrarId,
                      label: 'رقم القرار',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => decisionDate.pickHijriDate(context),
                      controller: controller.qrarDate,
                      label: 'تاريخ القرار',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                      onTap: () => dateOfBirth.pickHijriDate(context),
                      controller: controller.birthDate,
                      label: 'تاريخ الميلاد',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.empId,
                      label: 'الموظف',
                      customHeight: 35,
                      customWidth: currentWidth * 0.1,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.empName,
                      label: '',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomButton(
                      text: "اختر",
                      onPressed: () {
                        Get.find<EmployeeFindController>().clearControllers();
                        Get.dialog(
                          EmployeesFind(
                            onRowDoubleTap: (event) {
                              Map<String, PlutoCell> cells = event.row.cells;
                              controller.empId.text =
                                  cells['id']!.value.toString();
                              controller.empName.text =
                                  cells['name']!.value.toString();
                              controller.salary.text =
                                  cells['salary']!.value.toString();
                              controller.draga.text =
                                  cells['draga']!.value.toString();
                              controller.mrtaba.text =
                                  cells['fia']!.value.toString();
                              controller.nqalBadal.text =
                                  cells['naqlBadal']!.value.toString();
                              controller.jobName.text =
                                  cells['empType']!.value.toString();
                              Get.back();
                            },
                          ),
                        );
                        Get.find<EmployeeFindController>().findEmployee();
                      },
                      height: 35,
                      width: 50,
                    ).paddingOnly(top: 20),
                    Obx(
                      () => CustomCheckbox(
                        label: "صورة",
                        value: controller.isPicture.value,
                        onChanged: (value) {
                          controller.onChangePicture();
                        },
                      ).paddingOnly(top: 20),
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      enabled: false,
                      controller: controller.mrtaba,
                      label: 'المرتبة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.empPart,
                      label: 'القسم',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.jobNumber,
                      label: 'الرقم',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.draga,
                      label: 'الدرجة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      enabled: false,
                      controller: controller.jobName,
                      label: 'الوظيفة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.salary,
                      label: 'الراتب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.nqalBadal,
                      label: 'النقل',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.khetabId,
                      label: 'رقم الخطاب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                      onTap: () => litterDate.pickHijriDate(context),
                      controller: controller.khetabDate,
                      label: 'تاريخ الخطاب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.khetabName,
                      label: 'جهة الخطاب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.socialNumber,
                      label: 'رقم التأمين الإجتماعي',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomDropdownButton(
                      label: 'يوم المباشرة',
                      // height: 35,
                      // width: currentWidth * 0.2,
                      item: controller.mDay,
                      list: controller.mobasharahDays,
                      onChanged: (value) {
                        controller.onChangeMobasharahDay(value);
                      },
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => mobasharahDate.pickHijriDate(context),
                      controller: controller.mKhetabDate,
                      label: 'تاريخ المباشرة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    Obx(
                      () => Container(
                        color: AppColors.greyLight,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('الحالة الإجتماعية'),
                            CustomRadioListTile<String>(
                              value: "متزوج",
                              groupValue: controller.state.value,
                              title: "متزوج",
                              onChanged: (value) {
                                controller.updateSocialStatues(value);
                              },
                            ),
                            CustomRadioListTile<String>(
                              value: "أعزب",
                              groupValue: controller.state.value,
                              title: "أعزب",
                              onChanged: (value) {
                                controller.updateSocialStatues(value);
                              },
                            ),
                          ],
                        ).paddingAll(10),
                      ).paddingAll(15),
                    ),
                    Obx(
                      () => Container(
                        color: AppColors.greyLight,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('الجنس'),
                            CustomRadioListTile<String>(
                              value: "ذكر",
                              groupValue: controller.gender.value,
                              title: "ذكر",
                              onChanged: (value) {
                                controller.updateGender(value);
                              },
                            ),
                            CustomRadioListTile<String>(
                              value: "أنثى",
                              groupValue: controller.gender.value,
                              title: "أنثى",
                              onChanged: (value) {
                                controller.updateGender(value);
                              },
                            ),
                          ],
                        ).paddingAll(10),
                      ).paddingAll(15),
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "حفظ",
                      onPressed: () {
                        if (checkSavePermission()) {
                          controller.save();
                        }
                      },
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: " تعيين جديد",
                      onPressed: () => controller.clearControllers(),
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "طباعة قرار تعيين على بند الأجور",
                      onPressed: () => controllerReport.createQrarTaeenReport(),
                      height: 35,
                      width: 200,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
              ],
            ).scrollDirection(Axis.vertical).paddingSymmetric(horizontal: 16);
          },
        ),
      ),
    );
  }
}
