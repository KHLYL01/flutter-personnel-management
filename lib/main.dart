import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:personnel_management/core/utils/dependence_initializer.dart';

import 'core/constants/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependenceInitializer.dependenceInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar', 'AE')],
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      getPages: AppRoutes.routes,
    );
  }
}
