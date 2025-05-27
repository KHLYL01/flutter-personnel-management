import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_find_controller.dart';
import 'package:personnel_management/feature/employee/presentation/pages/employee_find.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../controllers/emp_end_report_controller.dart';

class UpdateEnd extends StatelessWidget {
  const UpdateEnd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEndController>();
    final controllerReport = Get.find<EmpEndReportController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDate = HijriPicker(controller.decisionDate);
    HijriPicker birthDate = HijriPicker(controller.birthDate);
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
              Row(
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.id,
                    label: 'مسلسل',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    controller: controller.decisionNumber,
                    label: 'رقم القرار',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    suffixIcon: const Icon(
                      Icons.date_range_sharp,
                      size: 15,
                    ),
                    onTap: () => decisionDate.pickHijriDate(context),
                    controller: controller.decisionDate,
                    label: 'تاريخ القرار',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
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
                    customWidth: 250,
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
                            controller.cardId.text =
                                cells['cardId']!.value.toString();
                            controller.empType.text =
                                cells['empType']!.value.toString();
                            controller.draga.text =
                                cells['draga']!.value.toString();
                            controller.fia.text =
                                cells['fia']!.value.toString();
                            controller.empType.text =
                                cells['empType']!.value.toString();
                            Get.back();
                          },
                        ),
                      );
                      Get.find<EmployeeFindController>().findEmployee();
                    },
                    height: 35,
                    width: 70,
                  ).paddingOnly(top: 20),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.job,
                    label: 'الوظيفة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.empType,
                    label: ' نوع الوظيفة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.cardId,
                    label: 'رقم بطاقة الأحوال',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    enabled: false,
                    controller: controller.fia,
                    label: 'المرتبة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.jobNumber,
                    label: 'الرقم',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.draga,
                    label: 'الدرجة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    enabled: false,
                    controller: controller.salary,
                    label: 'الراتب',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                children: [
                  CustomTextField(
                    suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                    onTap: () => endDate.pickHijriDate(context),
                    controller: controller.endDate,
                    label: 'تاريخ إنهاء الخدمة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                  CustomTextField(
                    controller: controller.days,
                    label: 'عدد أيام الإجازة',
                    customHeight: 35,
                    customWidth: 250,
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRadioListTile<String>(
                            value: "تقاعد نظامي",
                            groupValue:
                                controller.selectedRadioListTileValue.value,
                            title: "تقاعد نظامي",
                            onChanged: (value) {
                              controller.updateRadioListTileValue(value);
                            },
                          ),
                          CustomRadioListTile<String>(
                            value: "تقاعد مبكر",
                            groupValue:
                                controller.selectedRadioListTileValue.value,
                            title: "تقاعد مبكر",
                            onChanged: (value) {
                              controller.updateRadioListTileValue(value);
                            },
                          ),
                          CustomRadioListTile<String>(
                            value: "تقاعد الوفاة",
                            groupValue:
                                controller.selectedRadioListTileValue.value,
                            title: "تقاعد الوفاة",
                            onChanged: (value) {
                              controller.updateRadioListTileValue(value);
                            },
                          ),
                        ],
                      ),
                    ).paddingAll(15),
                  ),
                  Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 100),
                        CustomCheckbox(
                          label: 'راتب أربع شهور مكافأة إنهاء خدمة',
                          value: controller.salaryFor4Months.value,
                          onChanged: (value) {
                            controller.onChangeSalaryFor4Months();
                          },
                        ),
                        CustomCheckbox(
                          label: 'راتب ستة شهور مكافأة إنهاء خدمة',
                          value: controller.salaryFor6Months.value,
                          onChanged: (value) {
                            controller.onChangeSalaryFor6Months();
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              Obx(
                () => AnimatedOpacity(
                  opacity: controller.selectedRadioListTileValue.value ==
                          "تقاعد مبكر"
                      ? 1
                      : .3,
                  duration: const Duration(milliseconds: 500),
                  child: Row(
                    children: [
                      CustomTextField(
                        enabled: controller.selectedRadioListTileValue.value ==
                            "تقاعد مبكر",
                        suffixIcon:
                            const Icon(Icons.date_range_sharp, size: 15),
                        onTap: () => birthDate.pickHijriDate(context),
                        controller: controller.birthDate,
                        label: 'تاريخ الميلاد',
                        customHeight: 35,
                        customWidth: 250,
                      ),
                      CustomTextField(
                        enabled: controller.selectedRadioListTileValue.value ==
                            "تقاعد مبكر",
                        controller: controller.age,
                        label: 'العمر',
                        customHeight: 35,
                        customWidth: 250,
                      ),
                    ],
                  ).scrollDirection(Axis.horizontal),
                ),
              ),
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
                  // CustomButton(
                  //   text: "إنهاء خدمة جديد",
                  //   onPressed: () {
                  //     controller.clearControllers();
                  //   },
                  //   height: 35,
                  //   width: 120,
                  // ),
                  CustomButton(
                    text: "طباعة قرار إنهاء خدمة",
                    onPressed: () => controllerReport.createQrarEndReport(),
                    height: 35,
                    width: 120,
                  ),
                  CustomButton(
                    text: "طباعة مسير",
                    onPressed: () => controllerReport.createMoserEndReport(),
                    height: 35,
                    width: 120,
                  ),
                  // Obx(
                  //   () => CustomCheckbox(
                  //     label: "صورة",
                  //     value: controller.isPicture.value,
                  //     onChanged: (value) {
                  //       controller.onChangePicture();
                  //     },
                  //   ).paddingOnly(top: 20),
                  // ),
                  CustomButton(
                    text: "طباعة مكافأة إنهاء خدمة",
                    onPressed: () => controllerReport.createMokafaaEndReport(),
                    height: 35,
                    width: 200,
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
          ).scrollDirection(Axis.vertical).paddingSymmetric(horizontal: 20);
        },
      ),
    );
  }
}
