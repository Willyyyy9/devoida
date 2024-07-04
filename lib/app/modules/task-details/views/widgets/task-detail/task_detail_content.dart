import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
import 'package:devoida/app/modules/task-details/controllers/task_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TaskDetailContent extends GetView<TaskDetailsController> {
  const TaskDetailContent({super.key, required this.task});
  final ProjectTask task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(AppMargin.m4),
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p8, vertical: AppPadding.p4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s16),
                  color: AppConstants.projectTeamColors[task.team]),
              child: AutoSizeText(
                task.team,
                style: getRegularStyle(
                  color: ColorManager.white,
                ),
              ),
            ),
            const Gap(AppSize.s10),
            AutoSizeText(
              task.description,
              style: getRegularStyle(
                  color: ColorManager.grey, fontSize: FontSize.s14),
            ),
            const Gap(AppSize.s10),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const Gap(AppSize.s10),
                AutoSizeText(
                  "${AppStrings.taskStartDate}: ${controller.formatDate(task.createdAt)}",
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
                  task.deadlineDate.isEmpty
                      ? AppStrings.hasntCompleted
                      : "${AppStrings.taskDeadlineDate}: ${controller.formatDate(task.deadlineDate)}",
                  style: getRegularStyle(color: ColorManager.black),
                )
              ],
            ),
            const Gap(AppSize.s10),
            if (task.finishedDate.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const Gap(AppSize.s10),
                  AutoSizeText(
                    task.deadlineDate.isEmpty
                        ? AppStrings.hasntCompleted
                        : "${AppStrings.taskFinishedDate}: ${controller.formatDate(task.finishedDate)}",
                    style: getRegularStyle(color: ColorManager.black),
                  )
                ],
              ),
            if (task.finishedDate.isNotEmpty) const Gap(AppSize.s10),
            Row(
              children: [
                const Icon(Icons.person),
                const Gap(AppSize.s10),
                AutoSizeText(
                  "${AppStrings.createdBy}: ${controller.taskCreator?.name ?? ""}",
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
                  "${AppStrings.assignedTo}: ${controller.taskAssignee?.name ?? ""}",
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
