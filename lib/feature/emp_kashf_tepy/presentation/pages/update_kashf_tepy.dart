import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_kashf_tepy_report_controller.dart';

class UpdateKashfTepy extends StatelessWidget {
  const UpdateKashfTepy({super.key});

  @override
  Widget build(BuildContext context) {
    double currentWidth = Get.width;
    double currentHeight = Get.height;
    final controller = Get.find<EmpKashfTepyController>();
    final controllerReport = Get.find<EmpKashfTepyReportController>();
    HijriPicker requestDate = HijriPicker(controller.requestDate);
    HijriPicker endDate = HijriPicker(controller.endDate);

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
                      Row(
                        children: [
                          CustomTextField(
                            controller: controller.empId,
                            label: 'الموظف',
                            customHeight: 35,
                            customWidth: currentWidth * 0.1,
                          ),
                          CustomTextField(
                            controller: controller.empName,
                            label: '',
                            customHeight: 35,
                            customWidth: currentWidth * 0.23,
                          ),
                          CustomButton(
                                  text: "اختر",
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
                                          Get.back();
                                        },
                                      ),
                                    );
                                    Get.find<EmployeeFindController>()
                                        .findEmployee();
                                  },
                                  height: 35,
                                  width: 75)
                              .paddingOnly(top: 35)
                        ],
                      ),
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => requestDate.pickHijriDate(context),
                        controller: controller.requestDate,
                        label: "تاريخ طلب الكشف",
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      Row(
                        children: [
                          CustomDropdownButton(
                              label: "نوع الوحدة",
                              list: controller.units,
                              item: controller.wehdaType,
                              onChanged: (value) {
                                controller.onChangedUnitType(
                                    controller.wehdaType.value);
                              }),
                          // Obx(
                          //   () => CustomCheckbox(
                          //     label: "صورة",
                          //     value: controller.isPicture.value,
                          //     onChanged: (value) {
                          //       controller.onChangedPicture();
                          //     },
                          //   ),
                          // ).paddingOnly(top: 20),
                        ],
                      ),
                      CustomTextField(
                        controller: controller.wehdaName,
                        label: ' اسم الوحدة',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomTextField(
                        controller: controller.notes,
                        label: 'ملاحظات',
                        customHeight: 35,
                        customWidth: currentWidth / 3,
                      ),
                      CustomDropdownButton(
                        label: "حالة الموظف",
                        list: controller.statesOfEmployee,
                        item: controller.employeeStatus,
                        onChanged: (value) {
                          controller.onChangedEmployeeState(value);
                        },
                      ),
                      if (controller.employeeStatus.value ==
                          'انقطع عن العمل من تاريخ')
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => endDate.pickHijriDate(context),
                          controller: controller.endDate,
                          label: "تاريخ الإنقطاع",
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
                    text: 'طلب كشف طبي',
                    onPressed: () =>
                        controllerReport.createOrderKashfTepyReport(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'تعديل',
                    onPressed: () => controller.save(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: 'حذف',
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
              const SizedBox(height: 16),
            ],
          ).paddingSymmetric(horizontal: 16);
        },
      ),
    );
  }
}
