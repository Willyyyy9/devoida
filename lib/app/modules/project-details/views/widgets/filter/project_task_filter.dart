import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectTaskFilter extends GetView<ProjectDetailsController> {
  const ProjectTaskFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
        child: Row(
          children: [
            Obx(() => InkWell(
                  onTap: () {
                    controller.selectedFilterTeam.value = "";
                    controller.onRefreshTasks();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8, vertical: AppPadding.p4),
                    decoration: BoxDecoration(
                        color: controller.selectedFilterTeam.value == ""
                            ? ColorManager.black
                            : ColorManager.backgroundGreyGrey,
                        borderRadius: BorderRadius.circular(AppSize.s16)),
                    child: AutoSizeText(
                      "All",
                      style: getMediumStyle(
                          color: controller.selectedFilterTeam.value == ""
                              ? ColorManager.white
                              : ColorManager.black,
                          fontSize: FontSize.s14),
                    ),
                  ),
                )),
            ...AppConstants.teams.map((team) {
              return Obx(() => InkWell(
                    onTap: () {
                      controller.selectedFilterTeam.value = team;
                      controller.onRefreshTasks();
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8, vertical: AppPadding.p4),
                      decoration: BoxDecoration(
                          color: controller.selectedFilterTeam.value == team
                              ? AppConstants.projectTeamColors[team]
                              : ColorManager.backgroundGreyGrey,
                          borderRadius: BorderRadius.circular(AppSize.s16)),
                      child: AutoSizeText(
                        team,
                        style: getMediumStyle(
                            color: controller.selectedFilterTeam.value == team
                                ? ColorManager.white
                                : ColorManager.black,
                            fontSize: FontSize.s14),
                      ),
                    ),
                  ));
            }).toList()
          ],
        ),
      ),
    );
  }
}
