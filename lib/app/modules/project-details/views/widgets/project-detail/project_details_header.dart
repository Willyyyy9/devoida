import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProjectDetailsHeader extends StatefulWidget {
  const ProjectDetailsHeader(this.project, {super.key});
  final Project project;

  @override
  State<ProjectDetailsHeader> createState() => _ProjectDetailsHeaderState();
}

class _ProjectDetailsHeaderState extends State<ProjectDetailsHeader> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDetailsController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
            color: AppConstants.projectStatusColors[widget.project.status]!
                .withOpacity(0.3),
            borderRadius: BorderRadius.circular(AppSize.s16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isExpanded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8, vertical: AppPadding.p4),
                    decoration: BoxDecoration(
                        color: AppConstants
                            .projectStatusColors[widget.project.status],
                        borderRadius: BorderRadius.circular(AppSize.s16)),
                    child: AutoSizeText(
                      widget.project.status,
                      style: getRegularStyle(color: ColorManager.black),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isExpanded
                            ? FontAwesomeIcons.chevronUp
                            : FontAwesomeIcons.chevronDown,
                        size: AppSize.s16,
                      ),
                    ),
                  )
                ],
              ),
            if (isExpanded) const Gap(AppSize.s4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSizeText(
                    widget.project.title,
                    maxLines: 2,
                    style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: isExpanded ? FontSize.s22 : FontSize.s18),
                  ),
                ),
                const Gap(AppSize.s10),
                if (!isExpanded)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isExpanded
                            ? FontAwesomeIcons.chevronUp
                            : FontAwesomeIcons.chevronDown,
                        size: AppSize.s16,
                      ),
                    ),
                  )
              ],
            ),
            if (isExpanded) const Gap(AppSize.s10),
            if (isExpanded)
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.calendar,
                    size: AppSize.s16,
                  ),
                  const Gap(AppSize.s10),
                  AutoSizeText(
                    "${AppStrings.createdAt}: ${controller.formatDate(
                      widget.project.createdAt,
                    )}",
                    style: getRegularStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ],
              )
          ],
        ),
      );
    });
  }
}
