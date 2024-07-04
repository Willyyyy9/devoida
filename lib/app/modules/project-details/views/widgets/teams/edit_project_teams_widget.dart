import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/teams/edit_project_team_item.dart';
import 'package:devoida/app/modules/project-details/views/widgets/teams/edit_project_teams_dialog.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProjectTeamsWidget extends GetView<ProjectDetailsController> {
  const EditProjectTeamsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () {
            Get.dialog(const EditProjectTeamsDialog());
          },
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
              color: ColorManager.transparent,
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
            child: Row(
              children: [
                Expanded(
                    child: controller.selectedTeams.isNotEmpty
                        ? Wrap(
                            children: [
                              ...controller.selectedTeams.map(
                                (team) {
                                  return EditProjectTeamItem(team);
                                },
                              ).toList()
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.users,
                                size: AppSize.s16,
                              ),
                              const Gap(AppSize.s16),
                              AutoSizeText(
                                AppStrings.chooseYourTeams,
                                style: getRegularStyle(
                                    color: ColorManager.grey,
                                    fontSize: FontSize.s12),
                              ),
                            ],
                          )),
                GestureDetector(
                  onTap: () {
                    Get.dialog(const EditProjectTeamsDialog());
                  },
                  child: const Icon(
                    FontAwesomeIcons.plus,
                    size: AppSize.s16,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}