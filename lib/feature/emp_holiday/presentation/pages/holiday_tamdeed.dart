import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/int_extension.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_tamdeed_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../../core/widgets/pluto_config.dart';
import '../controllers/emp_holiday_type_controller.dart';
import 'holiday_type_find.dart';

class HolidayTamdeed extends StatelessWidget {
  const HolidayTamdeed({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHolidayTamdeedController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker tamdeedBegin = HijriPicker(controller.tamdeedBegin);
    HijriPicker tamdeedEnd = HijriPicker(controller.tamdeedEnd);
    HijriPicker tepyDate = HijriPicker(controller.tepyDate);

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
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.holidayType,
                      label: 'نوع الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.holidayTypeName,
                      label: '',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomButton(
                      text: 'اختر',
                      onPressed: () {
                        Get.dialog(
                          HolidayTypeFind(
                            onRowDoubleTap: (event) {
                              Map<String, PlutoCell> cells = event.row.cells;
                              controller.holidayType.text =
                                  cells['id']!.value.toString();
                              controller.holidayTypeName.text =
                                  cells['name']!.value.toString();
                              Get.back();
                            },
                          ),
                        );
                        Get.find<EmpHolidayTypeController>().findAll();
                      },
                      height: 35,
                      width: 75,
                    ).paddingOnly(top: 15),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.tamdeedPeriod,
                      label: 'مدة التمديد',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.tamdeedBegin,
                      onTap: () => tamdeedBegin.pickHijriDate(context),
                      label: 'تاريخ بداية التمديد',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.tamdeedEnd,
                      onTap: () => tamdeedEnd.pickHijriDate(context),
                      label: 'تاريخ نهاية التمديد',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.tepyNo,
                      label: 'رقم التقرير الطبي',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.tepyDate,
                      onTap: () => tepyDate.pickHijriDate(context),
                      label: 'تاريخه',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.hospital,
                      label: 'المستشفى',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "حفظ",
                      onPressed: () => controller.save(),
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "حذف",
                      onPressed: () => controller.delete(),
                      height: 35,
                      width: 150,
                    ),
                    CustomButton(
                      text: "تفريغ الخانات",
                      onPressed: () => controller.clearControllers(),
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "طباعة قرار تمديد",
                      onPressed: () {},
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "عودة",
                      onPressed: () => Get.back(),
                      height: 35,
                      width: 120,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
                const SizedBox(height: 10),
                SizedBox(
                  height: currentHeight / 3.5,
                  width: currentWidth - 100,
                  child: PlutoGrid(
                    configuration: getPlutoConfig(),
                    rows: controller.empHolidayTamdeeds
                        .map(
                          (item) => PlutoRow(
                            cells: {
                              "id": PlutoCell(value: item.id.getValue()),
                              "holidayType": PlutoCell(
                                value: item.holidayType.getValue(),
                              ),
                              // "holidayTypeName": PlutoCell(
                              //     value: controller.getHolidayType(
                              //         item.holidayType.getValue())),
                              "tamdeedPeriod": PlutoCell(
                                  value: item.tamdeedPeriod.getValue()),
                              "tamdeedBegin": PlutoCell(
                                  value: item.tamdeedBegin.getValue()),
                              "tamdeedEnd":
                                  PlutoCell(value: item.tamdeedEnd.getValue()),
                              "tepyNo":
                                  PlutoCell(value: item.tepyNo.getValue()),
                              "tepyDate":
                                  PlutoCell(value: item.tepyDate.getValue()),
                              "hospital":
                                  PlutoCell(value: item.hospital.getValue()),
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
                        title: 'نوع الإجازة',
                        field: 'holidayType',
                        type: PlutoColumnType.text(),
                      ),
                      // PlutoColumn(
                      //   title: 'نوع الإجازة',
                      //   field: 'holidayTypeName',
                      //   type: PlutoColumnType.text(),
                      // ),
                      PlutoColumn(
                        title: 'مدة التمديد',
                        field: 'tamdeedPeriod',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ بداية التمديد',
                        field: 'tamdeedBegin',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخ نهاية التمديد',
                        field: 'tamdeedEnd',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'رقم التقرير الطبي',
                        field: 'tepyNo',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'تاريخه',
                        field: 'tepyDate',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'المستشفى',
                        field: 'hospital',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {
                      controller.selectedId =
                          int.parse(event.row!.cells['id']!.value);
                      controller.fillControllers(event.row!.cells);
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
