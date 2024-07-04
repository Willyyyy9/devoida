import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/project-detail/project_detail_teams.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProjectDetailContent extends GetView<ProjectDetailsController> {
  const ProjectDetailContent({super.key, required this.project});
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectDetailTeams(project.teams),
            const Gap(AppSize.s10),
            AutoSizeText(
              project.description,
              style: getRegularStyle(
                  color: ColorManager.grey, fontSize: FontSize.s14),
            ),
            const Gap(AppSize.s10),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const Gap(AppSize.s10),
                AutoSizeText(
                  "${AppStrings.createdAt}: ${controller.formatDate(project.createdAt)}",
                  style: getRegularStyle(color: ColorManager.black),
                )
              ],
            ),
            const Gap(AppSize.s10),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const Gap(AppSize.s10),
                AutoSizeText(
                  project.endedAt.isEmpty
                      ? AppStrings.hasntCompleted
                      : "${AppStrings.completedAt}: ${controller.formatDate(project.endedAt)}",
                  style: getRegularStyle(color: ColorManager.black),
                )
              ],
            ),
            const Gap(AppSize.s10),
            Row(
              children: [
                const Icon(Icons.person),
                const Gap(AppSize.s10),
                AutoSizeText(
                  controller.projectCreator?.name ?? "",
                  style: getRegularStyle(color: ColorManager.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
