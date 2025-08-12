import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/controllers/emp_dowra_controller.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/controllers/emp_dowra_search_controller.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_controller.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_controller.dart';
import 'package:personnel_management/feature/emp_eqrar/presentation/controllers/emp_eqrar_controller.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_search_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_search_controller.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_controller.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_search_controller.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_search_controller.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_search_controller.dart';
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_controller.dart';
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_search_controller.dart';
import 'package:personnel_management/feature/emp_takleef/presentation/controllers/emp_takleef_controller.dart';
import 'package:personnel_management/feature/emp_tarqea/presentation/controllers/emp_tarqea_controller.dart';
import 'package:personnel_management/feature/emp_tarqea/presentation/controllers/emp_tarqea_search_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_controller.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_search_controller.dart';
import 'package:personnel_management/feature/tafweed/presentation/controllers/tafweed_controller.dart';
import 'package:personnel_management/feature/tafweed/presentation/controllers/tafweed_search_controller.dart';
import 'package:personnel_management/feature/user_signature/presentation/controllers/signature_controller.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_controller.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_search_controller.dart';
import '../../feature/emp_eqrar/presentation/controllers/emp_eqrar_search_controller.dart';
import '../../feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import '../../feature/emp_mobashra/presentation/controllers/emp_mobashra_controller.dart';
import '../../feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import '../../feature/emp_takleef/presentation/controllers/emp_takleef_search_controller.dart';
import '../../feature/users/presentation/controllers/user_controller.dart';
import '../functions/alert_dialog.dart';
import '../widgets/custom_pop_up_menu_button.dart';

class BaseController extends GetxController {
  RxString page = "".obs;

