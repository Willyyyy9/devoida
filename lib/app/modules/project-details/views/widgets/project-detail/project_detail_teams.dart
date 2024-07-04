import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetailTeams extends GetView<ProjectDetailsController> {
  const ProjectDetailTeams(this.teams, {super.key});
  final List<String> teams;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        ...teams.map((team) {
          return Container(
            margin: const EdgeInsets.all(AppMargin.m4),
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
    );
  }
}
