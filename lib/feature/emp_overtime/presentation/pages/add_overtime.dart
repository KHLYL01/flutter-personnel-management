// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:municipality/core/extensions/widget_extension.dart';
// import 'package:municipality/presentation/screens/base_screen.dart';
// import 'package:municipality/presentation/widgets/custom_check_box.dart';
// import 'package:municipality/presentation/widgets/custom_dropdown_button.dart';
// import 'package:personnel_management/core/extensions/widget_extension.dart';
// import 'package:personnel_management/feature/emp_overtime/presentation/controllers/emp_overtime_controller.dart';
// import '../../../../../../core/functions/hijri_picker.dart';
// import '../../../../../widgets/custom_button.dart';
// import '../../../../../widgets/custom_text_feild.dart';
// import '../../../../core/widgets/base_screen.dart';
// import '../../../../core/widgets/custom_dropdown_button.dart';
// import '../../../../core/widgets/custom_text_feild.dart';
// import '../controllers/kharij_controller.dart';
//
// class AddOvertime extends StatelessWidget {
//   const AddOvertime({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double currentWidth = Get.width;
//     double currentHeight = Get.height;
//     final controller = Get.find<EmpOvertimeController>();
//
//     late HijriPicker qararDate =
//         HijriPicker(controller.hijriQararDate, controller.geoQararDate);
//     late HijriPicker khitabDate =
//         HijriPicker(controller.khitabDate, controller.geoKhitabDate);
//     late HijriPicker startDateKharij = HijriPicker(
//         controller.hijriStartDateOvertime, controller.geoStartDateOvertime);
//     late HijriPicker endDateKharij = HijriPicker(
//         controller.hijriEndDateOvertime, controller.geoEndDateOvertime);
//     return Scaffold(
//         body: BaseScreen(
//       widget: ListView(shrinkWrap: true, children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 CustomDropdownButton(
//                     label: "اليوم",
//                     list: controller.days,
//                     item: controller.selectedDay,
//                     onChanged: controller.onChangedDay),
//                 CustomTextField(
//                   controller: controller.khitamNum,
//                   label: "رقم الخطاب",
//                   customHeight: 25,
//                   customWidth: currentWidth * 0.2,
//                 ),
//                 SizedBox(
//                   width: currentWidth * 0.09,
//                 ),
//                 Obx(() => Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomCheckbox(
//                           label: 'صورة',
//                           value: controller.isPicture.value,
//                           onChanged: (value) {
//                             controller.onChangedPicture();
//                           },
//                         ),
//                         CustomCheckbox(
//                           label: 'عيد الفطر',
//                           value: controller.isEidFutur.value,
//                           onChanged: (value) {
//                             controller.onChangedEidFutur();
//                           },
//                         ),
//                         CustomCheckbox(
//                           label: 'عيد الأضحى',
//                           value: controller.isEidAdhaa.value,
//                           onChanged: (value) {
//                             controller.onChangedEidAdhaa();
//                           },
//                         ),
//                       ],
//                     ))
//               ],
//             ).scrollDirection(Axis.horizontal),
//             Row(
//               children: [
//                 CustomTextField(
//                   controller: controller.id,
//                   label: "مسلسل",
//                   customHeight: 25,
//                   customWidth: currentWidth / 3,
//                 ),
//                 CustomTextField(
//                   controller: controller.part,
//                   label: "اسم القسم ",
//                   customHeight: 25,
//                   customWidth: currentWidth / 3,
//                 ),
//               ],
//             ).scrollDirection(Axis.horizontal),
//             Row(
//               children: [
//                 CustomTextField(
//                   controller: controller.qararId,
//                   label: "رقم القرار",
//                   customHeight: 25,
//                   customWidth: currentWidth / 3,
//                 ),
//                 CustomTextField(
//                   controller: controller.mission,
//                   label: "اسم المهمة ",
//                   customHeight: 25,
//                   customWidth: currentWidth * 0.33,
//                 ).scrollDirection(
//                   Axis.horizontal,
//                 ),
//               ],
//             ).scrollDirection(Axis.horizontal),
//             Row(
//               children: [
//                 CustomTextField(
//                   controller: controller.dayNum,
//                   label: "عدد الايام",
//                   customHeight: 25,
//                   customWidth: currentWidth / 3,
//                 ),
//                 CustomTextField(
//                   controller: controller.hoursAvg,
//                   label: "معدل عدد الساعات",
//                   customHeight: 25,
//                   customWidth: currentWidth / 3,
//                 ),
//               ],
//             ).scrollDirection(Axis.horizontal),
//             Row(
//               children: [
//                 Column(
//                   children: [
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       onTap: () => startDateKharij.pickHijriDate(context),
//                       controller: controller.hijriStartDateOvertime,
//                       label: "تاريخ بداية خارج دوام",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       controller: controller.geoStartDateOvertime,
//                       label: "",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       onTap: () => khitabDate.pickHijriDate(context),
//                       controller: controller.khitabDate,
//                       label: "تاريخ الخطاب",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       controller: controller.geoKhitabDate,
//                       label: "",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       onTap: () => qararDate.pickHijriDate(context),
//                       controller: controller.hijriQararDate,
//                       label: "تاريخ القرار",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       controller: controller.geoQararDate,
//                       label: "",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       onTap: () => endDateKharij.pickHijriDate(context),
//                       controller: controller.hijriEndDateOvertime,
//                       label: "تاريخ نهاية خارج دوام",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                     CustomTextField(
//                       suffixIcon: const Icon(
//                         Icons.date_range_sharp,
//                         size: 15,
//                       ),
//                       controller: controller.geoEndDateOvertime,
//                       label: "",
//                       customHeight: 25,
//                       customWidth: currentWidth * 0.2,
//                     ),
//                   ],
//                 )
//               ],
//             ).scrollDirection(Axis.horizontal),
//             SizedBox(
//               height: 75,
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomButton(
//                       text: 'حفظ', onPressed: () {}, height: 30, width: 120),
//                   CustomButton(
//                       text: 'إضافة جديد',
//                       onPressed: () {},
//                       height: 30,
//                       width: 120),
//                   CustomButton(
//                       text: 'طباعة قرار خارج الدوام',
//                       onPressed: () {},
//                       height: 30,
//                       width: 150),
//                   CustomButton(
//                       text: 'مسير خارج الدوام',
//                       onPressed: () {},
//                       height: 30,
//                       width: 120),
//                   CustomButton(
//                       text: 'قرار صرف خارج ',
//                       onPressed: () {},
//                       height: 30,
//                       width: 120),
//                 ],
//               ).scrollDirection(Axis.horizontal),
//             )
//           ],
//         ).paddingAll(5),
//       ]),
//     ));
//   }
// }
