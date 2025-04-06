import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../feature/emp_dowra/data/repository/emp_dowra_repository.dart';
import '../../feature/emp_dowra/presentation/controllers/emp_dowra_controller.dart';
import '../../feature/emp_end/data/repository/emp_end_repository.dart';
import '../../feature/emp_end/presentation/controllers/emp_end_controller.dart';
import '../../feature/emp_entedab/data/repository/emp_entedab_repository.dart';
import '../../feature/emp_entedab/presentation/controllers/emp_entedab_controller.dart';
import '../../feature/emp_hasmiat/data/repository/emp_hasmiat_repository.dart';
import '../../feature/emp_hasmiat/presentation/controllers/emp_hasmiat_controller.dart';
import '../../feature/emp_holiday/data/repository/emp_holiday_repository.dart';
import '../../feature/emp_holiday/presentation/controllers/emp_holiday_controller.dart';
import '../../feature/emp_kashf_tepy/data/repository/emp_kashf_tepy_repository.dart';
import '../../feature/emp_kashf_tepy/presentation/controllers/emp_kashf_tepy_controller.dart';
import '../../feature/emp_mobashra/data/repository/emp_mobashra_repository.dart';
import '../../feature/emp_mobashra/presentation/controllers/emp_mobashra_controller.dart';
import '../../feature/emp_mokhalfat/data/repository/emp_mokhalfat_repository.dart';
import '../../feature/emp_mokhalfat/presentation/controllers/emp_mokhalfat_controller.dart';
import '../../feature/emp_overtime/data/repository/emp_overtime_repository.dart';
import '../../feature/emp_overtime/presentation/controllers/emp_overtime_controller.dart';
import '../../feature/emp_taeen/data/repository/emp_taeen_repository.dart';
import '../../feature/emp_taeen/presentation/controllers/emp_taeen_controller.dart';
import '../../feature/emp_tarqea/data/repository/emp_tarqea_repository.dart';
import '../../feature/emp_tarqea/presentation/controllers/emp_tarqea_controller.dart';
import '../../feature/passport/data/repository/passport_repository.dart';
import '../../feature/passport/presentation/controllers/passport_controller.dart';
import '../../feature/tafweed/data/repository/tafweed_repository.dart';
import '../../feature/tafweed/presentation/controllers/tafweed_controller.dart';
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

    // EmpDowra DI
    Get.lazyPut(() => EmpDowraRepository(Get.find()));
    Get.put(EmpDowraController(Get.find()));

    // EmpEnd DI
    Get.lazyPut(() => EmpEndRepository(Get.find()));
    Get.put(EmpEndController(Get.find()));

    // EmpEntedab DI
    Get.lazyPut(() => EmpEntedabRepository(Get.find()));
    Get.put(EmpEntedabController(Get.find()));

    // EmpHasmiat DI
    Get.lazyPut(() => EmpHasmiatRepository(Get.find()));
    Get.put(EmpHasmiatController(Get.find()));

    // EmpHoliday DI
    Get.lazyPut(() => EmpHolidayRepository(Get.find()));
    Get.put(EmpHolidayController(Get.find()));

    // EmpKashfTepy DI
    Get.lazyPut(() => EmpKashfTepyRepository(Get.find()));
    Get.put(EmpKashfTepyController(Get.find()));

    // EmpMobashra DI
    Get.lazyPut(() => EmpMobashraRepository(Get.find()));
    Get.put(EmpMobashraController(Get.find()));

    // EmpMokhalfat DI
    Get.lazyPut(() => EmpMokhalfatRepository(Get.find()));
    Get.put(EmpMokhalfatController(Get.find()));

    // EmpOvertime DI
    Get.lazyPut(() => EmpOvertimeRepository(Get.find()));
    Get.put(EmpOvertimeController(Get.find()));

    // EmpTaeen DI
    Get.lazyPut(() => EmpTaeenRepository(Get.find()));
    Get.put(EmpTaeenController(Get.find()));

    // EmpTarqea DI
    Get.lazyPut(() => EmpTarqeaRepository(Get.find()));
    Get.put(EmpTarqeaController(Get.find()));

    // Passport DI
    Get.lazyPut(() => PassportRepository(Get.find()));
    Get.put(PassportController(Get.find()));

    // Tafweed DI
    Get.lazyPut(() => TafweedRepository(Get.find()));
    Get.put(TafweedController(Get.find()));
  }
}
