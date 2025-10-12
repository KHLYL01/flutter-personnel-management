import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../../../users/presentation/controllers/user_controller.dart';
import '../controllers/emp_services_controller.dart';

class EmpServicesPage extends StatelessWidget {
  const EmpServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpServicesController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker datB = HijriPicker(controller.datB);
    HijriPicker datE = HijriPicker(controller.datE);
    HijriPicker datAmr = HijriPicker(controller.datAmr);

    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomTextField(
                  enabled: false,
                  controller: controller.empId,
                  label: 'رقم الموظف',
                  customHeight: 25,
                  customWidth: 200,
                ).paddingOnly(right: 20, top: 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "إضافة خدمة",
                  onPressed: () {
                    if (!Get.find<UserController>()
                        .checkPermission("بيان خدمات موظف", save: true)) {
                      alertDialog(
                        title: 'تنبيه',
                        middleText: "       ليس لديك صلاحية الإضافة       ",
                        withoutButton: true,
                        onPressedConfirm: () {
                          Get.back();
                        },
                      );
                      return;
                    }
                    controller.clearControllers();
                    Get.dialog(Dialog(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: 880,
                        height: 400,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: controller.job,
                                  label: 'الوظيفة',
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                                CustomTextField(
                                  controller: controller.martaba,
                                  label: 'المرتبة',
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                                CustomTextField(
                                  controller: controller.mNum,
                                  label: 'رقمها',
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                                CustomTextField(
                                  controller: controller.salary,
                                  label: 'الراتب',
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: controller.place,
                                  label: 'الجهة',
                                  customHeight: 25,
                                  customWidth: 400,
                                ),
                                CustomTextField(
                                  suffixIcon: const Icon(
                                    Icons.date_range_sharp,
                                    size: 15,
                                  ),
                                  onTap: () => datB.pickHijriDate(context),
                                  controller: controller.datB,
                                  label: "تاريخ البداية",
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                                CustomTextField(
                                  suffixIcon: const Icon(
                                    Icons.date_range_sharp,
                                    size: 15,
                                  ),
                                  onTap: () => datE.pickHijriDate(context),
                                  controller: controller.datE,
                                  label: "تاريخ النهاية",
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                              ],
                            ),
                            CustomTextField(
                              controller: controller.reasons,
                              label: 'الاسباب',
                              customHeight: 25,
                              customWidth: 800,
                            ).center(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextField(
                                  controller: controller.amrNo,
                                  label: 'رقم الأمر',
                                  customHeight: 25,
                                  customWidth: 400,
                                ),
                                CustomTextField(
                                  suffixIcon: const Icon(
                                    Icons.date_range_sharp,
                                    size: 15,
                                  ),
                                  onTap: () => datAmr.pickHijriDate(context),
                                  controller: controller.datAmr,
                                  label: "تاريخ الأمر",
                                  customHeight: 25,
                                  customWidth: 200,
                                ),
                              ],
                            ),
                            CustomTextField(
                              controller: controller.nots,
                              label: 'ملاحظات',
                              customHeight: 25,
                              customWidth: 800,
                            ).center(),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  text: "حفظ",
                                  onPressed: () => controller.save(),
                                  height: 25,
                                  width: 100,
                                ),
                                CustomButton(
                                  text: "عودة",
                                  onPressed: () => Get.back(),
                                  height: 25,
                                  width: 100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
                  },
                  height: 25,
                  width: 100,
                ),
                CustomButton(
                  text: "طباعة",
                  onPressed: () => controller.report(),
                  height: 25,
                  width: 100,
                ),
                CustomButton(
                  text: "عودة",
                  onPressed: () => Get.back(),
                  height: 25,
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 20), // Add spacing
            Obx(
              () => Text("عدد السجلات المسترجعة: ${controller.length}"),
            ).center(),
            SizedBox(
              height: currentHeight - 100, // Define fixed height
              width: currentWidth - 40, // Define fixed width
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const CustomProgressIndicator();
                  }
                  return PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.list
                        .map((item) => PlutoRow(
                              cells: {
                                "id": PlutoCell(value: item.id.getValue()),
                                "job": PlutoCell(value: item.job.getValue()),
                                "martaba":
                                    PlutoCell(value: item.martaba.getValue()),
                                "mnum": PlutoCell(value: item.mnum.getValue()),
                                "salary":
                                    PlutoCell(value: item.salary.getValue()),
                                "place":
                                    PlutoCell(value: item.place.getValue()),
                                "datB": PlutoCell(value: item.datB.getValue()),
                                "datE": PlutoCell(value: item.datE.getValue()),
                                "reasons":
                                    PlutoCell(value: item.reasons.getValue()),
                                "amrNo":
                                    PlutoCell(value: item.amrNo.getValue()),
                                "datAmr":
                                    PlutoCell(value: item.datAmr.getValue()),
                                "nots": PlutoCell(value: item.nots.getValue()),
                              },
                            ))
                        .toList(),
                    columns: [
                      PlutoColumn(
                        // enableRowChecked: true,
                        title: 'المسلسل',
                        field: 'id',
                        type: PlutoColumnType.number(),
                        renderer: (rendererContext) => Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (!Get.find<UserController>().checkPermission(
                                    "بيان خدمات موظف",
                                    delete: true)) {
                                  alertDialog(
                                    title: 'تنبيه',
                                    middleText:
                                        "       ليس لديك صلاحية الحذف       ",
                                    withoutButton: true,
                                    onPressedConfirm: () {
                                      Get.back();
                                    },
                                  );
                                  return;
                                }
                                if (checkDeletePermission()) {
                                  controller.confirmDelete(
                                      rendererContext.cell.value);
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            Text(rendererContext.cell.value.toString()),
                          ],
                        ),
                      ),
                      PlutoColumn(
                        title: 'الوظيفة',
                        field: 'job',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'المرتبة',
                        field: 'martaba',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'رقمها',
                        field: 'mnum',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الراتب',
                        field: 'salary',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الجهة',
                        field: 'place',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ البداية',
                        field: 'datB',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ النهاية',
                        field: 'datE',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الأسباب',
                        field: 'reasons',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'رقم الأمر',
                        field: 'amrNo',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ الأمر',
                        field: 'datAmr',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الملاحظات',
                        field: 'nots',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
