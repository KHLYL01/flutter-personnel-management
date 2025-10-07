import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_tamdeed_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/utils/helper_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../controllers/emp_holiday_report_controller.dart';
import '../controllers/emp_request_holiday_report_controller.dart';
import 'holiday_tamdeed.dart';
import 'holiday_type_find.dart';

class UpdateHoliday extends StatelessWidget {
  const UpdateHoliday({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpHolidayController>();
    final controllerReport = Get.find<EmpHolidayReportController>();
    final controllerRequestHolidayReport =
        Get.find<EmpRequestHolidayReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDate = HijriPicker(controller.qrarDate);
    HijriPicker igazahRequestDate = HijriPicker(controller.requestDate);
    HijriPicker igazahStartDate = HijriPicker(controller.startDate);
    HijriPicker igazahEndDate = HijriPicker(controller.endDate);
    HijriPicker istehqaqEndDate = HijriPicker(controller.eligibilityEndDate);
    HijriPicker istehqaqDate = HijriPicker(controller.istehqaqDate);
    HijriPicker istehqaqStartDate =
        HijriPicker(controller.eligibilityStartDate);
    HijriPicker dayDate = HijriPicker(controller.inputDate);
    HijriPicker medicalReportDate = HijriPicker(controller.tepyDate);
    HijriPicker serviceStartDate = HijriPicker(controller.separationDate);

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
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.qrarId,
                      label: 'رقم القرار',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.qrarDate,
                      onTap: () => decisionDate.pickHijriDate(context),
                      label: 'تاريخ القرار',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.empId,
                      label: 'الموظف',
                      customHeight: 25,
                      customWidth: currentWidth * 0.07,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.empName,
                      label: '',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
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
                                        event.row.cells;
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
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.draga,
                      label: 'الدرجة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.salary,
                      label: 'الراتب',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.naqlBadal,
                      label: 'بدل النقل',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      enabled: false,
                      controller: controller.holidayType,
                      label: 'نوع الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.07,
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
                        // Get.find<EmpHolidayTypeController>().findAll();
                      },
                      height: 35,
                      width: 75,
                    ).paddingOnly(top: 15)
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.requestDate,
                      onTap: () => igazahRequestDate.pickHijriDate(context),
                      label: 'تاريخ طلب الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      controller: controller.startDate,
                      onTap: () => igazahStartDate.pickHijriDate(context),
                      label: 'تاريخ بداية الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => igazahEndDate.pickHijriDate(context),
                      controller: controller.endDate,
                      label: 'تاريخ نهاية الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.address,
                      label: 'العنوان أثناء الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.boss,
                      label: 'الرئيس المباشر',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.bossJob,
                      label: 'وظيفته',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomDropdownButton(
                      // width: currentWidth * 0.2,
                      // height: 25,
                      label: 'صرف راتب الإجازة',
                      list: controller.sarfRatebIgazat,
                      item: controller.sarf,
                      onChanged: (value) {
                        controller
                            .onChangeSarfRatebIgazah(controller.sarf.value);
                      },
                    ),
                    CustomTextField(
                      controller: controller.period,
                      label: 'مدة الإجازة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => istehqaqStartDate.pickHijriDate(context),
                      controller: controller.eligibilityStartDate,
                      label: 'تاريخ بداية الاستحقاق',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => istehqaqStartDate.pickHijriDate(context),
                      controller: controller.eligibilityStartDate,
                      label: 'تاريخ نهاية الاستحقاق',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.badeel,
                      label: 'يؤمن عمله',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.fileNo,
                      label: 'رقم الملف',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.forr,
                      label: 'لقاء',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.forr,
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
                      onTap: () => medicalReportDate.pickHijriDate(context),
                      label: 'تاريخه',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.hospital,
                      label: 'اسم المستشفى',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    Obx(
                      () => Row(
                        children: [
                          CustomCheckbox(
                            label: "تم الاعتماد",
                            value: controller.etemad.value,
                            onChanged: (value) {
                              controller.onChangeEtemad();
                            },
                          ),
                          CustomCheckbox(
                            label: "إلغاء الإجازة",
                            value: controller.cancel.value,
                            onChanged: (value) {
                              controller.onChangeCancel();
                            },
                          ),
                        ],
                      ),
                    )
                        .paddingOnly(right: 10, top: 20)
                        .scrollDirection(Axis.horizontal),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(' رصيد الإجازات القديم :   '),
                            Text('رصيد كلي :   .............................'),
                            Text('متمتع : ...................'),
                            Text('باقي : ...................'),
                          ],
                        ).paddingAll(10).scrollDirection(Axis.horizontal),
                        const Row(
                          children: [
                            Text(' رصيد الإجازات القديم :   '),
                            Text('رصيد كلي :   .............................'),
                            Text('متمتع : ...................'),
                            Text('باقي : ...................'),
                          ],
                        ).paddingAll(10).scrollDirection(Axis.horizontal),
                        const Row(
                          children: [
                            Text(' رصيد الإجازات القديم :   '),
                            Text('رصيد كلي :   .............................'),
                            Text('متمتع : ...................'),
                            Text('باقي : ...................'),
                          ],
                        ).paddingAll(10).scrollDirection(Axis.horizontal),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          controller: controller.inputDate,
                          onTap: () => dayDate.pickHijriDate(context),
                          label: 'تاريخ اليوم',
                          customHeight: 20,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          controller: controller.separationDate,
                          onTap: () => serviceStartDate.pickHijriDate(context),
                          label: 'تاريخ بداية الخدمة',
                          customHeight: 20,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          controller: controller.edara,
                          label: 'الإدارة',
                          customHeight: 20,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          controller: controller.notesForPrint,
                          label: 'ملاحظات للطباعة ',
                          customHeight: 40,
                          customWidth: currentWidth * 0.2,
                        ),
                      ],
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomCheckbox(
                            label: "صورة",
                            value: controller.isPicture.value,
                            onChanged: (value) {
                              controller.onChangPicture();
                            },
                          ).paddingAll(2),
                          CustomCheckbox(
                            label: "ندب",
                            value: controller.nadeb.value,
                            onChanged: (value) {
                              controller.onChangNadeb();
                            },
                          ).paddingAll(2),
                          CustomCheckbox(
                            label: "الإجازة مستحقة رسميا",
                            value: controller.mostahaka.value,
                            onChanged: (value) {
                              controller.onChangeMostahaka();
                            },
                          ).paddingAll(2),
                          CustomCheckbox(
                            label: "موافقة الرئيس المباشر",
                            value: controller.directBoss.value,
                            onChanged: (value) {
                              controller.onChangeDirectBoss();
                            },
                          ).paddingAll(2),
                          CustomCheckbox(
                            label: "موافقة تمديد الإجازة",
                            value: controller.tamdeedIgazahAccept.value,
                            onChanged: (value) {
                              controller.onChangeTamdeedIgazahAccept();
                            },
                          ).paddingAll(2)
                        ],
                      ),
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "تمديد بيانات الاجازة",
                      onPressed: () async {
                        await Get.find<EmpHolidayTamdeedController>()
                            .clearControllers();
                        await Get.find<EmpHolidayTamdeedController>()
                            .findAllByHolidaysId(
                          int.parse(
                            controller.id.text,
                          ),
                        );
                        Get.dialog(const HolidayTamdeed());
                      },
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "تعديل",
                      onPressed: () {
                        if (checkUpdatePermission()) {
                          controller.save();
                        }
                      },
                      height: 35,
                      width: 120,
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
                      width: 120,
                    ),
                    CustomButton(
                      text: " قرار إجازة",
                      onPressed: () =>
                          controllerReport.createQrarHolidayReport(),
                      height: 35,
                      width: 120,
                    ),
                    CustomButton(
                      text: "طلب إجازة",
                      onPressed: () {
                        controllerRequestHolidayReport.generatePdf();
                      },
                      height: 35,
                      width: 150,
                    ),
                    CustomButton(
                      text: "طباعة مسير",
                      onPressed: () =>
                          controllerReport.createMoserHolidayReport(),
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
              ]).scrollDirection(Axis.vertical).paddingAll(15);
        },
      ),
    );
  }
}
