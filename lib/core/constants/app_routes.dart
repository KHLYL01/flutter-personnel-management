import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../feature/emp_dowra/presentation/pages/add_dowra.dart';
import '../../feature/emp_dowra/presentation/pages/dowra_search.dart';
import '../../feature/emp_end/presentation/pages/add_end.dart';
import '../../feature/emp_end/presentation/pages/end_search.dart';
import '../../feature/emp_entedab/presentation/pages/add_entedab.dart';
import '../../feature/emp_entedab/presentation/pages/entedab_search.dart';
import '../../feature/emp_eqrar/presentation/pages/add_eqrar.dart';
import '../../feature/emp_eqrar/presentation/pages/eqrar_search.dart';
import '../../feature/emp_hasmiat/presentation/pages/add_hasmiat.dart';
import '../../feature/emp_hasmiat/presentation/pages/hasmiat_search.dart';
import '../../feature/emp_holiday/presentation/pages/add_holiday.dart';
import '../../feature/emp_holiday/presentation/pages/holiday_search.dart';
import '../../feature/emp_kashf_tepy/presentation/pages/add_kashf_tepy.dart';
import '../../feature/emp_kashf_tepy/presentation/pages/kashf_tepy_search.dart';
import '../../feature/emp_mobashra/presentation/pages/add_mobashra.dart';
import '../../feature/emp_mobashra/presentation/pages/mobashra_search.dart';
import '../../feature/emp_mokhalfat/presentation/pages/add_mokhalfat.dart';
import '../../feature/emp_mokhalfat/presentation/pages/mokhalfat_search.dart';
import '../../feature/emp_taeen/presentation/pages/add_taeen.dart';
import '../../feature/emp_taeen/presentation/pages/taeen_search.dart';
import '../../feature/emp_takleef/presentation/pages/add_takleef.dart';
import '../../feature/emp_takleef/presentation/pages/takleef_search.dart';
import '../../feature/emp_tarqea/presentation/pages/add_tarqea.dart';
import '../../feature/emp_tarqea/presentation/pages/tarqea_search.dart';
import '../../feature/employee/presentation/pages/add_employee.dart';
import '../../feature/employee/presentation/pages/employee_search.dart';
import '../../feature/employee/presentation/pages/mosaeer_salary.dart';
import '../../feature/passport/presentation/pages/add_passport.dart';
import '../../feature/passport/presentation/pages/passport_search.dart';
import '../../feature/tafweed/presentation/pages/add_tafweed.dart';
import '../../feature/tafweed/presentation/pages/tafweed_search.dart';
import '../../feature/tarmeez_badal/presentation/pages/badal_page.dart';
import '../../feature/tarmeez_badal_countries/presentation/pages/badal_countries_page.dart';
import '../../feature/tarmeez_bladia_info/presentation/pages/baladia_info.dart';
import '../../feature/tarmeez_dissent/presentation/pages/dissent_page.dart';
import '../../feature/tarmeez_emp_degrees/presentation/pages/emp_degrees_page.dart';
import '../../feature/tarmeez_emp_degrees_worker/presentation/pages/emp_degrees_worker_page.dart';
import '../../feature/tarmeez_jobs/presentation/pages/jobs_page.dart';
import '../../feature/tarmeez_nations/presentation/pages/nations_page.dart';
import '../../feature/tarmeez_parts/presentation/pages/parts_page.dart';

class AppRoutes {
  static const String baladiaInfo = '/';
  static const String nations = '/nations';
  static const String dissents = '/dissents';
  static const String jobs = '/jobs';
  static const String badalCountries = '/badal_countries';
  static const String badal = '/badal';
  static const String empDegrees = '/emp_degrees';
  static const String empDegreesWorker = '/emp_degrees_worker';
  static const String parts = '/parts';

  // search
  static const String dowraSearch = '/dowra_search';
  static const String endSearch = '/end_search';
  static const String entedabSearch = '/entedab_search';
  static const String hasmiatSearch = '/hasmiat_search';
  static const String holidaySearch = '/holiday_search';
  static const String kashfTepySearch = '/kashf_tepy_search';
  static const String mobashraSearch = '/mobashra_search';
  static const String mokhalfatSearch = '/mokhalfat_search';
  static const String takleefSearch = '/takleef_search';
  static const String taeenSearch = '/taeen_search';
  static const String tarqeaSearch = '/Tarqea_search';
  static const String passportSearch = '/passport_search';
  static const String tafweedSearch = '/tafweed_search';
  static const String employeeSearch = '/employee_search';
  static const String eqrarSearch = '/eqrar_search';

