import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../feature/tarmeez_bladia_info/presentation/pages/baladia_info.dart';
import '../widgets/clickable_text.dart';
import '../widgets/custom_pop_up_menu_button.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    double currentHeight = Get.height;
    double currentWidth = Get.width;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: currentWidth, maxHeight: currentHeight),
          color: AppColors.blueAccent,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: currentHeight / 11,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClickableText(
                    text: 'التجهيز و الإعداد',
                    onTap: () {},
                  ),

                  // Add spacing between items
                  CustomPopupMenuButton(
                      buttonText: 'الموظفين و العاملين',
                      items: const [],
                      onSelected: (page) {
                        switch (page) {}
                      }),

                  CustomPopupMenuButton(
                      buttonText: 'الترميز',
                      items: const [
                        PopupMenuItem(
                          value: AppRoutes.baladiaInfo,
                          child: Text(' بيانات البلدية'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.nations,
                          child: Text('أنواع الجنسيات'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.badal,
                          child: Text('بدل الانتداب '),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.dissents,
                          child: Text('أنواع المخالفات'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.jobs,
                          child: Text('أنواع الوظائف'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.parts,
                          child: Text('أنواع الأقسام'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.badalCountries,
                          child: Text('  تصنيف الدول حسب فئات البدل'),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.empDegrees,
                          child: Text('سلم درجات العمال'),
                        ),
                      ],
                      onSelected: (page) {
                        switch (page) {
                          case AppRoutes.jobs:
                            Get.toNamed(AppRoutes.jobs);
                            break;
                          case AppRoutes.dissents:
                            Get.toNamed(AppRoutes.dissents);
                            break;
                          case AppRoutes.badalCountries:
                            Get.toNamed(AppRoutes.badalCountries);
                            break;
                          case AppRoutes.nations:
                            Get.toNamed(AppRoutes.nations);
                            break;
                          case AppRoutes.baladiaInfo:
                            Get.toNamed(AppRoutes.baladiaInfo);
                            break;
                          case AppRoutes.badal:
                            Get.toNamed(AppRoutes.badal);
                            break;
                          case AppRoutes.empDegrees:
                            Get.toNamed(AppRoutes.empDegrees);
                            break;
                          case AppRoutes.parts:
                            Get.toNamed(AppRoutes.parts);
                            break;
                        }
                      }),
                  ClickableText(
                      text: 'البحث و الاستعلام',
                      onTap: () => Get.to(const BladiaInfo())),
                  // ClickableText(
                  //     text: 'متابعة طلبات الموظفين',
                  //     onTap: () => Get.to(Dissents())),
                  // ClickableText(
                  //     text: 'التقارير و الطباعة',
                  //     onTap: () => Get.to(const BadalCountries())),
                  // ClickableText(text: 'خروج', onTap: () => Get.to(Jobs())),
                ],
              ),
            ),
          ),
        ),
        widget.expanded(flex: 1),
      ],
    ));
  }
}
