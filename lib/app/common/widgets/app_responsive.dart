import 'package:flutter/material.dart';

class AppResponsive extends StatefulWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const AppResponsive(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop});

  /// This size work for my design, maybe you need some changes depend on your design
  /// make function that can help us later
  static bool isMobile(context) => MediaQuery.of(context).size.width < 900;
  static bool isTablet(context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 900;
  static bool isDesktop(context) => MediaQuery.of(context).size.width >= 1100;

  @override
  State<AppResponsive> createState() => _AppResponsiveState();
}

class _AppResponsiveState extends State<AppResponsive> {
  @override
  Widget build(BuildContext context) {
    if (AppResponsive.isDesktop(context)) {
      return widget.desktop;
    } else if (AppResponsive.isTablet(context)) {
      return widget.tablet;
    } else {
      return widget.mobile;
    }
  }
}
