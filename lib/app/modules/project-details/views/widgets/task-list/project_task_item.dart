import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
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

class ProjectTaskItem extends GetView<ProjectDetailsController> {
  const ProjectTaskItem(this.projectTask, {super.key});
  final ProjectTask projectTask;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TASK_DETAILS, arguments: projectTask.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
            color: AppConstants.projectStatusColors[projectTask.status]!
                .withOpacity(0.4),
            border: Border.all(width: AppSize.s2, color: ColorManager.black),
            borderRadius: BorderRadius.circular(AppSize.s16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    projectTask.title,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ),
              ],
            ),
            const Gap(AppSize.s4),
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
                        controller.formatDate(projectTask.createdAt),
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    if (projectTask.assigneeId !=
                        controller.firebaseAuth.currentUser!.uid)
                      AutoSizeText(
                        projectTask.status,
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ),
                  ],
                )),
              ],
            ),
            if (projectTask.assigneeId ==
                controller.firebaseAuth.currentUser!.uid)
              const Gap(AppSize.s10),
            if (projectTask.assigneeId ==
                controller.firebaseAuth.currentUser!.uid)
              Row(children: [
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      size: AppSize.s16,
                    ),
                    const Gap(AppSize.s10),
                    Expanded(
                      child: AutoSizeText(
                        "Assigned to you",
                        style: getMediumStyle(
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      projectTask.status,
                      style: getMediumStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ],
                ))
              ])
          ],
        ),
      ),
    );
  }
}
