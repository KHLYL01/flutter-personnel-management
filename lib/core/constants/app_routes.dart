import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../feature/actions/presentation/pages/actions_page.dart';
import '../../feature/banks/presentation/pages/banks_page.dart';
import '../../feature/emp_dowra/presentation/pages/add_dowra.dart';
import '../../feature/emp_dowra/presentation/pages/dowra_search.dart';
import '../../feature/emp_end/presentation/pages/add_end.dart';
import '../../feature/emp_end/presentation/pages/end_report.dart';
import '../../feature/emp_end/presentation/pages/end_search.dart';
import '../../feature/emp_entedab/presentation/pages/add_entedab.dart';
import '../../feature/emp_entedab/presentation/pages/entedab_report.dart';
import '../../feature/emp_entedab/presentation/pages/entedab_search.dart';
import '../../feature/emp_eqrar/presentation/pages/add_eqrar.dart';
import '../../feature/emp_eqrar/presentation/pages/eqrar_report.dart';
import '../../feature/emp_eqrar/presentation/pages/eqrar_search.dart';
import '../../feature/emp_hasmiat/presentation/pages/add_hasmiat.dart';
import '../../feature/emp_hasmiat/presentation/pages/hasmiat_report.dart';
import '../../feature/emp_hasmiat/presentation/pages/hasmiat_search.dart';
import '../../feature/emp_holiday/presentation/pages/add_holiday.dart';
import '../../feature/emp_holiday/presentation/pages/holiday_report.dart';
import '../../feature/emp_holiday/presentation/pages/holiday_search.dart';
import '../../feature/emp_holiday/presentation/pages/holiday_type.dart';
import '../../feature/emp_kashf_tepy/presentation/pages/add_kashf_tepy.dart';
import '../../feature/emp_kashf_tepy/presentation/pages/kashf_tepy_report.dart';
import '../../feature/emp_kashf_tepy/presentation/pages/kashf_tepy_search.dart';
import '../../feature/emp_mobashra/presentation/pages/add_mobashra.dart';
import '../../feature/emp_mobashra/presentation/pages/mobashra_report.dart';
import '../../feature/emp_mobashra/presentation/pages/mobashra_search.dart';
import '../../feature/emp_mokhalfat/presentation/pages/add_mokhalfat.dart';
import '../../feature/emp_mokhalfat/presentation/pages/mokhalfat_report.dart';
import '../../feature/emp_mokhalfat/presentation/pages/mokhalfat_search.dart';
import '../../feature/emp_taeen/presentation/pages/add_taeen.dart';
import '../../feature/emp_taeen/presentation/pages/taeen_search.dart';
import '../../feature/emp_takleef/presentation/pages/add_takleef.dart';
import '../../feature/emp_takleef/presentation/pages/takleef_report.dart';
import '../../feature/emp_takleef/presentation/pages/takleef_search.dart';
import '../../feature/emp_tarqea/presentation/pages/add_tarqea.dart';
import '../../feature/emp_tarqea/presentation/pages/tarqea_search.dart';
import '../../feature/employee/presentation/pages/add_employee.dart';
import '../../feature/employee/presentation/pages/employee_report.dart';
import '../../feature/employee/presentation/pages/employee_search.dart';
import '../../feature/employee/presentation/pages/mosaeer_salary.dart';
import '../../feature/passport/presentation/pages/add_passport.dart';
import '../../feature/passport/presentation/pages/passport_search.dart';
import '../../feature/pdf_viewer/presentation/pages/pdf_viewer_page.dart';
import '../../feature/tafweed/presentation/pages/add_tafweed.dart';
import '../../feature/tafweed/presentation/pages/tafweed_report.dart';
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
import '../../feature/user_signature/presentation/pages/signature_page.dart';
import '../../feature/users/presentation/pages/home_page.dart';
import '../../feature/users/presentation/pages/login_page.dart';
import '../../feature/users/presentation/pages/user_page.dart';
import '../middlewares/auth_middleware.dart';

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';

  // ترميز
  static const String baladiaInfo = '/baladiaInfo';
  static const String nations = '/nations';
  static const String dissents = '/dissents';
  static const String jobs = '/jobs';
  static const String badalCountries = '/badal_countries';
  static const String badal = '/badal';
  static const String empDegrees = '/emp_degrees';
  static const String empDegreesWorker = '/emp_degrees_worker';
  static const String parts = '/parts';
  static const String banks = '/banks';
  // static const String holidayType = '/holiday_type';

  // تجهيز و إعداد
  static const String users = '/users';
  static const String signatures = '/signatures';
  static const String actions = '/actions';

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
  static const String entedabReport = '/entedab_report';
  static const String endReport = '/end_report';
  static const String eqrarReport = '/eqrar_report';
  static const String hasmiatReport = '/hasmiat_report';
  static const String holidayReport = '/holiday_report';
  static const String kashfTepyReport = '/kashf_tepy_report';
  static const String mobashraReport = '/mobashra_report';
  static const String mokhalfatReport = '/mokhalfat_report';
  static const String takleefReport = '/takleef_report';
  static const String tafweedReport = '/tafweed_report';
  static const String employeeReport = '/employee_report';

  static const String pdfViewer = '/pdfViewer';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(
        name: home,
        page: () => const HomePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: baladiaInfo,
        page: () => const BladiaInfo(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: nations,
        page: () => const NationsPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: banks,
        page: () => const BanksPage(),
        middlewares: [AuthMiddleware()]),

    GetPage(
        name: dissents,
        page: () => const DissentPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: jobs,
        page: () => const JobsPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: badalCountries,
        page: () => const BadalCountriesPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: badal,
        page: () => const BadalPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: empDegrees,
        page: () => const EmpDegreesPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: empDegreesWorker,
        page: () => const EmpDegreesWorkerPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: parts,
        page: () => const PartsPage(),
        middlewares: [AuthMiddleware()]),
    // GetPage(
    //     name: holidayType,
    //     page: () => const HolidayTypePage(),
    //     middlewares: [AuthMiddleware()]),
    // search
    GetPage(
        name: AppRoutes.dowraSearch,
        page: () => const DowraSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.endSearch,
        page: () => const EndSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.entedabSearch,
        page: () => const EntedabSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.hasmiatSearch,
        page: () => const HasmiatSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.holidaySearch,
        page: () => const HolidaySearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.kashfTepySearch,
        page: () => const KashfTepySearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.mobashraSearch,
        page: () => const MobashraSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.mokhalfatSearch,
        page: () => const MokhalfatSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.takleefSearch,
        page: () => const TakleefSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.taeenSearch,
        page: () => const TaeenSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.tarqeaSearch,
        page: () => const TarqeaSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.passportSearch,
        page: () => const PassportSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.tafweedSearch,
        page: () => const TafweedSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.employeeSearch,
        page: () => const EmployeesSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.eqrarSearch,
        page: () => const EqrarSearch(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addTafweed,
        page: () => const AddTafweed(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addDowra,
        page: () => const AddDowra(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addEnd,
        page: () => const AddEnd(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addEntedab,
        page: () => const AddEntedab(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addEqrar,
        page: () => const AddEqrar(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addHasmiat,
        page: () => const AddHasmiat(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addHoliday,
        page: () => const AddHoliday(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addKashfTepy,
        page: () => const AddKashfTepy(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addMobashra,
        page: () => const AddMobashra(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addMokhalfat,
        page: () => const AddMokhalfat(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addTaeen,
        page: () => const AddTaeen(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addTarqea,
        page: () => const AddTarqea(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addPassport,
        page: () => const AddPassport(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addEmployee,
        page: () => const AddEmployee(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: AppRoutes.addTakleef,
        page: () => const AddTakleef(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: AppRoutes.mosaeerSalary,
      page: () => const MosaeerSalary(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.entedabReport,
      page: () => const EntedabReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.endReport,
      page: () => const EndReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.eqrarReport,
      page: () => const EqrarReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.hasmiatReport,
      page: () => const HasmiatReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.holidayReport,
      page: () => const HolidayReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.kashfTepyReport,
      page: () => const KashfTepyReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.mobashraReport,
      page: () => const MobashraReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.mokhalfatReport,
      page: () => const MokhalfatReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.takleefReport,
      page: () => const TakleefReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.tafweedReport,
      page: () => const TafweedReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.employeeReport,
      page: () => const EmployeeReport(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.users,
      page: () => const UserPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.pdfViewer,
      page: () => PdfViewerPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.signatures,
      page: () => const SignaturePage(),
      // middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: AppRoutes.actions,
      page: () => const ActionsPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