  //الموظفين والعاملين
  static const String addTafweed = '/add_tafweed';
  static const String addDowra = '/add_dowra';
  static const String addEnd = '/add_end';
  static const String addEntedab = '/add_entedab';
  static const String addEqrar = '/add_eqrar';
  static const String addHasmiat = '/add_hasmiat';
  static const String addHoliday = '/add_holiday';
  static const String addKashfTepy = '/add_kashf_tepy';
  static const String addMobashra = '/add_mobashra';
  static const String addMokhalfat = '/add_mokhalfat';
  static const String addTaeen = '/add_taeen';
  static const String addTarqea = '/add_tarqea';
  static const String addPassport = '/add_passport';
  static const String addTakleef = '/add_takleef';
  static const String addEmployee = '/add_employee';

  static const String mosaeerSalary = '/mosaeer_salary';

  static List<GetPage> routes = [
    GetPage(name: baladiaInfo, page: () => const BladiaInfo()),
    GetPage(name: nations, page: () => const NationsPage()),
    GetPage(name: dissents, page: () => const DissentPage()),
    GetPage(name: jobs, page: () => const JobsPage()),
    GetPage(name: badalCountries, page: () => const BadalCountriesPage()),
    GetPage(name: badal, page: () => const BadalPage()),
    GetPage(name: empDegrees, page: () => const EmpDegreesPage()),
    GetPage(name: empDegreesWorker, page: () => const EmpDegreesWorkerPage()),
    GetPage(name: parts, page: () => const PartsPage()),
    // search
    GetPage(name: AppRoutes.dowraSearch, page: () => const DowraSearch()),
    GetPage(name: AppRoutes.endSearch, page: () => const EndSearch()),
    GetPage(name: AppRoutes.entedabSearch, page: () => const EntedabSearch()),
    GetPage(name: AppRoutes.hasmiatSearch, page: () => const HasmiatSearch()),
    GetPage(name: AppRoutes.holidaySearch, page: () => const HolidaySearch()),
    GetPage(
        name: AppRoutes.kashfTepySearch, page: () => const KashfTepySearch()),
    GetPage(name: AppRoutes.mobashraSearch, page: () => const MobashraSearch()),
    GetPage(
        name: AppRoutes.mokhalfatSearch, page: () => const MokhalfatSearch()),
    GetPage(name: AppRoutes.takleefSearch, page: () => const TakleefSearch()),
    GetPage(name: AppRoutes.taeenSearch, page: () => const TaeenSearch()),
    GetPage(name: AppRoutes.tarqeaSearch, page: () => const TarqeaSearch()),
    GetPage(name: AppRoutes.passportSearch, page: () => const PassportSearch()),
    GetPage(name: AppRoutes.tafweedSearch, page: () => const TafweedSearch()),
    GetPage(
        name: AppRoutes.employeeSearch, page: () => const EmployeesSearch()),
    GetPage(name: AppRoutes.eqrarSearch, page: () => const EqrarSearch()),
    GetPage(name: AppRoutes.addTafweed, page: () => const AddTafweed()),
    GetPage(name: AppRoutes.addDowra, page: () => const AddDowra()),
    GetPage(name: AppRoutes.addEnd, page: () => const AddEnd()),
    GetPage(name: AppRoutes.addEntedab, page: () => const AddEntedab()),
    GetPage(name: AppRoutes.addEqrar, page: () => const AddEqrar()),
    GetPage(name: AppRoutes.addHasmiat, page: () => const AddHasmiat()),
    GetPage(name: AppRoutes.addHoliday, page: () => const AddHoliday()),
    GetPage(name: AppRoutes.addKashfTepy, page: () => const AddKashfTepy()),
    GetPage(name: AppRoutes.addMobashra, page: () => const AddMobashra()),
    GetPage(name: AppRoutes.addMokhalfat, page: () => const AddMokhalfat()),
    GetPage(name: AppRoutes.addTaeen, page: () => const AddTaeen()),
    GetPage(name: AppRoutes.addTarqea, page: () => const AddTarqea()),
    GetPage(name: AppRoutes.addPassport, page: () => const AddPassport()),
    GetPage(name: AppRoutes.addEmployee, page: () => const AddEmployee()),
    GetPage(name: AppRoutes.addTakleef, page: () => const AddTakleef()),
    GetPage(name: AppRoutes.mosaeerSalary, page: () => const MosaeerSalary()),
  ];
}
