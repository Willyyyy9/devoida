import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/home/controllers/home_controller.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProjectItem extends GetView<HomeController> {
  const ProjectItem(this.project, {super.key});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.PROJECT_DETAILS, arguments: project.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
            border: Border.all(width: AppSize.s2, color: ColorManager.black),
            borderRadius: BorderRadius.circular(AppSize.s16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    project.title,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ),
              ],
            ),
            const Gap(AppSize.s4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...project.teams.map((team) {
                    return Container(
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppMargin.m4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p8, vertical: AppPadding.p4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          color: AppConstants.projectTeamColors[team]),
                      child: AutoSizeText(
                        team,
                        style: getRegularStyle(
                          color: ColorManager.white,
                        ),
                      ),
                    );
                  }).toList()
                ],
              ),
            ),
            const Gap(AppSize.s16),
            Row(
              children: [
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.calendar,
                      size: AppSize.s16,
                    ),
                    const Gap(AppSize.s10),
                    Expanded(
                      child: AutoSizeText(
                        controller.formatDate(project.createdAt),
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      project.status,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
