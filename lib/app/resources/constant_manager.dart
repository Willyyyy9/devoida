import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppConstants {
  static void configureLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..successWidget = Icon(
        FontAwesomeIcons.circleCheck,
        color: ColorManager.success,
        size: AppSize.s45,
      )
      ..errorWidget = Icon(
        FontAwesomeIcons.circleExclamation,
        color: ColorManager.error,
        size: AppSize.s45,
      )
      ..indicatorSize = AppSize.s45
      ..radius = AppSize.s10
      ..progressColor = ColorManager.white
      ..progressWidth = AppSize.s0_5
      ..backgroundColor = ColorManager.black.withOpacity(AppSize.s0_8)
      ..indicatorColor = ColorManager.white
      ..textColor = ColorManager.white
      ..maskColor = ColorManager.black.withOpacity(AppSize.s0_5)
      ..userInteractions = true
      ..fontSize = FontSize.s18
      ..textPadding = const EdgeInsets.symmetric(vertical: AppSize.s28)
      ..textStyle =
          getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16)
      ..dismissOnTap = false;
  }

  static List<String> teams = [
    "Software",
    "Sales",
    "Marketing",
    "Operations",
    "Customer Success",
  ];
  static List<String> projectStatuses = [
    AttributeString.statusNew,
    AttributeString.statusInProgress,
    AttributeString.statusCompleted,
  ];

  static Map<String, Color> projectTeamColors = {
    "Software": const Color(0xff4A90E2),
    "Sales": const Color(0xffF5A623),
    "Marketing": const Color(0xff306BF3),
    "Operations": const Color(0xffD0021B),
    "Customer Success": const Color(0xff7ED321),
  };

  static Map<String, Color> projectStatusColors = {
    AttributeString.statusNew: const Color(0xff5BC0EB),
    AttributeString.statusInProgress: const Color(0xffFDE74C),
    AttributeString.statusCompleted: const Color(0xff9BC53D),
  };
}
