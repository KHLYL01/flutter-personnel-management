import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/utils/helper_method.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_dowra_controller.dart';
import '../controllers/emp_dowra_det_controller.dart';
import '../controllers/emp_dowra_report_controller.dart';

class AddDowra extends StatelessWidget {
  const AddDowra({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpDowraController>();
    final controllerDet = Get.find<EmpDowraDetController>();
    final controllerReport = Get.find<EmpDowraReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;
    HijriPicker startCycleDate = HijriPicker(controller.startDate);
    HijriPicker endCycleDate = HijriPicker(controller.endDate);
    HijriPicker decisionDate = HijriPicker(controller.decisionDate);
    return Scaffold(
      body: BaseScreen(widget: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CustomTextField(
                        enabled: false,
                        controller: controller.id,
                        label: 'مسلسل',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        controller: controller.decisionNumber,
                        label: 'رقم القرار',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        controller: controller.courseDays,
                        label: 'عدد أيام الدورة',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        controller: controller.title,
                        label: 'عنوان بيان دورة',
                        customHeight: 60,
                        customWidth: 300,
                      ),
                    ],
                  ).scrollDirection(Axis.horizontal),
                  const SizedBox(width: 16),
                  Column(
                    children: [
                      CustomTextField(
                        controller: controller.extraDays,
                        label: 'أيام تعويضية',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => startCycleDate.pickHijriDate(context),
                        controller: controller.startDate,
                        label: 'تاريخ بداية دورة',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => endCycleDate.pickHijriDate(context),
                        controller: controller.endDate,
                        label: 'تاريخ نهاية دورة',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                      CustomTextField(
                        suffixIcon: const Icon(
                          Icons.date_range_sharp,
                          size: 15,
                        ),
                        onTap: () => decisionDate.pickHijriDate(context),
                        controller: controller.decisionDate,
                        label: ' تاريخ القرار ',
                        customHeight: 35,
                        customWidth: 300,
                      ),
                    ],
                  ),
                ],
              ).scrollDirection(Axis.horizontal),
              CustomTextField(
                controller: controller.footer,
                label: 'بيان قرار دورة',
                customHeight: 60,
                customWidth: 620,
              ),
              const SizedBox(height: 10),
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
                    width: 150,
                  ),
                  CustomButton(
                    text: "إضافة جديد ",
                    onPressed: () => controller.clearControllers(),
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
                            width: 1100,
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
                                      label: "مسلسل الدورة",
                                      controller: controllerDet.dowraId,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
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
                                              controllerDet.draga.text =
                                                  cells['draga']!
                                                      .value
                                                      .toString();
                                              controllerDet.fia.text =
                                                  cells['fia']!
                                                      .value
                                                      .toString();
                                              // controllerDet.naqlBadal.text =
                                              //     cells['naqlBadal']!
                                              //         .value
                                              //         .toString();
                                              controllerDet.badalEntidab.text =
                                                  cells['intentedabBadal']!
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      enabled: false,
                                      label: "المرتبة",
                                      controller: controllerDet.fia,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      enabled: false,
                                      label: "الدرجة",
                                      controller: controllerDet.draga,
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
                                      label: "بدل الإنتداب",
                                      controller: controllerDet.badalEntidab,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomTextField(
                                      label: "بدل النقل",
                                      controller: controllerDet.badalTransfare,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      label: "مقدار المكافأة",
                                      controller: controllerDet.mokafaa,
                                      customHeight: 25,
                                      customWidth: 200,
                                    ),
                                    CustomTextField(
                                      label: "بدل التذاكر",
                                      controller: controllerDet.ticketCost,
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
                    text: "طباعة قرار الدورة",
                    onPressed: () => controllerReport.createQrarDowraReport(),
                    height: 35,
                    width: 150,
                  ),
                  CustomButton(
                    text: "طباعة بيان الدورة",
                    onPressed: () => controllerReport.createBeanDowraReport(),
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
                      key: ValueKey(controllerDet.dowraDets.length),
                      configuration: getPlutoConfig(),
                      rows: controllerDet.dowraDets
                          .map(
                            (item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.maxId.getValue()),
                                "name":
                                    PlutoCell(value: item.empName.getValue()),
                                "salary":
                                    PlutoCell(value: item.salary.getValue()),
                                "draga":
                                    PlutoCell(value: item.draga.getValue()),
                                "fia": PlutoCell(value: item.fia.getValue()),
                                "mokafaa":
                                    PlutoCell(value: item.mokafaa.getValue()),
                                "badalEntidab": PlutoCell(
                                    value: item.badalEntidab.getValue()),
                                "badalTransfare": PlutoCell(
                                    value: item.badalTransfare.getValue()),
                                "ticketCost": PlutoCell(
                                    value: item.ticketCost.getValue()),
                              },
                            ),
                          )
                          .toList(),
                      columns: [
                        PlutoColumn(
                            title: 'الرمز',
                            field: 'id',
                            type: PlutoColumnType.number(),
                            hide: true),
                        PlutoColumn(
                          title: 'الاسم',
                          field: 'name',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'الراتب',
                          field: 'salary',
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
                          title: 'مقدار المكافأة',
                          field: 'mokafaa',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل انتداب',
                          field: 'badalEntidab',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل نقل',
                          field: 'badalTransfare',
                          type: PlutoColumnType.text(),
                        ),
                        PlutoColumn(
                          title: 'بدل تذاكر',
                          field: 'ticketCost',
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
          ).scrollDirection(Axis.vertical).paddingAll(15);
        },
      )),
    );
  }
}
