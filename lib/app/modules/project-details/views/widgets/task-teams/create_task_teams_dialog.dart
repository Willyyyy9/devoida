import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_button.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-teams/create_task_team_item.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateTaskTeamsDialog extends GetView<ProjectDetailsController> {
  const CreateTaskTeamsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              AppStrings.chooseYourTeams,
              style: getSemiBoldStyle(
                  color: ColorManager.black, fontSize: FontSize.s22),
            ),
            const Gap(AppSize.s16),
            Wrap(
              children: [
                ...AppConstants.teams.map(
                  (team) {
                    return CreateTaskTeamItem(team);
                  },
                ).toList()
              ],
            ),
            const Gap(AppSize.s16),
            AppButton(
                title: AppStrings.done,
                buttonTextStyle: getMediumStyle(
                  color: ColorManager.white,
                ),
                color: ColorManager.black,
                onTap: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