  void setPage(String p) {
    page(p);
  }
}

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    Map<String, String> map = {
      "/baladiaInfo": "بيانات البلدية",
      "/nations": "انواع الجنسيات",
      "/dissents": "أنواع المخالفات",
      "/jobs": "أنواع الوظائف",
      "/badal_countries": "تصنيف الدول حسب فئات البدل",
      "/badal": "بدل الانتداب",
      "/emp_degrees": "سلم درجات الموظفين",
      "/emp_degrees_worker": "سلم درجات العمال",
      "/parts": "أنواع الأقسام",
      "/users": "المستخدمين",
      "/signatures": "إدارة التوقيعات",
      "/dowra_search": "الإستعلام عن الدورات",
      "/end_search": "الاستعلام عن إنهاء خدمة",
      "/entedab_search": "الإستعلام عن إنتداب",
      "/hasmiat_search": "الإستعلام عن حسميات",
      "/holiday_search": "الإستعلام عن إجازة",
      "/kashf_tepy_search": "الإستعلام عن كشف طبي",
      "/mobashra_search": "الإستعلام عن مباشرة",
      "/mokhalfat_search": "الإستعلام عن مخالفات",
      "/takleef_search": "الإستعلام عن خارح دوام",
      "/taeen_search": "الاستعلام عن قرار تعيين",
      "/Tarqea_search": "الاستعلام عن ترقية",
      "/passport_search": "الاستعلام عن إقرار جواز سفر",
      "/tafweed_search": "الاستعلام عن تفويض",
      "/employee_search": "الإستعلام عن موظف",
      "/eqrar_search": "الاستعلام عن إقرار",
      "/add_tafweed": "تفويض",
      "/add_dowra": "بيان دورة موظف",
      "/add_end": "إنهاء خدمة",
      "/add_entedab": "بيانات الإنتداب",
      "/add_eqrar": "إقرار موظف",
      "/add_hasmiat": "بيانات الحسميات",
      "/add_holiday": "بيانات الإجازات",
      "/add_kashf_tepy": "طلب كشف طبي",
      "/add_mobashra": "قرار مباشرة",
      "/add_mokhalfat": "بيانات المخالفات",
      "/add_taeen": "قرار تعيين",
      "/add_tarqea": "ترقية موظف",
      "/add_passport": "إقرار استلام جواز سفر",
      "/add_takleef": "بيانات خارح دوام",
      "/add_employee": "بيانات الوظائف الأساسية",
      "/mosaeer_salary": "مسير الرواتب",
    };

    final controller = Get.put(BaseController());
    final userController = Get.find<UserController>();
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
                width: context.width,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomPopupMenuButton(
                          buttonText: 'التجهيز و الإعداد',
                          items: [
                            PopupMenuItem(
                              value: AppRoutes.users,
                              child: Text(map[AppRoutes.users] ?? ""),
                            ),
                            if (Get.find<UserController>().isAdmin)
                              PopupMenuItem(
                                value: AppRoutes.signatures,
                                child: Text(map[AppRoutes.signatures] ?? ""),
                              ),
                          ],
                          onSelected: (page) async {
                            switch (page) {
                              case AppRoutes.users:
                                await Get.find<UserController>().findAll();
                                controller.setPage(map[AppRoutes.users] ?? "");
                                break;
                              case AppRoutes.signatures:
                                await Get.find<SignatureController>().findAll();
                                controller
                                    .setPage(map[AppRoutes.signatures] ?? "");
                                break;
                            }
                            if (userController.checkPermission(
                                    controller.page.value,
                                    enter: true) ||
                                userController.isAdmin) {
                              Get.toNamed(page);
                            } else {
                              alertDialog(
                                title: 'تنبيه',
                                middleText:
                                    "       ليس لديك صلاحية لفتح هذة النافذة       ",
                                withoutButton: true,
                                onPressedConfirm: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        ),
                        CustomPopupMenuButton(
                            buttonText: 'الترميز',
                            items: [
                              PopupMenuItem(
                                value: AppRoutes.baladiaInfo,
                                child: Text(map[AppRoutes.baladiaInfo] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.nations,
                                child: Text(map[AppRoutes.nations] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.badal,
                                child: Text(map[AppRoutes.badal] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.dissents,
                                child: Text(map[AppRoutes.dissents] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.jobs,
                                child: Text(map[AppRoutes.jobs] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.parts,
                                child: Text(map[AppRoutes.parts] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.badalCountries,
                                child:
                                    Text(map[AppRoutes.badalCountries] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.empDegrees,
                                child: Text(map[AppRoutes.empDegrees] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.empDegreesWorker,
                                child:
                                    Text(map[AppRoutes.empDegreesWorker] ?? ""),
                              ),
                            ],
                            onSelected: (page) {
                              controller.setPage(map[page] ?? "");
                              if (userController.checkPermission(
                                  controller.page.value,
                                  enter: true)) {
                                Get.toNamed(page);
                              } else {
                                alertDialog(
                                  title: 'تنبيه',
                                  middleText:
                                      "       ليس لديك صلاحية لفتح هذة النافذة       ",
                                  withoutButton: true,
                                  onPressedConfirm: () {
                                    Get.back();
                                  },
                                );
                              }
                            }),
                        CustomPopupMenuButton(
                          buttonText: 'الموظفين و العاملين',
                          items: [
                            PopupMenuItem(
                              value: AppRoutes.addEmployee,
                              child: Text(map[AppRoutes.addEmployee] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEntedab,
                              child: Text(map[AppRoutes.addEntedab] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTakleef,
                              child: Text(map[AppRoutes.addTakleef] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addHasmiat,
                              child: Text(map[AppRoutes.addHasmiat] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addMokhalfat,
                              child: Text(map[AppRoutes.addMokhalfat] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addHoliday,
                              child: Text(map[AppRoutes.addHoliday] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addDowra,
                              child: Text(map[AppRoutes.addDowra] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addKashfTepy,
                              child: Text(map[AppRoutes.addKashfTepy] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addMobashra,
                              child: Text(map[AppRoutes.addMobashra] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEqrar,
                              child: Text(map[AppRoutes.addEqrar] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTarqea,
                              child: Text(map[AppRoutes.addTarqea] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEnd,
                              child: Text(map[AppRoutes.addEnd] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTaeen,
                              child: Text(map[AppRoutes.addTaeen] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addPassport,
                              child: Text(map[AppRoutes.addPassport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTafweed,
                              child: Text(map[AppRoutes.addTafweed] ?? ""),
                            ),
                          ],
                          onSelected: (page) async {
                            switch (page) {
                              case AppRoutes.addEmployee:
                                await Get.find<EmployeeController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addEmployee] ?? "");
                                break;
                              case AppRoutes.addEntedab:
                                await Get.find<EmpEntedabController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addEntedab] ?? "");
                                break;
                              case AppRoutes.addTakleef:
                                await Get.find<EmpTakleefController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addTakleef] ?? "");
                                break;
                              case AppRoutes.addHasmiat:
                                await Get.find<EmpHasmiatController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addHasmiat] ?? "");
                                break;
                              case AppRoutes.addMokhalfat:
                                await Get.find<EmpMokhalfatController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addMokhalfat] ?? "");
                                break;
                              case AppRoutes.addHoliday:
                                await Get.find<EmpHolidayController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addHoliday] ?? "");
                                break;
                              case AppRoutes.addDowra:
                                await Get.find<EmpDowraController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addDowra] ?? "");
                                break;
                              case AppRoutes.addKashfTepy:
                                await Get.find<EmpKashfTepyController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addKashfTepy] ?? "");
                                break;
                              case AppRoutes.addMobashra:
                                await Get.find<EmpMobashraController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addMobashra] ?? "");
                                break;
                              case AppRoutes.addEqrar:
                                await Get.find<EmpEqrarController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addEqrar] ?? "");
                                break;
                              case AppRoutes.addTarqea:
                                await Get.find<EmpTarqeaController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addTarqea] ?? "");
                                break;
                              case AppRoutes.addEnd:
                                await Get.find<EmpEndController>()
                                    .clearControllers();
                                controller.setPage(map[AppRoutes.addEnd] ?? "");
                                break;
                              case AppRoutes.addTaeen:
                                await Get.find<EmpTaeenController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addTaeen] ?? "");
                                break;
                              case AppRoutes.addPassport:
                                await Get.find<PassportController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addPassport] ?? "");
                                break;
                              case AppRoutes.addTafweed:
                                await Get.find<TafweedController>()
                                    .clearControllers();
                                controller
                                    .setPage(map[AppRoutes.addTafweed] ?? "");
                                break;
                            }
                            if (userController.checkPermission(
                                controller.page.value,
                                enter: true)) {
                              Get.toNamed(page);
                            } else {
                              alertDialog(
                                title: 'تنبيه',
                                middleText:
                                    "       ليس لديك صلاحية لفتح هذة النافذة       ",
                                withoutButton: true,
                                onPressedConfirm: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        ),
                        CustomPopupMenuButton(
                            buttonText: 'البحث و الإستعلام',
                            items: [
                              PopupMenuItem(
                                value: AppRoutes.employeeSearch,
                                child:
                                    Text(map[AppRoutes.employeeSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.entedabSearch,
                                child: Text(map[AppRoutes.entedabSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.takleefSearch,
                                child: Text(map[AppRoutes.takleefSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.hasmiatSearch,
                                child: Text(map[AppRoutes.hasmiatSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mokhalfatSearch,
                                child:
                                    Text(map[AppRoutes.mokhalfatSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.holidaySearch,
                                child: Text(map[AppRoutes.holidaySearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.dowraSearch,
                                child: Text(map[AppRoutes.dowraSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.kashfTepySearch,
                                child:
                                    Text(map[AppRoutes.kashfTepySearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mobashraSearch,
                                child:
                                    Text(map[AppRoutes.mobashraSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.eqrarSearch,
                                child: Text(map[AppRoutes.eqrarSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tarqeaSearch,
                                child: Text(map[AppRoutes.tarqeaSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.endSearch,
                                child: Text(map[AppRoutes.endSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.taeenSearch,
                                child: Text(map[AppRoutes.taeenSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.passportSearch,
                                child:
                                    Text(map[AppRoutes.passportSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tafweedSearch,
                                child: Text(map[AppRoutes.tafweedSearch] ?? ""),
                              ),
                            ],
                            onSelected: (page) {
                              switch (page) {
                                case AppRoutes.employeeSearch:
                                  controller.setPage(
                                      map[AppRoutes.employeeSearch] ?? "");
                                  Get.find<EmployeeSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.entedabSearch:
                                  controller.setPage(
                                      map[AppRoutes.entedabSearch] ?? "");
                                  Get.find<EmpEntedabSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.takleefSearch:
                                  controller.setPage(
                                      map[AppRoutes.takleefSearch] ?? "");
                                  Get.find<EmpTakleefSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.hasmiatSearch:
                                  controller.setPage(
                                      map[AppRoutes.hasmiatSearch] ?? "");
                                  Get.find<EmpHasmiatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mokhalfatSearch:
                                  controller.setPage(
                                      map[AppRoutes.mokhalfatSearch] ?? "");
                                  Get.find<EmpMokhalfatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.holidaySearch:
                                  controller.setPage(
                                      map[AppRoutes.holidaySearch] ?? "");
                                  Get.find<EmpHolidaySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.dowraSearch:
                                  controller.setPage(
                                      map[AppRoutes.dowraSearch] ?? "");
                                  Get.find<EmpDowraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.kashfTepySearch:
                                  controller.setPage(
                                      map[AppRoutes.kashfTepySearch] ?? "");
                                  Get.find<EmpKashfTepySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mobashraSearch:
                                  controller.setPage(
                                      map[AppRoutes.mobashraSearch] ?? "");
                                  Get.find<EmpMobashraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.eqrarSearch:
                                  controller.setPage(
                                      map[AppRoutes.eqrarSearch] ?? "");
                                  Get.find<EmpEqrarSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tarqeaSearch:
                                  controller.setPage(
                                      map[AppRoutes.tarqeaSearch] ?? "");
                                  Get.find<EmpTarqeaSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.endSearch:
                                  controller
                                      .setPage(map[AppRoutes.endSearch] ?? "");
                                  Get.find<EmpEndSearchController>().findAll();
                                  break;
                                case AppRoutes.taeenSearch:
                                  controller.setPage(
                                      map[AppRoutes.taeenSearch] ?? "");
                                  Get.find<EmpTaeenSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.passportSearch:
                                  controller.setPage(
                                      map[AppRoutes.passportSearch] ?? "");
                                  Get.find<PassportSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tafweedSearch:
                                  controller.setPage(
                                      map[AppRoutes.tafweedSearch] ?? "");
                                  Get.find<TafweedSearchController>().findAll();
                                  break;
                              }
                              if (userController.checkPermission(
                                  controller.page.value,
                                  enter: true)) {
                                Get.toNamed(page);
                              } else {
                                alertDialog(
                                  title: 'تنبيه',
                                  middleText:
                                      "       ليس لديك صلاحية لفتح هذة النافذة       ",
                                  withoutButton: true,
                                  onPressedConfirm: () {
                                    Get.back();
                                  },
                                );
                              }
                            }),
                        CustomPopupMenuButton(
                          buttonText: 'التقارير و الطباعة',
                          items: [
                            PopupMenuItem(
                              value: AppRoutes.mosaeerSalary,
                              child: Text(map[AppRoutes.mosaeerSalary] ?? ""),
                            ),
                          ],
                          onSelected: (page) async {
                            switch (page) {
                              case AppRoutes.mosaeerSalary:
                                // await Get.find<EmployeeController>()
                                //     .clearControllers();
                                controller.setPage(
                                    map[AppRoutes.mosaeerSalary] ?? "");
                                break;
                            }
                            if (userController.checkPermission(
                                controller.page.value,
                                enter: true)) {
                              Get.toNamed(page);
                            } else {
                              alertDialog(
                                title: 'تنبيه',
                                middleText:
                                    "       ليس لديك صلاحية لفتح هذة النافذة       ",
                                withoutButton: true,
                                onPressedConfirm: () {
                                  Get.back();
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Obx(
                      () => Text(
                        controller.page.value,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      )
                          .align(alignment: Alignment.centerLeft)
                          .paddingOnly(left: 64),
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
