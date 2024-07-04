import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/create-task/create_task_bottomsheet.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateTaskFloatingButton extends GetView<ProjectDetailsController> {
  const CreateTaskFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDetailsController>(builder: (controller) {
      return FloatingActionButton.extended(
        extendedPadding: EdgeInsets.zero,
        extendedIconLabelSpacing: 0,
        elevation: 0,
        backgroundColor: ColorManager.transparent,
        label: Container(
          padding: const EdgeInsets.all(AppPadding.p8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s16),
              gradient:
                  const LinearGradient(colors: [Colors.purple, Colors.blue])),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.plus,
                color: ColorManager.white,
                size: AppSize.s16,
              ),
              const Gap(AppSize.s10),
              AutoSizeText(
                AppStrings.newTask,
                style: getMediumStyle(
                    color: ColorManager.white, fontSize: FontSize.s16),
              )
            ],
          ),
        ),
        onPressed: () {
          Get.bottomSheet(const CreateTaskBottomsheet(),
              isScrollControlled: true, enableDrag: false);
        },
      );
    });
  }
}
