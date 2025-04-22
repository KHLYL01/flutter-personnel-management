import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/core/widgets/custom_progress_indicator.dart';
import 'package:personnel_management/feature/emp_tarqea/presentation/controllers/emp_tarqea_controller.dart';
import 'package:personnel_management/feature/tarmeez_emp_degrees/presentation/controllers/emp_degrees_find_controller.dart';
import 'package:personnel_management/feature/tarmeez_jobs/presentation/pages/jobs_find.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../core/functions/hijri_picker.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_check_box.dart';
import '../../../../core/widgets/custom_dropdown_button.dart';
import '../../../../core/widgets/custom_text_feild.dart';
import '../../../employee/presentation/controllers/employee_find_controller.dart';
import '../../../employee/presentation/pages/employee_find.dart';
import '../../../tarmeez_emp_degrees/presentation/pages/emp_degrees_find_page.dart';
import '../../../tarmeez_jobs/presentation/controllers/jobs_controller.dart';
import '../../../tarmeez_parts/presentation/controllers/parts_controller.dart';
import '../../../tarmeez_parts/presentation/pages/parts_find.dart';

class AddTarqea extends StatelessWidget {
  const AddTarqea({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpTarqeaController>();
    double currentWidth = Get.width;
    double currentHeight = Get.height;

    HijriPicker decisionDate = HijriPicker(controller.qrarDate);
    HijriPicker litterDate = HijriPicker(controller.khetabDate);
    HijriPicker authenticationDate = HijriPicker(controller.mosadakaDate);
    HijriPicker mahdarDate = HijriPicker(controller.mahdarDate);
    HijriPicker mobasharahDate = HijriPicker(controller.mobasharaDate);
    HijriPicker mobasharahLitterDate = HijriPicker(controller.mKhetabDate);

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
                      controller: controller.khetabId,
                      label: 'رقم الخطاب',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => litterDate.pickHijriDate(context),
                      controller: controller.khetabDate,
                      label: 'تاريخ الخطاب',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.mosadakaId,
                      label: 'رقم المصادقة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => authenticationDate.pickHijriDate(context),
                      controller: controller.mosadakaDate,
                      label: 'تاريخ المصادقة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.mahdarId,
                      label: 'رقم المحضر',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => mahdarDate.pickHijriDate(context),
                      controller: controller.mahdarDate,
                      label: 'تاريخ المحضر',
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
                                  onSelected: (event) {
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
                              Get.find<EmployeeFindController>().findEmployee();
                            },
                            height: 25,
                            width: 75)
                        .paddingOnly(top: 15)
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomDropdownButton(
                        // width: currentWidth * 0.2,
                        // height: 25,
                        label: 'يوم المباشرة',
                        list: controller.mobasharahDays,
                        item: controller.mobasharaDay,
                        onChanged: (value) {
                          controller.onChangeMobasharahDay(
                              controller.mobasharaDay.value);
                        }),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => mobasharahDate.pickHijriDate(context),
                      controller: controller.mobasharaDate,
                      label: 'تاريخ المباشرة ',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.percent,
                      label: 'النسبة المئوية لطبيعة العمل',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomTextField(
                      controller: controller.mKhetabId,
                      label: 'رقم خطاب المباشرة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.07,
                    ),
                    CustomTextField(
                      suffixIcon: const Icon(
                        Icons.date_range_sharp,
                        size: 15,
                      ),
                      onTap: () => mobasharahLitterDate.pickHijriDate(context),
                      controller: controller.mKhetabDate,
                      label: 'تاريخ خطاب المباشرة',
                      customHeight: 25,
                      customWidth: currentWidth * 0.15,
                    ),
                    Obx(
                      () => CustomCheckbox(
                        label: "صورة",
                        value: controller.isPicture.value,
                        onChanged: (value) {
                          controller.onChangedPicture();
                        },
                      ).paddingOnly(top: 20),
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    Container(
                      color: AppColors.greyLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الوظيفة التي يشغلها : '),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldJobId,
                                label: 'المسمى الوظيفي',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldJobName,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<JobsController>()
                                            .clearControllersForSearch();
                                        Get.dialog(
                                          JobsFind(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.oldJobId.text =
                                                  cells['id']!.value.toString();
                                              controller.oldJobName.text =
                                                  cells['name']!
                                                      .value
                                                      .toString();
                                              Get.back();
                                            },
                                          ),
                                        );
                                        Get.find<JobsController>().findJobs();
                                      },
                                      height: 25,
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldFia,
                                label: 'المرتبة',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<EmpDegreesFindController>()
                                            .clearControllers();
                                        Get.dialog(
                                          EmpDegreesFindPage(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.oldFia.text =
                                                  cells['martaba']!
                                                      .value
                                                      .toString();
                                              controller.oldSalary.text =
                                                  cells['salary']!
                                                      .value
                                                      .toString();
                                              controller.oldNaqlBadal.text =
                                                  cells['naqlBadal']!
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
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                controller: controller.oldNo,
                                label: 'الرقم',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                controller: controller.oldSymble,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldSalary,
                                label: 'الراتب',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldNaqlBadal,
                                label: 'بدل النقل',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomTextField(
                                controller: controller.oldJobBadalat,
                                label: 'طبيعة العمل',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldPartId,
                                label: 'القسم',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.oldPartName,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<PartsController>()
                                            .clearControllersForSearch();
                                        Get.dialog(
                                          PartsFind(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.oldPartId.text =
                                                  cells['id']!.value.toString();
                                              controller.oldPartName.text =
                                                  cells['name']!
                                                      .value
                                                      .toString();
                                              Get.back();
                                            },
                                          ),
                                        );
                                        Get.find<PartsController>().findParts();
                                      },
                                      height: 25,
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                        ],
                      ).marginAll(10),
                    ),
                    ////////
                    Container(
                      color: AppColors.greyLight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('الوظيفة  المرقّى إليها : '),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.newJobId,
                                label: 'المسمى الوظيفي',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.newJobName,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<JobsController>()
                                            .clearControllersForSearch();
                                        Get.dialog(
                                          JobsFind(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.newJobId.text =
                                                  cells['id']!.value.toString();
                                              controller.newJobName.text =
                                                  cells['name']!
                                                      .value
                                                      .toString();
                                              Get.back();
                                            },
                                          ),
                                        );
                                        Get.find<JobsController>().findJobs();
                                      },
                                      height: 25,
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.newFia,
                                label: 'المرتبة',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<EmpDegreesFindController>()
                                            .clearControllers();
                                        Get.dialog(
                                          EmpDegreesFindPage(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.newFia.text =
                                                  cells['martaba']!
                                                      .value
                                                      .toString();
                                              controller.newSalary.text =
                                                  cells['salary']!
                                                      .value
                                                      .toString();
                                              controller.newNaqlBadal.text =
                                                  cells['naqlBadal']!
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
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                controller: controller.newNo,
                                label: 'الرقم',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                controller: controller.newSymble,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.newSalary,
                                label: 'الراتب',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.newNaqlBadal,
                                label: 'بدل النقل',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                              CustomTextField(
                                controller: controller.newJobBadalat,
                                label: 'طبيعة العمل',
                                customHeight: 25,
                                customWidth: currentWidth * 0.1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              CustomTextField(
                                enabled: false,
                                controller: controller.newPartId,
                                label: 'القسم',
                                customHeight: 25,
                                customWidth: currentWidth * 0.07,
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: controller.newPartName,
                                label: '',
                                customHeight: 25,
                                customWidth: currentWidth * 0.15,
                              ),
                              CustomButton(
                                      text: 'اختر',
                                      onPressed: () {
                                        Get.find<PartsController>()
                                            .clearControllersForSearch();
                                        Get.dialog(
                                          PartsFind(
                                            onSelected: (event) {
                                              Map<String, PlutoCell> cells =
                                                  event.row!.cells;
                                              controller.newPartId.text =
                                                  cells['id']!.value.toString();
                                              controller.newPartName.text =
                                                  cells['name']!
                                                      .value
                                                      .toString();
                                              Get.back();
                                            },
                                          ),
                                        );
                                        Get.find<PartsController>().findParts();
                                      },
                                      height: 25,
                                      width: 50)
                                  .paddingOnly(top: 20),
                            ],
                          ),
                        ],
                      ).marginAll(10),
                    ).marginOnly(right: 10)
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomButton(
                      text: "ترقية جديدة",
                      onPressed: () => controller.clearControllers(),
                      height: 35,
                      width: 120,
                    ),
                    // CustomButton(
                    //   text: "طباعة قرار ترقية",
                    //   onPressed: () {},
                    //   height: 35,
                    //   width: 150,
                    // ),
                    // CustomButton(
                    //   text: "طباعة قرار ترقية بنسبة طباعة عمل",
                    //   onPressed: () {},
                    //   height: 35,
                    //   width: 200,
                    // ),
                    // CustomButton(
                    //   text: "طباعة مباشرة",
                    //   onPressed: () {},
                    //   height: 35,
                    //   width: 120,
                    // ),
                    CustomButton(
                      text: "حفظ",
                      onPressed: () => controller.save(),
                      height: 35,
                      width: 120,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
              ],
            ).scrollDirection(Axis.vertical).paddingAll(15);
          },
        ),
      ),
    );
  }
}
