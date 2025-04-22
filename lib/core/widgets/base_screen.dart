import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
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
            constraints: BoxConstraints(
                maxWidth: currentWidth, maxHeight: currentHeight),
            color: AppColors.greyDark,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: currentHeight / 11,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ClickableText(
                    //   text: 'التجهيز و الإعداد',
                    //   onTap: () {},
                    // ),

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
                            child: Text('سلم درجات الموظفين'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.empDegreesWorker,
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
                            case AppRoutes.empDegreesWorker:
                              Get.toNamed(AppRoutes.empDegreesWorker);
                              break;
                            case AppRoutes.parts:
                              Get.toNamed(AppRoutes.parts);
                              break;
                          }
                        }),
                    CustomPopupMenuButton(
                        buttonText: 'البحث و الاستعلام',
                        items: const [
                          PopupMenuItem(
                            value: AppRoutes.employeeSearch,
                            child: Text('الاستعلام عن موظف'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.entedabSearch,
                            child: Text('الاستعلام عن انتداب'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.overtimeSearch,
                            child: Text(' الاستعلام عن خارج الدوام'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.hasmiatSearch,
                            child: Text(' الاستعلام عن الحسميات'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.mokhalfatSearch,
                            child: Text(' الاستعلام عن المخالفات'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.holidaySearch,
                            child: Text(' الاستعلام عن إجازة'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.dowraSearch,
                            child: Text(' الاستعلام عن الدورات'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.kashfTepySearch,
                            child: Text(' الاستعلام عن كشف طبي'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.mobashraSearch,
                            child: Text(' الاستعلام عن مباشرة'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.eqrarSearch,
                            child: Text(' الاستعلام عن إقرار'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.tarqeaSearch,
                            child: Text(' الاستعلام عن ترقية'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.endSearch,
                            child: Text(' الاستعلام عن إنهاء خدمة'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.taeenSearch,
                            child: Text(' الاستعلام عن قرار تعيين'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.passportSearch,
                            child: Text(' الاستعلام عن إقرار جواز سفر'),
                          ),
                          PopupMenuItem(
                            value: AppRoutes.tafweedSearch,
                            child: Text(' الاستعلام عن تفويض'),
                          ),
                        ],
                        onSelected: (page) {
                          switch (page) {
                            case AppRoutes.employeeSearch:
                              Get.toNamed(AppRoutes.employeeSearch);
                              break;
                            case AppRoutes.entedabSearch:
                              Get.toNamed(AppRoutes.entedabSearch);
                              break;
                            case AppRoutes.mokhalfatSearch:
                              Get.toNamed(AppRoutes.mokhalfatSearch);
                              break;
                            case AppRoutes.dowraSearch:
                              Get.toNamed(AppRoutes.dowraSearch);
                              break;
                            case AppRoutes.holidaySearch:
                              Get.toNamed(AppRoutes.holidaySearch);
                              break;
                            case AppRoutes.overtimeSearch:
                              Get.toNamed(AppRoutes.overtimeSearch);
                              break;
                            case AppRoutes.hasmiatSearch:
                              Get.toNamed(AppRoutes.hasmiatSearch);
                              break;
                            case AppRoutes.tafweedSearch:
                              Get.toNamed(AppRoutes.tafweedSearch);
                              break;
                            case AppRoutes.kashfTepySearch:
                              Get.toNamed(AppRoutes.kashfTepySearch);
                              break;
                            case AppRoutes.mobashraSearch:
                              Get.toNamed(AppRoutes.mobashraSearch);
                              break;
                            case AppRoutes.tarqeaSearch:
                              Get.toNamed(AppRoutes.tarqeaSearch);
                              break;
                            case AppRoutes.eqrarSearch:
                              Get.toNamed(AppRoutes.eqrarSearch);
                              break;
                            case AppRoutes.endSearch:
                              Get.toNamed(AppRoutes.endSearch);
                              break;
                            case AppRoutes.taeenSearch:
                              Get.toNamed(AppRoutes.taeenSearch);
                              break;
                            case AppRoutes.passportSearch:
                              Get.toNamed(AppRoutes.passportSearch);
                              break;
                          }
                        }),

                    // Add spacing between items
                    CustomPopupMenuButton(
                      buttonText: 'الموظفين و العاملين',
                      items: const [
                        PopupMenuItem(
                          value: AppRoutes.addEmployee,
                          child: Text("بيانات الوظائف الأساسية"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addEntedab,
                          child: Text("بيانات الانتداب"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.employeesKharijD,
                          child: Text("خارج الدوام"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addHasmiat,
                          child: Text("بيانات الحسم"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addMokhalfat,
                          child: Text("المخالفات"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addHoliday,
                          child: Text("بيانات الإجازات"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addDowra,
                          child: Text("دورة موظف"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addKashfTepy,
                          child: Text("طلب كشف طبي"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addMobashra,
                          child: Text("قرار مباشرة"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addEqrar,
                          child: Text("إقرار"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addTarqea,
                          child: Text("ترقية موظف"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addEnd,
                          child: Text("إنهاء خدمة"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addTaeen,
                          child: Text("تعيين و مباشرة"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addPassport,
                          child: Text("اقرار استلام جواز سفر"),
                        ),
                        PopupMenuItem(
                          value: AppRoutes.addTafweed,
                          child: Text("تفويض"),
                        ),
                      ],
                      onSelected: (page) {
                        switch (page) {
                          case AppRoutes.addTafweed:
                            Get.toNamed(AppRoutes.addTafweed);
                            break;
                          case AppRoutes.employeesKharijD:
                            Get.toNamed(AppRoutes.employeesKharijD);
                            break;
                          case AppRoutes.addEqrar:
                            Get.toNamed(AppRoutes.addEqrar);
                            break;
                          case AppRoutes.addMokhalfat:
                            Get.toNamed(AppRoutes.addMokhalfat);
                            break;
                          case AppRoutes.addDowra:
                            Get.toNamed(AppRoutes.addDowra);
                            break;
                          case AppRoutes.addKashfTepy:
                            Get.toNamed(AppRoutes.addKashfTepy);
                            break;
                          case AppRoutes.addHasmiat:
                            Get.toNamed(AppRoutes.addHasmiat);
                            break;
                          case AppRoutes.addMobashra:
                            Get.toNamed(AppRoutes.addMobashra);
                            break;
                          case AppRoutes.addEntedab:
                            Get.toNamed(AppRoutes.addEntedab);
                            break;
                          case AppRoutes.addHoliday:
                            Get.toNamed(AppRoutes.addHoliday);
                            break;
                          case AppRoutes.addTarqea:
                            Get.toNamed(AppRoutes.addTarqea);
                            break;
                          case AppRoutes.addEnd:
                            Get.toNamed(AppRoutes.addEnd);
                            break;
                          case AppRoutes.addTaeen:
                            Get.toNamed(AppRoutes.addTaeen);
                            break;
                          case AppRoutes.addPassport:
                            Get.toNamed(AppRoutes.addPassport);
                            break;
                          case AppRoutes.addEmployee:
                            Get.toNamed(AppRoutes.addEmployee);
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.expanded(flex: 1),
        ],
      ),
    );
  }
}
