import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/extensions/widget_extension.dart';
import 'package:personnel_management/feature/emp_dowra/presentation/controllers/emp_dowra_search_controller.dart';
import 'package:personnel_management/feature/emp_end/presentation/controllers/emp_end_search_controller.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_det_controller.dart';
import 'package:personnel_management/feature/emp_hasmiat/presentation/controllers/emp_hasmiat_search_controller.dart';
import 'package:personnel_management/feature/emp_holiday/presentation/controllers/emp_holiday_search_controller.dart';
import 'package:personnel_management/feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_search_controller.dart';
import 'package:personnel_management/feature/emp_mobashra/presentation/controllers/emp_mobashra_search_controller.dart';
import 'package:personnel_management/feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_search_controller.dart';
import 'package:personnel_management/feature/emp_taeen/presentation/controllers/emp_taeen_search_controller.dart';
import 'package:personnel_management/feature/emp_tarqea/presentation/controllers/emp_tarqea_search_controller.dart';
import 'package:personnel_management/feature/employee/presentation/controllers/employee_search_controller.dart';
import 'package:personnel_management/feature/passport/presentation/controllers/passport_search_controller.dart';
import 'package:personnel_management/feature/tafweed/presentation/controllers/tafweed_search_controller.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_controller.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_det_controller.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_search_controller.dart';
import '../../feature/emp_eqrar/presentation/controllers/emp_eqrar_search_controller.dart';
import '../../feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import '../../feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import '../../feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_det_controller.dart';
import '../../feature/emp_takleef/presentation/controllers/emp_takleef_search_controller.dart';
import '../widgets/custom_pop_up_menu_button.dart';

