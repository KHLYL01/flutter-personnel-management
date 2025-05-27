import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_controller.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_report_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';

class UpdateMobashra extends StatelessWidget {
  const UpdateMobashra({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMobashraController>();
    final controllerReport = Get.find<EmpMobashraReportController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDate = HijriPicker(controller.qrarDate);
    HijriPicker mobasharahDate = HijriPicker(controller.date);
    HijriPicker startLeaveDate = HijriPicker(controller.holidayStartDate);
    HijriPicker workMobasharahDate = HijriPicker(controller.mobashraDate);
    HijriPicker litterDate = HijriPicker(controller.khetabDate);
    HijriPicker mobasharahDateUntilEndMonth = HijriPicker(controller.endDate);

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
                enabled: false,
                controller: controller.id,
                label: 'مسلسل',
                customHeight: 35,
                customWidth: currentWidth * 0.27,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                    customWidth: currentWidth * 0.7,
                  ),
                  CustomButton(
                          text: 'اختر',
                          onPressed: () {
                            Get.find<EmployeeFindController>()
                                .clearControllers();
                            Get.dialog(
                              EmployeesFind(
                                onRowDoubleTap: (event) {
                                  Map<String, PlutoCell> cells =
                                      event.row!.cells;
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
                                  controller.naqlBadal.text =
                                      cells['naqlBadal']!.value.toString();
                                  Get.back();
                                },
                              ),
                            );
                            Get.find<EmployeeFindController>().findEmployee();
                          },
                          height: 35,
                          width: 75)
                      .paddingOnly(top: 15)
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
                    controller: controller.draga,
                    label: 'الدرجة',
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
                    controller: controller.naqlBadal,
                    label: 'بدل النقل',
                    customHeight: 35,
                    customWidth: currentWidth * 0.2,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.qrarId,
                    label: 'رقم القرار',
                    customHeight: 35,
                    customWidth: currentWidth * 0.27,
                  ),
                  CustomTextField(
                    controller: controller.no,
                    label: 'رقم المباشرة',
                    customHeight: 35,
                    customWidth: currentWidth * 0.27,
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
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    controller: controller.qrarDate,
                    onTap: () => decisionDate.pickHijriDate(context),
                    label: 'تاريخ القرار',
                    customHeight: 35,
                    customWidth: currentWidth * 0.2,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    controller: controller.date,
                    onTap: () => mobasharahDate.pickHijriDate(context),
                    label: 'تاريخ المباشرة',
                    customHeight: 35,
                    customWidth: currentWidth * 0.22,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => startLeaveDate.pickHijriDate(context),
                    controller: controller.holidayStartDate,
                    label: 'تاريخ بداية الإجازة',
                    customHeight: 35,
                    customWidth: currentWidth * 0.2,
                  ),
                  CustomTextField(
                    onTap: () => workMobasharahDate.pickHijriDate(context),
                    controller: controller.mobashraDate,
                    label: 'تاريخ مباشرة العمل',
                    customHeight: 35,
                    customWidth: currentWidth * 0.2,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.period,
                    label: 'مدة الإجازة',
                    customHeight: 35,
                    customWidth: currentWidth * 0.35,
                  ),
                  CustomTextField(
                    controller: controller.partBoss,
                    label: 'رئيس القسم',
                    customHeight: 35,
                    customWidth: currentWidth * 0.35,
                  ),
                  CustomDropdownButton(
                      label: 'اليوم',
                      list: controller.daysList,
                      item: controller.day,
                      onChanged: (value) {
                        controller.onChangeDay(controller.day.value);
                      }),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.endDate,
                    label: 'تاريخ المباشرة',
                    customHeight: 35,
                    customWidth: currentWidth * 0.2,
                  ),
                  const Text("إلى نهاية الشهر ")
                      .paddingOnly(right: 10, top: 10),
                  const SizedBox(
                    width: 100,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    controller: controller.khetabDate,
                    onTap: () => litterDate.pickHijriDate(context),
                    label: 'تاريخ الخطاب',
                    customHeight: 35,
                    customWidth: currentWidth * 0.22,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    controller: controller.notes,
                    label: 'متجاوز / غير متجاوز',
                    customHeight: 35,
                    customWidth: currentWidth * 0.27,
                  ),
                  CustomTextField(
                    controller: controller.forr,
                    label: 'لقاء',
                    customHeight: 35,
                    customWidth: currentWidth * 0.27,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomButton(
                    text: "تعديل",
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
                  CustomButton(
                    text: "طباعة قرار مباشرة",
                    onPressed: () =>
                        controllerReport.createQrarMobashraReport(),
                    height: 35,
                    width: 120,
                  ),
                  CustomButton(
                    text: "طباعة مسير راتب إفرادي",
                    onPressed: () =>
                        controllerReport.createMoserRatebEfradyReport(),
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
            ],
          ).scrollDirection(Axis.vertical).paddingAll(15);
        },
      ),
    );
  }
}
