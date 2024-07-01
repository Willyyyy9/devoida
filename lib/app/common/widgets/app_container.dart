import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer(
      {super.key,
      required this.child,
      this.width,
      this.height,
      this.color,
      this.padding});
  final Widget child;
  final double? width;
  final double? height;
  final double? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.4,
      height: height ?? MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(padding ?? AppPadding.p28),
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.m12, horizontal: AppMargin.m16),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(3, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: color ?? ColorManager.white),
      child: child,
    );
  }
}
