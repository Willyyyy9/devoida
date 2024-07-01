import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //Colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    //Cards Theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    //AppBar Theme
    appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        color: ColorManager.transparent,
        elevation: AppSize.s0,
        shadowColor: ColorManager.transparent,
        titleTextStyle: getRegularStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        )),

    //Button Theme
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),

    //Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s17,
            ),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),

    //Text Theme
    textTheme: TextTheme(
      displayLarge:
          getBoldStyle(color: ColorManager.darkGrey, fontSize: FontSize.s16),
      headlineMedium:
          getRegularStyle(color: ColorManager.darkGrey, fontSize: FontSize.s14),
      titleMedium:
          getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(
        color: ColorManager.grey1,
      ),
      bodyLarge: getRegularStyle(color: ColorManager.grey),
    ),

    dialogTheme: DialogTheme(
        backgroundColor: ColorManager.white,
        titleTextStyle:
            getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        contentTextStyle: getRegularStyle(color: ColorManager.black),
        alignment: Alignment.center),

    //Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.darkPrimary,
        fontSize: FontSize.s14,
      ),
      labelStyle: getMediumStyle(
        color: ColorManager.darkPrimary,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: ColorManager.error, height: 1),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    ),
  );
}