class BaseController extends GetxController {
  RxString page = "بيانات البلدية".obs;

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
                        // ClickableText(
                        //   text: 'التجهيز و الإعداد',
                        //   onTap: () {},
                        // ),
                        CustomPopupMenuButton(
                            buttonText: 'الترميز',
                            items: const [
                              PopupMenuItem(
                                value: AppRoutes.baladiaInfo,
                                child: Text('بيانات البلدية'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.nations,
                                child: Text('أنواع الجنسيات'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.badal,
                                child: Text('بدل الانتداب'),
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
                                child: Text('تصنيف الدول حسب فئات البدل'),
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
                              Get.toNamed(page);
                              switch (page) {
                                case AppRoutes.baladiaInfo:
                                  controller.setPage('بيانات البلدية');
                                  break;
                                case AppRoutes.nations:
                                  controller.setPage('أنواع الجنسيات');
                                  break;
                                case AppRoutes.badal:
                                  controller.setPage('بدل الانتداب');
                                  break;
                                case AppRoutes.dissents:
                                  controller.setPage('أنواع المخالفات');
                                  break;
                                case AppRoutes.jobs:
                                  controller.setPage('أنواع الوظائف');
                                  break;
                                case AppRoutes.parts:
                                  controller.setPage('أنواع الأقسام');
                                  break;
                                case AppRoutes.badalCountries:
                                  controller
                                      .setPage('تصنيف الدول حسب فئات البدل');
                                  break;
                                case AppRoutes.empDegrees:
                                  controller.setPage('سلم درجات الموظفين');
                                  break;
                                case AppRoutes.empDegreesWorker:
                                  controller.setPage('سلم درجات العمال');
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
                                value: AppRoutes.takleefSearch,
                                child: Text('الاستعلام عن خارج الدوام'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.hasmiatSearch,
                                child: Text('الاستعلام عن الحسميات'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mokhalfatSearch,
                                child: Text('الاستعلام عن المخالفات'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.holidaySearch,
                                child: Text('الاستعلام عن إجازة'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.dowraSearch,
                                child: Text('الاستعلام عن الدورات'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.kashfTepySearch,
                                child: Text('الاستعلام عن كشف طبي'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.mobashraSearch,
                                child: Text('الاستعلام عن مباشرة'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.eqrarSearch,
                                child: Text('الاستعلام عن إقرار'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tarqeaSearch,
                                child: Text('الاستعلام عن ترقية'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.endSearch,
                                child: Text('الاستعلام عن إنهاء خدمة'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.taeenSearch,
                                child: Text('الاستعلام عن قرار تعيين'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.passportSearch,
                                child: Text('الاستعلام عن إقرار جواز سفر'),
                              ),
                              PopupMenuItem(
                                value: AppRoutes.tafweedSearch,
                                child: Text('الاستعلام عن تفويض'),
                              ),
                            ],
                            onSelected: (page) {
                              Get.toNamed(page);
                              switch (page) {
                                case AppRoutes.employeeSearch:
                                  controller.setPage('الاستعلام عن موظف');
                                  Get.find<EmployeeSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.entedabSearch:
                                  controller.setPage('الاستعلام عن انتداب');
                                  Get.find<EmpEntedabSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.takleefSearch:
                                  controller
                                      .setPage('الاستعلام عن خارج الدوام');
                                  Get.find<EmpTakleefSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.hasmiatSearch:
                                  controller.setPage('الاستعلام عن الحسميات');
                                  Get.find<EmpHasmiatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mokhalfatSearch:
                                  controller.setPage('الاستعلام عن المخالفات');
                                  Get.find<EmpMokhalfatSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.holidaySearch:
                                  controller.setPage('الاستعلام عن إجازة');
                                  Get.find<EmpHolidaySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.dowraSearch:
                                  controller.setPage('الاستعلام عن الدورات');
                                  Get.find<EmpDowraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.kashfTepySearch:
                                  controller.setPage('الاستعلام عن كشف طبي');
                                  Get.find<EmpKashfTepySearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.mobashraSearch:
                                  controller.setPage('الاستعلام عن مباشرة');
                                  Get.find<EmpMobashraSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.eqrarSearch:
                                  controller.setPage('الاستعلام عن إقرار');
                                  Get.find<EmpEqrarSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tarqeaSearch:
                                  controller.setPage('الاستعلام عن ترقية');
                                  Get.find<EmpTarqeaSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.endSearch:
                                  controller.setPage('الاستعلام عن إنهاء خدمة');
                                  Get.find<EmpEndSearchController>().findAll();
                                  break;
                                case AppRoutes.taeenSearch:
                                  controller.setPage('الاستعلام عن قرار تعيين');
                                  Get.find<EmpTaeenSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.passportSearch:
                                  controller
                                      .setPage('الاستعلام عن إقرار جواز سفر');
                                  Get.find<PassportSearchController>()
                                      .findAll();
                                  break;
                                case AppRoutes.tafweedSearch:
                                  controller.setPage('الاستعلام عن تفويض');
                                  Get.find<TafweedSearchController>().findAll();
                                  break;
                              }
                            }),
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
                              value: AppRoutes.addTakleef,
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
                          onSelected: (page) async {
                            Get.toNamed(page);
                            switch (page) {
                              case AppRoutes.addEmployee:
                                controller.setPage("بيانات الوظائف الأساسية");
                                break;
                              case AppRoutes.addEntedab:
                                controller.setPage("بيانات الانتداب");
                                int nextId =
                                    await Get.find<EmpEntedabSearchController>()
                                        .getId();
                                Get.find<EmpEntedabDetController>()
                                    .entedabId
                                    .text = nextId.toString();
                                Get.find<EmpEntedabController>().id.text =
                                    nextId.toString();
                                break;
                              case AppRoutes.addTakleef:
                                controller.setPage("خارج الدوام");
                                break;
                              case AppRoutes.addHasmiat:
                                controller.setPage("بيانات الحسم");
                                int nextId =
                                    await Get.find<EmpHasmiatSearchController>()
                                        .getId();
                                Get.find<EmpHasmiatDetController>()
                                    .hasmId
                                    .text = nextId.toString();
                                Get.find<EmpHasmiatController>().id.text =
                                    nextId.toString();
                                break;
                              case AppRoutes.addMokhalfat:
                                controller.setPage("المخالفات");
                                int nextId = await Get.find<
                                        EmpMokhalfatSearchController>()
                                    .getId();
                                Get.find<EmpMokhalfatDetController>()
                                    .mokhalfaId
                                    .text = nextId.toString();
                                Get.find<EmpMokhalfatController>().id.text =
                                    nextId.toString();
                                break;
                              case AppRoutes.addHoliday:
                                controller.setPage("بيانات الإجازات");
                                break;
                              case AppRoutes.addDowra:
                                controller.setPage("دورة موظف");
                                break;
                              case AppRoutes.addKashfTepy:
                                controller.setPage("طلب كشف طبي");
                                break;
                              case AppRoutes.addMobashra:
                                controller.setPage("قرار مباشرة");
                                break;
                              case AppRoutes.addEqrar:
                                controller.setPage("إقرار");
                                break;
                              case AppRoutes.addTarqea:
                                controller.setPage("ترقية موظف");
                                break;
                              case AppRoutes.addEnd:
                                controller.setPage("إنهاء خدمة");
                                break;
                              case AppRoutes.addTaeen:
                                controller.setPage("تعيين و مباشرة");
                                break;
                              case AppRoutes.addPassport:
                                controller.setPage("اقرار استلام جواز سفر");
                                break;
                              case AppRoutes.addTafweed:
                                controller.setPage("تفويض");
                                break;
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
