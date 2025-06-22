import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_hasmiat_det_controller.dart';
import '../controllers/emp_hasmiat_report_controller.dart';

class AddHasmiat extends StatelessWidget {
  const AddHasmiat({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHasmiatController>();
    final controllerDet = Get.find<EmpHasmiatDetController>();
    final controllerReport = Get.find<EmpHasmiatReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDatePicker = HijriPicker(controller.datQrar);
    HijriPicker startHasemDatePicker = HijriPicker(controller.datBegin);
    HijriPicker endHasemDatePicker = HijriPicker(controller.datEnd);

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
                  children: [
                    CustomTextField(
                      enabled: false,
                      controller: controller.id,
                      label: 'مسلسل',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.qrarId,
                      label: 'رقم القرار',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                      onTap: () => decisionDatePicker.pickHijriDate(context),
                      controller: controller.datQrar,
                      label: 'تاريخ القرار',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.dependOn,
                      label: 'بناءً على خطاب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    Obx(
                      () => SizedBox(
                        width: 200,
                        child: Column(
                          children: [
                            CustomRadioListTile<String>(
                              value: "حسم عن غياب",
                              groupValue: controller.hasmType.value,
                              title: "حسم عن غياب",
                              onChanged: (value) {
                                controller.updateRadioListTileValue(value);
                              },
                            ),
                            CustomRadioListTile<String>(
                              value: "حسم عن تأخير",
                              groupValue: controller.hasmType.value,
                              title: "حسم عن تأخير",
                              onChanged: (value) {
                                controller.updateRadioListTileValue(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.month1,
                      label: 'خلاصة الشهر',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.year1,
                      label: 'عام',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.month2,
                      label: 'شهر الحسم',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.year2,
                      label: 'عام',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                      onTap: () => startHasemDatePicker.pickHijriDate(context),
                      controller: controller.datBegin,
                      label: 'تاريخ بداية الحسم',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(Icons.date_range_sharp, size: 15),
                      onTap: () => endHasemDatePicker.pickHijriDate(context),
                      controller: controller.datEnd,
                      label: 'تاريخ نهاية الحسم',
                      customHeight: 25,
                      customWidth: 200,
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
                const SizedBox(height: 16),
                Row(
                  children: [
                    CustomButton(
                      text: "طباعة قرار حسم",
                      onPressed: () =>
                          controllerReport.createQrarHasmiatReport(),
                      height: 35,
                      width: 120,
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
                                        label: "مسلسل الحسم",
                                        controller: controllerDet.hasmId,
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
                                                    cells['id']!
                                                        .value
                                                        .toString();
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
                                        label: "الغياب - عدم المباشرة",
                                        controller: controllerDet.ghyab,
                                        customHeight: 25,
                                        customWidth: 200,
                                      ),
                                      CustomTextField(
                                        label: "ساعات التجميع",
                                        controller: controllerDet.tagmee3,
                                        customHeight: 25,
                                        customWidth: 200,
                                      ),
                                      CustomTextField(
                                        label: "الدقائق",
                                        controller: controllerDet.min,
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
                                  CustomTextField(
                                    label: "الملاحظات",
                                    controller: controllerDet.notes,
                                    customHeight: 25,
                                    customWidth: 820,
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
                  ],
                ).scrollDirection(Axis.horizontal).center(),
                SizedBox(
                  height: currentHeight / 2.5,
                  width: currentWidth - 100,
                  child: Obx(
                    () {
                      if (controllerDet.isLoading.value) {
                        return const CustomProgressIndicator();
                      }
                      return PlutoGrid(
                        key: ValueKey(controllerDet.hasmialDets.length),
                        configuration: getPlutoConfig(),
                        rows: controllerDet.hasmialDets
                            .map(
                              (item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.id),
                                  "employeeName":
                                      PlutoCell(value: item.employeeName),
                                  "salary": PlutoCell(value: item.salary),
                                  "naqlBadal": PlutoCell(value: item.naqlBadal),
                                  "ghyab": PlutoCell(value: item.ghyab),
                                  "tagmee3": PlutoCell(value: item.tagmee3),
                                  "min": PlutoCell(value: item.min),
                                  "gza": PlutoCell(value: item.gza),
                                  "notes": PlutoCell(value: item.notes),
                                },
                              ),
                            )
                            .toList(),
                        columns: [
                          PlutoColumn(
                            title: 'الرمز',
                            field: 'id',
                            type: PlutoColumnType.text(),
                            hide: true,
                          ),
                          PlutoColumn(
                            title: 'الاسم',
                            field: 'employeeName',
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
                            title: 'الغياب - عدم المباشرة',
                            field: 'ghyab',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'ساعات التجميع',
                            field: 'tagmee3',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'الدقائق',
                            field: 'min',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'الجزاء',
                            field: 'gza',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'ملاحظات',
                            field: 'notes',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      text: "إضافة جديدة",
                      onPressed: () => controller.clearControllers(),
                      height: 35,
                      width: 120,
                    ),
                  ],
                ),
              ],
            ).scrollDirection(Axis.vertical);
          },
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
