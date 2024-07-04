import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateTaskTeamItem extends GetView<ProjectDetailsController> {
  const CreateTaskTeamItem(this.team, {super.key});
  final String team;

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            if (controller.selectedTaskTeam.value == team) {
              controller.selectedTaskTeam.value = "";
            } else {
              controller.selectedTaskTeam.value = team;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(AppMargin.m4),
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s16),
                color: controller.selectedTaskTeam.value == team
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
                  controller.selectedTaskTeam.value == team
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
