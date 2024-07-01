import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(IconAssets.emptyStateIcon),
        AutoSizeText(
          title,
          textAlign: TextAlign.center,
          style: getBoldStyle(
              color: ColorManager.darkPrimary, fontSize: FontSize.s20),
        ),
        AutoSizeText(
          subtitle,
          textAlign: TextAlign.center,
          style:
              getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s16),
        ),
      ],
    );
  }
}
