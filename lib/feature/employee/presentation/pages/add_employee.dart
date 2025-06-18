import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_radio_list_tile.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../tarmeez_emp_degrees/presentation/controllers/emp_degrees_find_controller.dart';
import '../../../tarmeez_emp_degrees/presentation/pages/emp_degrees_find_page.dart';
import '../../../tarmeez_jobs/presentation/controllers/jobs_controller.dart';
import '../../../tarmeez_jobs/presentation/pages/jobs_find.dart';
import '../../../tarmeez_nations/presentation/controllers/nations_controller.dart';
import '../../../tarmeez_nations/presentation/pages/nations_find.dart';
import '../../../tarmeez_parts/presentation/controllers/parts_controller.dart';
import '../../../tarmeez_parts/presentation/pages/parts_find.dart';
import '../controllers/employee_report_controller.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmployeeController>();
    final controllerReport = Get.find<EmployeeReportController>();

    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker graduationDate = HijriPicker(controller.datEducation);
    HijriPicker sodorDate = HijriPicker(controller.sodorDate);
    HijriPicker dateOfBirth = HijriPicker(controller.datBirth);
    HijriPicker serviceStartDate = HijriPicker(controller.datWork);
    HijriPicker loanStartDate = HijriPicker(controller.datAkdBegin);
    HijriPicker loanEndDate = HijriPicker(controller.datAkdEnd);
    HijriPicker cardSodorDate = HijriPicker(controller.cardStart);
    HijriPicker shaghlWazefaDate = HijriPicker(controller.datJob);
    HijriPicker datAkdBegin = HijriPicker(controller.datAkdBegin);
    HijriPicker datAkdEnd = HijriPicker(controller.datAkdEnd);
    return BaseScreen(
      widget: Obx(
        () {
          if (controller.isLoading.value) {
            return const CustomProgressIndicator();
          }
          return SizedBox(
            height: currentHeight,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomTextField(
                                  controller: controller.id,
                                  label: 'رقم الموظف',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                // CustomTextField(
                                //   onTap: () => {},
                                //   suffixIcon: const Icon(
                                //     Icons.edit,
                                //     size: 15,
                                //   ),
                                //   controller: controller.updateEmployeeNumber,
                                //   label: ' تعديل رقم الموظف',
                                //   customHeight: 25,
                                //   customWidth: 100,
                                // ),
                                CustomDropdownButton(
                                  label: 'نوع بيانات الوظيفة ',
                                  // height: 25,
                                  // width: 100,,
                                  item: controller.empType,
                                  list: controller.jobDataTypes,
                                  onChanged: (value) {
                                    controller.onChangeJobDataType(value);
                                  },
                                ),
                                if (controller.empType.value != "عامل أجنبي" &&
                                    controller.empType.value !=
                                        "عامل نظافة - عقد" &&
                                    controller.empType.value !=
                                        "مكافأة رئيس البلدية" &&
                                    controller.empType.value !=
                                        "مكافأة المجلس البلدي" &&
                                    controller.empType.value !=
                                        "عامل بند إجور غير سعودى")
                                  CustomButton(
                                    text: 'اختر',
                                    onPressed: () {
                                      Get.find<EmpDegreesFindController>()
                                          .clearControllers();
                                      Get.dialog(
                                        EmpDegreesFindPage(
                                          onRowDoubleTap: (event) {
                                            Map<String, PlutoCell> cells =
                                                event.row.cells;
                                            controller.degreeId.text =
                                                cells['id']!.value.toString();

                                            controller.fia.text =
                                                cells['martaba']!
                                                    .value
                                                    .toString();
                                            controller.salary.text =
                                                cells['salary']!
                                                    .value
                                                    .toString();
                                            controller.naqlBadal.text =
                                                cells['naqlBadal']!
                                                    .value
                                                    .toString();
                                            controller.draga.text =
                                                cells['draga']!
                                                    .value
                                                    .toString();
                                            controller.outEntedabBadal.text =
                                                cells['outEntedabadal']!
                                                    .value
                                                    .toString();
                                            controller.inEntedabBadal.text =
                                                cells['inEntedabBadal']!
                                                    .value
                                                    .toString();
                                            controller.elawa.text =
                                                cells['elawa']!
                                                    .value
                                                    .toString();
                                            Get.back();
                                          },
                                        ),
                                      );
                                      Get.find<EmpDegreesFindController>()
                                          .findEmpDegrees();
                                    },
                                    height: 25,
                                    width: 40,
                                  ).paddingOnly(top: 20),
                                if (controller.empType.value != "عامل أجنبي" &&
                                    controller.empType.value !=
                                        "عامل نظافة - عقد" &&
                                    controller.empType.value !=
                                        "مكافأة رئيس البلدية" &&
                                    controller.empType.value !=
                                        "مكافأة المجلس البلدي" &&
                                    controller.empType.value !=
                                        "عامل بند إجور غير سعودى")
                                  CustomTextField(
                                    controller: controller.degreeId,
                                    label: 'بيانات الوظيفة',
                                    customHeight: 25,
                                    customWidth: 100,
                                  ),
                                if (controller.empType.value !=
                                        "مكافأة رئيس البلدية" &&
                                    controller.empType.value !=
                                        "مكافأة المجلس البلدي")
                                  CustomTextField(
                                    controller: controller.draga,
                                    label: 'الدرجة',
                                    customHeight: 25,
                                    customWidth: 100,
                                  ),
                                CustomTextField(
                                  controller: controller.draga2,
                                  label: '',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                              ],
                            ).scrollDirection(Axis.horizontal),
                            Row(
                              children: [
                                CustomTextField(
                                  controller: controller.jobNo,
                                  label: 'رقم الوظيفة',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                CustomTextField(
                                  controller: controller.jobbadalat,
                                  label: 'بدلات الوظيفة',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                CustomTextField(
                                  controller: controller.fia,
                                  label: controller.empType.value != "مستخدم" &&
                                          controller.empType.value !=
                                              "عامل بند إجور" &&
                                          controller.empType.value !=
                                              "عامل أجنبي" &&
                                          controller.empType.value !=
                                              "عامل بند إجور غير سعودى"
                                      ? 'المرتبة'
                                      : 'الفئة',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                CustomTextField(
                                  controller: controller.salary,
                                  label: 'الراتب',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                CustomTextField(
                                  controller: controller.naqlBadal,
                                  label: 'بدل النقل',
                                  customHeight: 25,
                                  customWidth: 100,
                                ),
                                if (controller.empType.value != "مستخدم" &&
                                    controller.empType.value !=
                                        "عامل بند إجور" &&
                                    controller.empType.value != "عامل أجنبي" &&
                                    controller.empType.value !=
                                        "مكافأة رئيس البلدية" &&
                                    controller.empType.value !=
                                        "مكافأة المجلس البلدي" &&
                                    controller.empType.value !=
                                        "عامل بند إجور غير سعودى")
                                  CustomTextField(
                                    controller: controller.elawa,
                                    label: 'العلاوة الدورية',
                                    customHeight: 25,
                                    customWidth: 100,
                                  ),
                                if (controller.empType.value != "مستخدم" &&
                                    controller.empType.value != "عامل أجنبي" &&
                                    controller.empType.value !=
                                        "عامل بند إجور غير سعودى")
                                  CustomTextField(
                                    controller: controller.inEntedabBadal,
                                    label: controller.empType.value !=
                                            "عامل بند إجور"
                                        ? 'بدل انتداب داخلي'
                                        : '',
                                    customHeight: 25,
                                    customWidth: 100,
                                  ),
                                if (controller.empType.value != "مستخدم" &&
                                    controller.empType.value != "عامل أجنبي" &&
                                    controller.empType.value !=
                                        "عامل بند إجور غير سعودى")
                                  CustomTextField(
                                    controller: controller.outEntedabBadal,
                                    label: controller.empType.value !=
                                            "عامل بند إجور"
                                        ? 'بدل انتداب خارجي'
                                        : '',
                                    customHeight: 25,
                                    customWidth: 100,
                                  ),
                              ],
                            ).scrollDirection(Axis.horizontal),
                          ],
                        ),
                        if (controller.empType.value == "عامل أجنبي" ||
                            controller.empType.value == "مكافأة رئيس البلدية" ||
                            controller.empType.value ==
                                "مكافأة المجلس البلدي" ||
                            controller.empType.value ==
                                "عامل بند إجور غير سعودى")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomTextField(
                                    suffixIcon: const Icon(
                                      Icons.date_range_sharp,
                                      size: 15,
                                    ),
                                    onTap: () =>
                                        datAkdBegin.pickHijriDate(context),
                                    controller: controller.datAkdBegin,
                                    label: "تاريخ العقد",
                                    customHeight: 25,
                                    customWidth: 120,
                                  ),
                                  CustomTextField(
                                    suffixIcon: const Icon(
                                      Icons.date_range_sharp,
                                      size: 15,
                                    ),
                                    onTap: () =>
                                        datAkdEnd.pickHijriDate(context),
                                    controller: controller.datAkdEnd,
                                    label: "تاريخ نهاية العقد",
                                    customHeight: 25,
                                    customWidth: 120,
                                  ),
                                ],
                              ),
                              CustomDropdownButton(
                                label: 'استحقاق نهاية الخدمة',
                                // height: 25,
                                // width: 100,,
                                item: controller.esthqaqEndAkd,
                                list: controller.esthqaqAkd,
                                onChanged: controller.onChangeEsthqaqEndAkd,
                              ),
                            ],
                          )
                      ],
                    ),
                    Row(
                      children: [
                        CustomTextField(
                          controller: controller.jobId,
                          label: 'مسمى الوظيفة',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.jobName,
                          label: '',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomButton(
                          text: 'اختر',
                          onPressed: () {
                            Get.find<JobsController>()
                                .clearControllersForSearch();
                            Get.dialog(
                              JobsFind(
                                onRowDoubleTap: (event) {
                                  Map<String, PlutoCell> cells =
                                      event.row.cells;
                                  controller.jobId.text =
                                      cells['id']!.value.toString();
                                  controller.jobName.text =
                                      cells['name']!.value.toString();
                                  Get.back();
                                },
                              ),
                            );
                            Get.find<JobsController>().findJobs();
                          },
                          height: 25,
                          width: 40,
                        ).paddingOnly(top: 20),
                        CustomTextField(
                          label: 'الرمز التصنيفي',
                          controller: controller.symble,
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.partId,
                          label: 'القسم',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.partName,
                          label: '',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomButton(
                          text: 'اختر',
                          onPressed: () {
                            Get.find<PartsController>()
                                .clearControllersForSearch();
                            Get.dialog(
                              PartsFind(
                                onRowDoubleTap: (event) {
                                  Map<String, PlutoCell> cells =
                                      event.row.cells;
                                  controller.partId.text =
                                      cells['id']!.value.toString();
                                  controller.partName.text =
                                      cells['name']!.value.toString();
                                  Get.back();
                                },
                              ),
                            );
                            Get.find<PartsController>().findParts();
                          },
                          height: 25,
                          width: 40,
                        ).paddingOnly(top: 20)
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => shaghlWazefaDate.pickHijriDate(context),
                          controller: controller.datJob,
                          label: "تاريخ شغل الوظيفة",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomDropdownButton(
                          label: ' حالة الوظيفة ',
                          // height: 25,
                          // width: 100,,
                          item: controller.jobState,
                          list: controller.jobStatus,
                          onChanged: (value) {
                            controller.onChangeJobDataStatu(value);
                          },
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      children: [
                        CustomTextField(
                          controller: controller.name,
                          label: 'اسم الموظف ',
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.cardId,
                          label: 'رقم السجل المدني/الإقامة',
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.takenHolidays,
                          label: 'الإجازات المسجلة حتى الأن',
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.nationId,
                          label: 'الجنسية',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.nationName,
                          label: '',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomButton(
                          text: 'اختر',
                          onPressed: () {
                            Get.find<NationsController>()
                                .clearControllersForSearch();
                            Get.dialog(
                              NationsFind(
                                onRowDoubleTap: (event) {
                                  Map<String, PlutoCell> cells =
                                      event.row.cells;
                                  controller.nationId.text =
                                      cells['id']!.value.toString();
                                  controller.nationName.text =
                                      cells['name']!.value.toString();
                                  Get.back();
                                },
                              ),
                            );
                            Get.find<NationsController>().findNations();
                          },
                          height: 25,
                          width: 40,
                        ).paddingOnly(top: 20),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      children: [
                        CustomTextField(
                          controller: controller.bok,
                          label: 'رقم الحفيظة',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.makanAlsodor,
                          label: 'مكان الصدور',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => sodorDate.pickHijriDate(context),
                          controller: controller.sodorDate,
                          label: "تاريخ الصدور",
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.birthPlace,
                          label: ' مكان الميلاد',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => dateOfBirth.pickHijriDate(context),
                          controller: controller.datBirth,
                          label: "تاريخ الميلاد",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => serviceStartDate.pickHijriDate(context),
                          controller: controller.datWork,
                          label: "تاريخ بداية الخدمة",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      children: [
                        CustomTextField(
                            controller: controller.education,
                            label: 'اسم المؤهل العلمي',
                            customHeight: 25,
                            customWidth: 150),
                        CustomTextField(
                            controller: controller.educationName,
                            label: 'اسم المؤسسة العلمية',
                            customHeight: 25,
                            customWidth: 150),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => graduationDate.pickHijriDate(context),
                          controller: controller.datEducation,
                          label: "تاريخ التخرج",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.address,
                          label: 'العنوان',
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.phone,
                          label: 'الهاتف',
                          customHeight: 25,
                          customWidth: 150,
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      children: [
                        CustomTextField(
                          controller: controller.workJob,
                          label: 'العمل المكلف به',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.cardNo,
                          label: 'رقم بطاقة العمل',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => cardSodorDate.pickHijriDate(context),
                          controller: controller.cardStart,
                          label: "تاريخ صدور البطاقة",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => loanStartDate.pickHijriDate(context),
                          controller: controller.datAkdBegin,
                          label: "تاريخ بداية القرض",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => loanEndDate.pickHijriDate(context),
                          controller: controller.datAkdEnd,
                          label: "تاريخ نهاية القرض",
                          customHeight: 25,
                          customWidth: 150,
                        ),
                        CustomTextField(
                          controller: controller.qardMony,
                          label: 'المبلغ ',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.qardQest,
                          label: 'القسط',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.taka3odM,
                          label: 'تقاعد معاد',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      children: [
                        Container(
                          color: Colors.grey.shade200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('مسير الرواتب'),
                              CustomTextField(
                                controller: controller.badal2,
                                label: 'ضرر/عدوى',
                                customHeight: 25,
                                customWidth: 100,
                              ),
                              CustomTextField(
                                controller: controller.badal4,
                                label: 'أخرى',
                                customHeight: 25,
                                customWidth: 100,
                              ),
                            ],
                          ).paddingAll(10),
                        ).paddingOnly(top: 10, right: 10),
                        Obx(
                          () => SizedBox(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRadioListTile<String>(
                                  value: "سعودي",
                                  groupValue: controller
                                      .nationalityRadoiListTileValue.value,
                                  title: "سعودي",
                                  onChanged: (value) {
                                    controller
                                        .onChangeNationalityRadoiListTileValue(
                                            value);
                                  },
                                ),
                                CustomRadioListTile<String>(
                                  value: "أجنبي",
                                  groupValue: controller
                                      .nationalityRadoiListTileValue.value,
                                  title: "أجنبي",
                                  onChanged: (value) {
                                    controller
                                        .onChangeNationalityRadoiListTileValue(
                                            value);
                                  },
                                ),
                                CustomRadioListTile<String>(
                                  value: "أجنبي",
                                  groupValue: controller
                                      .nationalityRadoiListTileValue.value,
                                  title: "أجنبي",
                                  onChanged: (value) {
                                    controller
                                        .onChangeNationalityRadoiListTileValue(
                                            value);
                                  },
                                ),
                              ],
                            ),
                          ).paddingAll(15),
                        ),
                        CustomTextField(
                          controller: controller.dissent,
                          label: 'بنك التسليف',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.akdNoTasleef,
                          label: 'رقم العقد',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.sandok,
                          label: 'عقاري',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.contractOfrealEstateBank,
                          label: 'رقم العقد',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.zeraee,
                          label: 'البنك الزراعي ',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.hasm1,
                          label: 'التأمين الصحي',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        CustomTextField(
                          controller: controller.hasm2,
                          label: 'أخرى',
                          customHeight: 25,
                          customWidth: 100,
                        ),
                        Obx(
                          () => CustomCheckbox(
                            label: 'ساند',
                            value: controller.isHasm3.value,
                            onChanged: (value) {
                              controller.onChangeSaned();
                            },
                          ),
                        ).paddingOnly(top: 20),
                      ],
                    ).scrollDirection(Axis.horizontal),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // CustomButton(
                        //   text: 'حذف',
                        //   onPressed: () => {},
                        //   height: 30,
                        //   width: 80,
                        // ),
                        // CustomButton(
                        //   text: 'عودة',
                        //   onPressed: () => {},
                        //   height: 30,
                        //   width: 80,
                        // ),
                      ],
                    ).scrollDirection(Axis.horizontal).center(),
                  ],
                ).paddingAll(10).scrollDirection(Axis.vertical),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'طباعة كارت تعريفي',
                      onPressed: () => controllerReport.createEmployeeCard(),
                      height: 30,
                      width: 120,
                    ),
                    Row(
                      children: [
                        CustomButton(
                          text: 'مشهد بالراتب',
                          height: 30,
                          width: 120,
                          onPressed: () =>
                              controllerReport.createMashhadRatebReport(),
                        ),
                        CustomButton(
                            text: 'شهادة تعريف',
                            onPressed: () =>
                                controllerReport.createShahadaTarefReport(),
                            height: 30,
                            width: 120),
                      ],
                    ),
                    Row(
                      children: [
                        CustomButton(
                          text: 'بيان خدمات موظف',
                          onPressed: () =>
                              controllerReport.createBeanKhedmhEmployeeReport(),
                          height: 30,
                          width: 120,
                        ),
                        CustomButton(
                            text: 'طباعة مكافئة عن الاجازات',
                            onPressed: () =>
                                controllerReport.createMokafaaHolidayReport(),
                            height: 30,
                            width: 120),
                      ],
                    ),
                    Row(
                      children: [
                        CustomButton(
                            text: 'طباعة قرار طي القيد ',
                            onPressed: () {},
                            height: 30,
                            width: 120),
                        CustomButton(
                          text: 'عقد عامل',
                          onPressed: () =>
                              controllerReport.createAkdEmployeeReport(),
                          height: 30,
                          width: 120,
                        ),
                      ],
                    ),
                    CustomTextField(
                      label: 'تاريخ خطاب التعريف',
                      controller: TextEditingController(),
                      customHeight: 25,
                      customWidth: 120,
                    ),
                    Row(
                      children: [
                        CustomTextField(
                          label: 'جهة خطاب التعريف',
                          controller: TextEditingController(),
                          customHeight: 25,
                          customWidth: 120,
                        ),
                        Obx(
                          () => CustomCheckbox(
                            label: 'صورة',
                            value: controller.isPicture.value,
                            onChanged: (value) {
                              controller.onChangeIsPicture();
                            },
                          ).paddingOnly(top: 20),
                        ),
                      ],
                    ),
                    Obx(() {
                      return Container(
                        width: currentHeight * 0.2,
                        height: currentHeight * 0.2,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(10),
                          image: controller.employeePhoto.value.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                      controller.employeePhoto.value),
                                  fit: BoxFit.fill,
                                )
                              : null,
                        ),
                        child: controller.employeePhoto.value.isEmpty
                            ? const Icon(Icons.add_a_photo,
                                size: 50, color: Colors.white)
                            : null,
                      );
                    }).onTap(controller.pickImage).paddingAll(15),
                    CustomButton(
                      text: 'حفظ',
                      onPressed: () => controller.save(),
                      height: 30,
                      width: 80,
                    ),
                    CustomButton(
                      text: 'إضافة جديدة',
                      onPressed: () => controller.clearControllers(),
                      height: 30,
                      width: 80,
                    ),
                  ],
                ),
              ],
            ).scrollDirection(Axis.horizontal),
          );
        },
      ),
    );
  }
}
