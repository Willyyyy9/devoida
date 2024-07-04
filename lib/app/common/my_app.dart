import 'package:devoida/app/modules/splash/bindings/splash_binding.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/theme_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MyApp extends StatefulWidget {
  // named constructor
  const MyApp._internal();
  static const MyApp _instance =
      MyApp._internal(); // singleton or single instance
  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // routeInformationParser: AppPages.goRoute.routeInformationParser,
      // routeInformationProvider: AppPages.goRoute.routeInformationProvider,
      // routerDelegate: AppPages.goRoute.routerDelegate,
      title: AppStrings.devoida,
      initialRoute: AppPages.INITIAL,
      initialBinding: SplashBinding(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      builder: EasyLoading.init(),
      scrollBehavior: AppScrollBehavior(),
      defaultTransition: Transition.noTransition,
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
