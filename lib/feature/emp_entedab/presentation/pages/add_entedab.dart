import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_entedab_controller.dart';
import '../controllers/emp_entedab_det_controller.dart';
import '../controllers/emp_entedab_report_controller.dart';

class AddEntedab extends StatelessWidget {
  const AddEntedab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEntedabController>();
    final controllerDet = Get.find<EmpEntedabDetController>();
    final controllerReport = Get.find<EmpEntedabReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker hijriDecisionDate =
        HijriPicker(controller.datQrar, controller.datQrarGo);
    HijriPicker hijriEndIntedabDate =
        HijriPicker(controller.datEnd, controller.datEndGo);
    HijriPicker hijriLitterDate =
        HijriPicker(controller.datKhrtab, controller.datKhetabGo);
    HijriPicker hijriStartIntedabDate =
        HijriPicker(controller.datBegin, controller.datBeginGo);

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
                      controller: controller.period,
                      label: 'مدة الانتداب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.place,
                      label: 'جهة الانتداب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.task,
                      label: 'المهمة',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.khetabId,
                      label: 'رقم الخطاب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.distance,
                      label: 'مسافة السفر',
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
                Row(
                  children: [
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => hijriDecisionDate.pickHijriDate(context),
                      controller: controller.datQrar,
                      label: 'تاريخ القرار',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => hijriStartIntedabDate.pickHijriDate(context),
                      controller: controller.datBegin,
                      label: 'تاريخ بداية الانتداب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => hijriEndIntedabDate.pickHijriDate(context),
                      controller: controller.datEnd,
                      label: 'تاريخ نهاية الانتداب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => hijriLitterDate.pickHijriDate(context),
                      controller: controller.datKhrtab,
                      label: 'تاريخ الخطاب',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.datQrarGo,
                      label: '',
                      withLable: false,
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.datBeginGo,
                      label: '',
                      withLable: false,
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      controller: controller.datEndGo,
                      label: '',
                      withLable: false,
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      label: '',
                      withLable: false,
                      controller: controller.datKhetabGo,
                      customHeight: 25,
                      customWidth: 200,
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.taskRaValue,
                      label: 'قيمة التذكرة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomDropdownButton(
                        label: 'وسيلة السفر',
                        list: controller.vehicles,
                        item: controller.waselTsafar,
                        width: 180,
                        onChanged: (value) {
                          controller.onChangeVehicle(value);
                        }),
                    CustomDropdownButton(
                        label: 'النوع',
                        list: controller.types,
                        item: controller.type,
                        width: 100,
                        onChanged: (value) {
                          controller.onChangeType(value);
                        }),
                    CustomDropdownButton(
                      label: 'اليوم',
                      list: controller.days,
                      item: controller.day,
                      width: 100,
                      onChanged: (value) {
                        controller.onChangeDay(value);
                      },
                    ),
                    CustomDropdownButton(
                        label: 'الفئة',
                        list: controller.categories,
                        item: controller.fia,
                        width: 100,
                        onChanged: (value) {
                          controller.onChangeCategory(value);
                        }),
                    CustomTextField(
                      controller: controller.fiaMony,
                      label: 'مبلغ الفئة',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(
                            label: 'هل تم تأمين وسيلة السفر',
                            value: controller.travelVehicleTameen.value,
                            onChanged: (value) {
                              controller.onChangerTavelVehicleTameen();
                            },
                          ),
                          CustomCheckbox(
                            label:
                                'هل استعملت سيارة حكومية من الجهة المنتدب منها أو الجهة المنتدب إليها للتنقلات الداخلية',
                            value: controller.usingCar.value,
                            onChanged: (value) {
                              controller.onChangeUsingCar();
                            },
                          ),
                          CustomCheckbox(
                            label: 'هل تم تكليفك بالعمل خارج فترة الدوام',
                            value: controller.workOutDawam.value,
                            onChanged: (value) {
                              controller.onChangeWorkOutDawam();
                            },
                          ),
                          CustomCheckbox(
                            label: 'هل تم تأمين السكن أو الطعام أو أحدهما',
                            value: controller.housingOrFood.value,
                            onChanged: (value) {
                              controller.onChangeHousingOrFood();
                            },
                          ),
                          CustomCheckbox(
                            label:
                                'هل سبق أن صرف سلفة نقدية على حساب المصاريف السفرية و ما مقدارها',
                            value: controller.solfahNaqdeah.value,
                            onChanged: (value) {
                              controller.onChangeSolfahNaqdeah();
                            },
                          )
                        ],
                      ).scrollDirection(Axis.vertical),
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRadioListTile(
                            groupValue: controller.sarf.value,
                            value:
                                ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري',
                            title:
                                ' يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري',
                            onChanged: (value) {
                              controller.updateBadalNaqel(value);
                            },
                          ),
                          CustomRadioListTile(
                              groupValue: controller.sarf.value,
                              value:
                                  ' لا يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري',
                              onChanged: (value) {
                                controller.updateBadalNaqel(value);
                              },
                              title:
                                  ' لا يصرف له يوميا بدل نقل إضافي 1/ 30 من بدل نقله الشهري'),
                          CustomRadioListTile(
                              value:
                                  'يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه',
                              onChanged: (value) {
                                controller.updateMablaghTaweedy(value);
                              },
                              groupValue: controller.taskRa.value,
                              title:
                                  'يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه'),
                          CustomRadioListTile(
                            groupValue: controller.taskRa.value,
                            value:
                                ' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه',
                            title:
                                ' لا يصرف للمذكور مبلغًا تعويضًا عن تذاكر إركابه',
                            onChanged: (value) {
                              controller.updateMablaghTaweedy(value);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "حفظ",
                      onPressed: () => controller.save(),
                      height: 30,
                      width: 120,
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
                                        label: "مسلسل الانتداب",
                                        controller: controllerDet.entedabId,
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
                                                controllerDet.draga.text =
                                                    cells['draga']!
                                                        .value
                                                        .toString();
                                                controllerDet.fia.text =
                                                    cells['fia']!
                                                        .value
                                                        .toString();
                                                controllerDet.naqlBadal.text =
                                                    cells['naqlBadal']!
                                                        .value
                                                        .toString();
                                                controllerDet
                                                        .entedabBadal.text =
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
                                        label: "بدل النقل",
                                        controller: controllerDet.naqlBadal,
                                        customHeight: 25,
                                        customWidth: 200,
                                      ),
                                      CustomTextField(
                                        enabled: false,
                                        label: "بدل الإنتداب",
                                        controller: controllerDet.entedabBadal,
                                        customHeight: 25,
                                        customWidth: 200,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomTextField(
                                        label: "مدة الإنتداب السابق",
                                        controller: controllerDet.prev,
                                        customHeight: 25,
                                        customWidth: 200,
                                      ),
                                      CustomTextField(
                                        label: "الإنتداب الخارجي",
                                        controller:
                                            controllerDet.externalEntedab,
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
                      text: "طباعة أمر إركاب ",
                      onPressed: () => controllerReport.createAmrErkabReport(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: "طباعة أمر إنتداب",
                      onPressed: () =>
                          controllerReport.createEntedabEmployeeReport(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: "طباعة قرار إنتداب",
                      onPressed: () =>
                          controllerReport.createQrarEntedabReport(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: "استحقاق الراتب",
                      onPressed: () =>
                          controllerReport.createEsthqaqRatebReport(),
                      height: 30,
                      width: 100,
                    ),
                    CustomButton(
                      text: "إضافة جديدة",
                      onPressed: () => controller.clearControllers(),
                      height: 25,
                      width: 150,
                    ),
                    // CustomButton(
                    //   text: "عودة",
                    //   onPressed: () => Get.back(),
                    //   height: 25,
                    //   width: 150,
                    // ),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
                const SizedBox(height: 10),
                SizedBox(
                  height: currentHeight / 3.5,
                  width: currentWidth - 100,
                  child: Obx(
                    () {
                      if (controllerDet.isLoading.value) {
                        return const CustomProgressIndicator();
                      }
                      return PlutoGrid(
                        key: ValueKey(controllerDet.entedabDets.length),
                        configuration: getPlutoConfig(),
                        rows: controllerDet.entedabDets
                            .map(
                              (item) => PlutoRow(
                                cells: {
                                  "id": PlutoCell(value: item.maxId),
                                  "empName": PlutoCell(value: item.empName),
                                  "salary": PlutoCell(value: item.salary),
                                  "fia": PlutoCell(value: item.fia),
                                  "draga": PlutoCell(value: item.draga),
                                  "naqlBadal": PlutoCell(value: item.naqlBadal),
                                  "entedabBadal":
                                      PlutoCell(value: item.entedabBadal),
                                  "prev": PlutoCell(value: item.prev),
                                  "externalEntedab":
                                      PlutoCell(value: item.externalEntedab),
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
                            field: 'empName',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'المرتبة',
                            field: 'fia',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'الدرجة',
                            field: 'draga',
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
                            title: 'بدل الانتداب',
                            field: 'entedabBadal',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'مدة الانتداب السابقة',
                            field: 'prev',
                            type: PlutoColumnType.text(),
                          ),
                          PlutoColumn(
                            title: 'الانتداب الخارجي',
                            field: 'externalEntedab',
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
                ),
              ],
            ).scrollDirection(Axis.vertical).paddingAll(16);
          },
        ),
      ),
    );
  }
}
