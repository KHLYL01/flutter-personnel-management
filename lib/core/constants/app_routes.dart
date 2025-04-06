import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../feature/tarmeez_badal/presentation/pages/badal_page.dart';
import '../../feature/tarmeez_badal_countries/presentation/pages/badal_countries_page.dart';
import '../../feature/tarmeez_bladia_info/presentation/pages/baladia_info.dart';
import '../../feature/tarmeez_dissent/presentation/pages/dissent_page.dart';
import '../../feature/tarmeez_emp_degrees/presentation/pages/emp_degrees_page.dart';
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
  static const String parts = '/parts';

  //هظول مش للترميز
  static const String tafweed = '/tafweed';
  static const String beanatWazaefAsasea = '/beanat_wazaef_asasea';

  static List<GetPage> routes = [
    GetPage(
      name: baladiaInfo,
      page: () => const BladiaInfo(),
    ),
    GetPage(
      name: nations,
      page: () => const NationsPage(),
    ),
    GetPage(
      name: dissents,
      page: () => const DissentPage(),
    ),
    GetPage(
      name: jobs,
      page: () => const JobsPage(),
    ),
    GetPage(
      name: badalCountries,
      page: () => const BadalCountriesPage(),
    ),
    GetPage(
      name: badal,
      page: () => const BadalPage(),
    ),
    GetPage(
      name: empDegrees,
      page: () => const EmpDegreesPage(),
    ),
    GetPage(
      name: parts,
      page: () => const PartsPage(),
    ),
    // //هظول مش للترميز
    // GetPage(
    //   name: AppRoutes.tafweed,
    //   page: () => const Tafweed(),
    // ),
    // GetPage(
    //   name: AppRoutes.beanatWazaefAsasea,
    //   page: () => const BeanatWazaefAsasea(),
    // ),
  ];
}
