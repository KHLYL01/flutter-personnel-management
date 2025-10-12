import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/actions/presentation/controllers/actions_controller.dart';
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
import '../constants/app_static.dart';
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
                              child: Text(AppStatic.map[AppRoutes.users] ?? ""),
                            ),
                            if (Get.find<UserController>().isAdmin)
                              PopupMenuItem(
                                value: AppRoutes.signatures,
                                child: Text(
                                    AppStatic.map[AppRoutes.signatures] ?? ""),
                              ),
                            PopupMenuItem(
                              value: AppRoutes.actions,
                              child:
                                  Text(AppStatic.map[AppRoutes.actions] ?? ""),
                            ),
                          ],
                          onSelected: (page) async {
                            switch (page) {
                              case AppRoutes.users:
                                await Get.find<UserController>().findAll();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.users] ?? "");
                                break;
                              case AppRoutes.signatures:
                                await Get.find<SignatureController>().findAll();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.signatures] ?? "");
                                break;

                              case AppRoutes.actions:
                                Get.find<ActionsController>().usernames.addAll(
                                    Get.find<UserController>().usersName);
                                Get.find<ActionsController>()
                                    .usernames
                                    .add("مدير النظام");
                                await Get.find<ActionsController>().findAll();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.actions] ?? "");
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
                                child: Text(
                                    AppStatic.map[AppRoutes.baladiaInfo] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.nations,
                                child: Text(
                                    AppStatic.map[AppRoutes.nations] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.badal,
                                child:
                                    Text(AppStatic.map[AppRoutes.badal] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.dissents,
                                child: Text(
                                    AppStatic.map[AppRoutes.dissents] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.jobs,
                                child:
                                    Text(AppStatic.map[AppRoutes.jobs] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.parts,
                                child:
                                    Text(AppStatic.map[AppRoutes.parts] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.badalCountries,
                                child: Text(
                                    AppStatic.map[AppRoutes.badalCountries] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.empDegrees,
                                child: Text(
                                    AppStatic.map[AppRoutes.empDegrees] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.empDegreesWorker,
                                child: Text(
                                    AppStatic.map[AppRoutes.empDegreesWorker] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.banks,
                                child:
                                    Text(AppStatic.map[AppRoutes.banks] ?? ""),
                              ),
                              // PopupMenuItem(
                              //   value: AppRoutes.holidayType,
                              //   child: Text(
                              //       AppStatic.map[AppRoutes.holidayType] ?? ""),
                              // ),
                            ],
                            onSelected: (page) {
                              controller.setPage(AppStatic.map[page] ?? "");
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
                              child: Text(
                                  AppStatic.map[AppRoutes.addEmployee] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEntedab,
                              child: Text(
                                  AppStatic.map[AppRoutes.addEntedab] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTakleef,
                              child: Text(
                                  AppStatic.map[AppRoutes.addTakleef] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addHasmiat,
                              child: Text(
                                  AppStatic.map[AppRoutes.addHasmiat] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addMokhalfat,
                              child: Text(
                                  AppStatic.map[AppRoutes.addMokhalfat] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addHoliday,
                              child: Text(
                                  AppStatic.map[AppRoutes.addHoliday] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addDowra,
                              child:
                                  Text(AppStatic.map[AppRoutes.addDowra] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addKashfTepy,
                              child: Text(
                                  AppStatic.map[AppRoutes.addKashfTepy] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addMobashra,
                              child: Text(
                                  AppStatic.map[AppRoutes.addMobashra] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEqrar,
                              child:
                                  Text(AppStatic.map[AppRoutes.addEqrar] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTarqea,
                              child: Text(
                                  AppStatic.map[AppRoutes.addTarqea] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addEnd,
                              child:
                                  Text(AppStatic.map[AppRoutes.addEnd] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTaeen,
                              child:
                                  Text(AppStatic.map[AppRoutes.addTaeen] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addPassport,
                              child: Text(
                                  AppStatic.map[AppRoutes.addPassport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.addTafweed,
                              child: Text(
                                  AppStatic.map[AppRoutes.addTafweed] ?? ""),
                            ),
                          ],
                          onSelected: (page) async {
                            switch (page) {
                              case AppRoutes.addEmployee:
                                await Get.find<EmployeeController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addEmployee] ?? "");
                                break;
                              case AppRoutes.addEntedab:
                                await Get.find<EmpEntedabController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addEntedab] ?? "");
                                break;
                              case AppRoutes.addTakleef:
                                await Get.find<EmpTakleefController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addTakleef] ?? "");
                                break;
                              case AppRoutes.addHasmiat:
                                await Get.find<EmpHasmiatController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addHasmiat] ?? "");
                                break;
                              case AppRoutes.addMokhalfat:
                                await Get.find<EmpMokhalfatController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addMokhalfat] ??
                                        "");
                                break;
                              case AppRoutes.addHoliday:
                                await Get.find<EmpHolidayController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addHoliday] ?? "");
                                break;
                              case AppRoutes.addDowra:
                                await Get.find<EmpDowraController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addDowra] ?? "");
                                break;
                              case AppRoutes.addKashfTepy:
                                await Get.find<EmpKashfTepyController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addKashfTepy] ??
                                        "");
                                break;
                              case AppRoutes.addMobashra:
                                await Get.find<EmpMobashraController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addMobashra] ?? "");
                                break;
                              case AppRoutes.addEqrar:
                                await Get.find<EmpEqrarController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addEqrar] ?? "");
                                break;
                              case AppRoutes.addTarqea:
                                await Get.find<EmpTarqeaController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addTarqea] ?? "");
                                break;
                              case AppRoutes.addEnd:
                                await Get.find<EmpEndController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addEnd] ?? "");
                                break;
                              case AppRoutes.addTaeen:
                                await Get.find<EmpTaeenController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addTaeen] ?? "");
                                break;
                              case AppRoutes.addPassport:
                                await Get.find<PassportController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addPassport] ?? "");
                                break;
                              case AppRoutes.addTafweed:
                                await Get.find<TafweedController>()
                                    .clearControllers();
                                controller.setPage(
                                    AppStatic.map[AppRoutes.addTafweed] ?? "");
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
                                child: Text(
                                    AppStatic.map[AppRoutes.employeeSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.entedabSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.entedabSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.takleefSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.takleefSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.hasmiatSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.hasmiatSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mokhalfatSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.mokhalfatSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.holidaySearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.holidaySearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.dowraSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.dowraSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.kashfTepySearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.kashfTepySearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mobashraSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.mobashraSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.eqrarSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.eqrarSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tarqeaSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.tarqeaSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.endSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.endSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.taeenSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.taeenSearch] ?? ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.passportSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.passportSearch] ??
                                        ""),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tafweedSearch,
                                child: Text(
                                    AppStatic.map[AppRoutes.tafweedSearch] ??
                                        ""),
                              ),
                            ],
                            onSelected: (page) {
                              switch (page) {
                                case AppRoutes.employeeSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.employeeSearch] ??
                                          "");
                                  Get.find<EmployeeSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.entedabSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.entedabSearch] ??
                                          "");
                                  Get.find<EmpEntedabSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.takleefSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.takleefSearch] ??
                                          "");
                                  Get.find<EmpTakleefSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.hasmiatSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.hasmiatSearch] ??
                                          "");
                                  Get.find<EmpHasmiatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mokhalfatSearch:
                                  controller.setPage(AppStatic
                                          .map[AppRoutes.mokhalfatSearch] ??
                                      "");
                                  Get.find<EmpMokhalfatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.holidaySearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.holidaySearch] ??
                                          "");
                                  Get.find<EmpHolidaySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.dowraSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.dowraSearch] ??
                                          "");
                                  Get.find<EmpDowraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.kashfTepySearch:
                                  controller.setPage(AppStatic
                                          .map[AppRoutes.kashfTepySearch] ??
                                      "");
                                  Get.find<EmpKashfTepySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mobashraSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.mobashraSearch] ??
                                          "");
                                  Get.find<EmpMobashraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.eqrarSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.eqrarSearch] ??
                                          "");
                                  Get.find<EmpEqrarSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tarqeaSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.tarqeaSearch] ??
                                          "");
                                  Get.find<EmpTarqeaSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.endSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.endSearch] ?? "");
                                  Get.find<EmpEndSearchController>().findAll();
                                  break;
                                case AppRoutes.taeenSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.taeenSearch] ??
                                          "");
                                  Get.find<EmpTaeenSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.passportSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.passportSearch] ??
                                          "");
                                  Get.find<PassportSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tafweedSearch:
                                  controller.setPage(
                                      AppStatic.map[AppRoutes.tafweedSearch] ??
                                          "");
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
                              child: Text(
                                  AppStatic.map[AppRoutes.mosaeerSalary] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.entedabReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.entedabReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.takleefReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.takleefReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.hasmiatReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.hasmiatReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.mokhalfatReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.mokhalfatReport] ??
                                      ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.holidayReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.holidayReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.kashfTepyReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.kashfTepyReport] ??
                                      ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.mobashraReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.mobashraReport] ??
                                      ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.employeeReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.employeeReport] ??
                                      ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.tafweedReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.tafweedReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.endReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.endReport] ?? ""),
                            ),
                            PopupMenuItem(
                              value: AppRoutes.eqrarReport,
                              child: Text(
                                  AppStatic.map[AppRoutes.eqrarReport] ?? ""),
                            ),
                          ],
                          onSelected: (page) async {
                            controller.setPage(AppStatic.map[page] ?? "");
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
