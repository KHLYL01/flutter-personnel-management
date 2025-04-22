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
import '../controllers/emp_entedab_controller.dart';

class UpdateEntedab extends StatelessWidget {
  const UpdateEntedab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EmpEntedabController>();
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

    return Dialog(
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
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.qrarId,
                      label: 'رقم القرار',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.period,
                      label: 'مدة الانتداب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.place,
                      label: 'جهة الانتداب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.task,
                      label: 'المهمة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.khetabId,
                      label: 'رقم الخطاب',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
                    ),
                    CustomTextField(
                      controller: controller.distance,
                      label: 'مسافة السفر',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
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
                    Column(
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => hijriDecisionDate.pickHijriDate(context),
                          controller: controller.datQrar,
                          label: 'تاريخ القرار',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          controller: controller.datQrarGo,
                          label: '',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () =>
                              hijriStartIntedabDate.pickHijriDate(context),
                          controller: controller.datBegin,
                          label: 'تاريخ بداية الانتداب',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          controller: controller.datBeginGo,
                          label: '',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () =>
                              hijriEndIntedabDate.pickHijriDate(context),
                          controller: controller.datEnd,
                          label: 'تاريخ نهاية الانتداب',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          controller: controller.datEndGo,
                          label: '',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomTextField(
                          suffixIcon: const Icon(
                            Icons.date_range_sharp,
                            size: 15,
                          ),
                          onTap: () => hijriLitterDate.pickHijriDate(context),
                          controller: controller.datKhrtab,
                          label: 'تاريخ الخطاب',
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                        CustomTextField(
                          label: '',
                          controller: controller.datKhetabGo,
                          customHeight: 35,
                          customWidth: currentWidth * 0.2,
                        ),
                      ],
                    )
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomTextField(
                      controller: controller.taskRaValue,
                      label: 'قيمة التذكرة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.15,
                    ),
                    CustomDropdownButton(
                        label: 'وسيلة السفر',
                        list: controller.vehicles,
                        item: controller.waselTsafar,
                        onChanged: (value) {
                          controller.onChangeType(controller.type.value);
                        }),
                    CustomDropdownButton(
                        label: 'النوع',
                        list: controller.types,
                        item: controller.type,
                        onChanged: (value) {
                          controller.onChangeType(controller.type.value);
                        }),
                    CustomDropdownButton(
                        label: 'اليوم',
                        list: controller.days,
                        item: controller.day,
                        onChanged: (value) {
                          controller.onChangeDay(controller.day.value);
                        }),
                  ],
                ).scrollDirection(Axis.horizontal),
                Row(
                  children: [
                    CustomDropdownButton(
                        label: 'الفئة',
                        list: controller.categories,
                        item: controller.fia,
                        onChanged: (value) {
                          controller.onChangeCategory(controller.fia.value);
                        }),
                    CustomTextField(
                      controller: controller.fiaMony,
                      label: 'مبلغ الفئة',
                      customHeight: 35,
                      customWidth: currentWidth * 0.2,
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
                      text: "إضافة موظف",
                      onPressed: () {},
                      height: 30,
                      width: 100,
                    ),
                    // CustomButton(
                    //   text: "طباعة أمر إركاب ",
                    //   onPressed: () {},
                    //   height: 30,
                    //   width: 120,
                    // ),
                    // CustomButton(
                    //   text: "طباعة أمر إنتداب",
                    //   onPressed: () {},
                    //   height: 30,
                    //   width: 120,
                    // ),
                    // CustomButton(
                    //   text: "طباعة قرار إنتداب",
                    //   onPressed: () {},
                    //   height: 30,
                    //   width: 120,
                    // ),
                    // CustomButton(
                    //   text: "استحقاق الراتب",
                    //   onPressed: () {},
                    //   height: 30,
                    //   width: 100,
                    // ),
                    CustomButton(
                      text: "تعديل",
                      onPressed: () => controller.save(),
                      height: 30,
                      width: 120,
                    ),
                    CustomButton(
                      text: "حذف",
                      onPressed: () => controller.confirmDelete(
                        int.parse(controller.id.text),
                        withGoBack: true,
                      ),
                      height: 30,
                      width: 120,
                    ),
                  ],
                ).scrollDirection(Axis.horizontal).center(),
                SizedBox(
                  height: currentHeight / 1.5,
                  width: currentWidth - 140,
                  child: PlutoGrid(
                    configuration:getPlutoConfig(),

                    rows: [],
                    columns: [
                      PlutoColumn(
                        title: 'الاسم',
                        field: 'name',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'المرتبة',
                        field: 'rank',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الدرجة',
                        field: 'degree',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الراتب',
                        field: '  ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'بدل النقل',
                        field: ' ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'بدل الانتداب',
                        field: '',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'مدة الانتداب السابقة',
                        field: '      ',
                        type: PlutoColumnType.text(),
                      ),
                      PlutoColumn(
                        title: 'الانتداب الخارجي',
                        field: '    ',
                        type: PlutoColumnType.text(),
                      ),
                    ],
                    mode: PlutoGridMode.selectWithOneTap,
                    onSelected: (event) {},
                  ),
                )
              ])
              .scrollDirection(Axis.vertical)
              .paddingOnly(left: 16, right: 16, top: 16);
        },
      ),
    );
  }
}
