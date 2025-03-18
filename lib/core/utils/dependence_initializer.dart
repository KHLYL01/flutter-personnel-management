import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../feature/tarmeez_badal/data/repository/badal_repository.dart';
import '../../feature/tarmeez_badal/presentation/controllers/badal_controller.dart';
import '../../feature/tarmeez_badal_countries/data/repository/badal_countries_repository.dart';
import '../../feature/tarmeez_badal_countries/presentation/controllers/badal_countries_controller.dart';
import '../../feature/tarmeez_bladia_info/data/repository/bladia_info_repository.dart';
import '../../feature/tarmeez_bladia_info/presentation/controllers/bladia_info_controller.dart';
import '../../feature/tarmeez_dissent/data/repository/dissent_repository.dart';
import '../../feature/tarmeez_dissent/presentation/controllers/dissent_controller.dart';
import '../../feature/tarmeez_emp_degrees/data/repository/emp_degrees_repository.dart';
import '../../feature/tarmeez_emp_degrees/presentation/controllers/emp_degrees_controller.dart';
import '../../feature/tarmeez_jobs/data/repository/jobs_repository.dart';
import '../../feature/tarmeez_jobs/presentation/controllers/jobs_controller.dart';
import '../../feature/tarmeez_nations/data/repository/nations_repository.dart';
import '../../feature/tarmeez_nations/presentation/controllers/nations_controller.dart';
import '../../feature/tarmeez_parts/data/repository/parts_repository.dart';
import '../../feature/tarmeez_parts/presentation/controllers/parts_controller.dart';
import '../network/api_service.dart';

class DependenceInitializer {
  static dependenceInjection() {
    // Dio DI
    Get.lazyPut<Dio>(() => Dio(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(Get.find()));

    // Bladia Info DI
    Get.lazyPut(() => BladiaInfoRepository(Get.find()));
    Get.put(BladiaInfoController(Get.find()));

    // Nations DI
    Get.lazyPut(() => NationsRepository(Get.find()));
    Get.put(NationsController(Get.find()));

    // Badal DI
    Get.lazyPut(() => BadalRepository(Get.find()));
    Get.put(BadalController(Get.find()));

    // Jobs DI
    Get.lazyPut(() => JobsRepository(Get.find()));
    Get.put(JobsController(Get.find()));

    // Parts DI
    Get.lazyPut(() => PartsRepository(Get.find()));
    Get.put(PartsController(Get.find()));

    // BadalCountries DI
    Get.lazyPut(() => BadalCountriesRepository(Get.find()));
    Get.put(BadalCountriesController(Get.find()));

    // Dissent DI
    Get.lazyPut(() => DissentRepository(Get.find()));
    Get.put(DissentController(Get.find()));

    // EmpDegrees DI
    Get.lazyPut(() => EmpDegreesRepository(Get.find()));
    Get.put(EmpDegreesController(Get.find()));
  }
}
