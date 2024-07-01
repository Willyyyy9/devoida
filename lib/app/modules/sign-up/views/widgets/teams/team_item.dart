import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/sign-up/controllers/sign_up_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TeamItem extends GetView<SignUpController> {
  const TeamItem(this.team, {super.key});
  final String team;

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            if (controller.selectedTeams.contains(team)) {
              controller.selectedTeams.remove(team);
            } else {
              controller.selectedTeams.add(team);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(AppMargin.m4),
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: controller.selectedTeams.contains(team) == true
                    ? Colors.blue
                    : Colors.grey),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  team,
                  style: getMediumStyle(
                      color: ColorManager.white, fontSize: FontSize.s14),
                ),
                const Gap(AppSize.s10),
                Icon(
                  controller.selectedTeams.contains(team) == true
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.plus,
                  size: AppSize.s16,
                  color: ColorManager.white,
                )
              ],
            ),
          ),
        ));
  }
}
