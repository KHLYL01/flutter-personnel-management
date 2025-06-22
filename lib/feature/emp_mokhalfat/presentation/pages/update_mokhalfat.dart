import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_mokhalfat_det_controller.dart';
import '../controllers/emp_mokhalfat_report_controller.dart';

class UpdateMokhalfat extends StatelessWidget {
  const UpdateMokhalfat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpMokhalfatController>();
    final controllerDet = Get.find<EmpMokhalfatDetController>();
    final controllerReport = Get.find<EmpMokhalfatReportController>();

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
                enabled: false,
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
                  CustomButton(
                    text: "تعديل",
                    onPressed: () {
                      if (checkUpdatePermission()) {
                        controller.save();
                      }
                    },
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "حذف",
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
                    text: "طباعة بيان مخالفة",
                    onPressed: () =>
                        controllerReport.createBeanMokhalfatReport(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "إضافة موظف",
                    onPressed: () {
                      controllerDet.clearControllers();
                      Get.dialog(
                        Dialog(
                          child: SizedBox(
                            width: 900,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CustomTextField(
                                      enabled: false,
                                      label: "المسلسل",
                                      controller: controllerDet.maxId,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "مسلسل المخالفة",
                                      controller: controllerDet.mokhalfaId,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      label: "الجزاء",
                                      controller: controllerDet.gza,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomTextField(
                                      enabled: false,
                                      label: "الموظف",
                                      controller: controllerDet.empId,
                                      customHeight: 25,
                                      customWidth: 100,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "",
                                      controller: controllerDet.empName,
                                      customHeight: 25,
                                      customWidth: 200,
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
                                                  event.row.cells;
                                              controllerDet.empId.text =
                                                  cells['id']!.value.toString();
                                              controllerDet.empName.text =
                                                  cells['name']!
                                                      .value
                                                      .toString();
                                              controllerDet.salary.text =
                                                  cells['salary']!
                                                      .value
                                                      .toString();
                                              controllerDet.naqlBadal.text =
                                                  cells['naqlBadal']!
                                                      .value
                                                      .toString();
                                              controllerDet.fia.text =
                                                  cells['fia']!
                                                      .value
                                                      .toString();
                                              controllerDet.draga.text =
                                                  cells['draga']!
                                                      .value
                                                      .toString();
                                              Get.back();
                                            },
                                          ),
                                        );
                                        Get.find<EmployeeFindController>()
                                            .findEmployee();
                                      },
                                      height: 35,
                                      width: 50,
                                    ).paddingOnly(top: 20),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextField(
                                      enabled: false,
                                      label: "الدرجة",
                                      controller: controllerDet.draga,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "المرتبة",
                                      controller: controllerDet.fia,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "الراتب",
                                      controller: controllerDet.salary,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "بدل النقل",
                                      controller: controllerDet.naqlBadal,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      text: "إضافة",
                                      onPressed: () {
                                        controllerDet.beforeSaveDet();
                                      },
                                      height: 35,
                                      width: 100,
                                    ),
                                    CustomButton(
                                      text: "عودة",
                                      onPressed: () => Get.back(),
                                      height: 35,
                                      width: 100,
                                    ),
                                  ],
                                ).center()
                              ],
                            ).paddingAll(16),
                          ),
                        ),
                      );
                    },
                    height: 35,
                    width: 120,
                  ),
                  CustomButton(
                    text: "حذف موظف",
                    onPressed: () =>
                        controllerDet.confirmDelete(withGoBack: true),
                    height: 35,
                    width: 120,
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
                child: Obx(
                  () {
                    if (controllerDet.isLoading.value) {
                      return const CustomProgressIndicator();
                    }
                    return PlutoGrid(
                      configuration: getPlutoConfig(),
                      rows: controllerDet.mokhalfatDets
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id),
                                "empName": PlutoCell(value: item.empName),
                                "salary": PlutoCell(value: item.salary),
                                "draga": PlutoCell(value: item.draga),
                                "fia": PlutoCell(value: item.fia),
                                "naqlBadal": PlutoCell(value: item.naqlBadal),
                                "gza": PlutoCell(value: item.gza),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                            title: 'الرمز',
                            field: 'id',
                            type: PlutoColumnType.text(),
                            hide: true),
                        PlutoColumn(
                          title: 'الاسم',
                          field: 'empName',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب',
                          field: 'salary',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل النقل',
                          field: 'naqlBadal',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الدرجة',
                          field: 'draga',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'المرتبة',
                          field: 'fia',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الجزاء',
                          field: 'gza',
                          type: PlutoColumnType.text(),
                        ),
                      ],
                      mode: PlutoGridMode.selectWithOneTap,
                      onSelected: (event) {
                        controllerDet.selectedDetId =
                            event.row!.cells['id']!.value;
                      },
                    );
                  },
                ),
              ).paddingAll(15),
            ],
          ).scrollDirection(Axis.vertical).paddingSymmetric(horizontal: 16);
        },
      ),
    );
  }
}
