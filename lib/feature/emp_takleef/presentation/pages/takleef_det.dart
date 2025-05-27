import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_det_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';

class TakleefDet extends StatelessWidget {
  const TakleefDet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpTakleefDetController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    late HijriPicker datBegin = HijriPicker(controller.datBegin);
    late HijriPicker datEnd = HijriPicker(controller.datEnd);

    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      child: SizedBox(
        height: context.height - 200,
        width: context.width - 100,
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
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      enabled: false,
                      label: "الموظف",
                      controller: controller.empId,
                      customHeight: 25,
                      customWidth: 100,
                    ),
                    CustomTextField(
                      enabled: false,
                      label: "",
                      controller: controller.empName,
                      customHeight: 25,
                      customWidth: 200,
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
                              controller.naqlBadal.text =
                                  cells['naqlBadal']!.value.toString();
                              Get.back();
                            },
                          ),
                        );
                        Get.find<EmployeeFindController>().findEmployee();
                      },
                      height: 35,
                      width: 50,
                    ).paddingOnly(top: 20),
                    CustomTextField(
                      enabled: false,
                      label: "الراتب",
                      controller: controller.salary,
                      customHeight: 25,
                      customWidth: 100,
                    ),
                    CustomTextField(
                      enabled: false,
                      label: "بدل النقل",
                      controller: controller.salary,
                      customHeight: 25,
                      customWidth: 100,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.period,
                      label: 'عدد الايام',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => datBegin.pickHijriDate(context),
                      controller: controller.datBegin,
                      label: 'تاريخ بداية خارج دوام',
                      customHeight: 25,
                      customWidth: 200,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => datEnd.pickHijriDate(context),
                      controller: controller.datEnd,
                      label: "تاريخ نهاية خارج دوام",
                      customHeight: 25,
                      customWidth: 200,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                CustomTextField(
                  controller: controller.empWork,
                  label: 'العمل المكلف به',
                  customHeight: 25,
                  customWidth: 400,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'حفظ',
                      onPressed: () => controller.save(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: 'حذف',
                      onPressed: () => controller.delete(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: 'تفريغ الخانات',
                      onPressed: () => controller.clearControllers(),
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
                ).scrollDirection(Axis.horizontal).center(),
                const SizedBox(height: 20),
                SizedBox(
                  height: currentHeight / 3.5,
                  width: currentWidth - 100,
                  child: PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.takleefDets
                        .map(
                          (item) => PlutoRow(
                            cells: {
                              "id": PlutoCell(value: item.maxId),
                              "empName": PlutoCell(value: item.empName),
                              "salary": PlutoCell(value: item.salary),
                              "naqlBadal": PlutoCell(value: item.naqlBadal),
                              "period": PlutoCell(value: item.period),
                              "datBegin": PlutoCell(value: item.datBegin),
                              "datEnd": PlutoCell(value: item.datEnd),
                              "empWork": PlutoCell(value: item.empWork),
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
                        title: 'عدد الايام',
                        field: 'period',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ بداية خارج الدوام',
                        field: 'datBegin',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ نهاية خارج الدوام',
                        field: 'datEnd',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'العمل المكلف به',
                        field: 'empWork',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {
                      controller.selectedDetId = event.row!.cells['id']!.value;
                    },
                  ),
                ),
              ],
            ).scrollDirection(Axis.vertical).paddingAll(15);
          },
        ),
      ),
    );
  }
}
