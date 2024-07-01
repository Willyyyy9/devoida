import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Semantics(
          label: AppStrings.backButton,
          child: SvgPicture.asset(
            IconAssets.backButton,
            excludeFromSemantics: true,
          ),
        ),
      ),
    );
  }
}
