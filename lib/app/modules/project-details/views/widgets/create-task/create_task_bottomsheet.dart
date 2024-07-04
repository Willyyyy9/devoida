import 'package:devoida/app/common/widgets/app_button.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/create-task/create_task_form.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTaskBottomsheet extends GetView<ProjectDetailsController> {
  const CreateTaskBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        controller.clearValues();
      },
      child: BottomSheet(
        backgroundColor: ColorManager.backgroundGreyGrey,
        onClosing: () {
          controller.clearValues();
        },
        enableDrag: false,
        builder: (context) {
          return Container(
              height: MediaQuery.sizeOf(context).height * 0.7,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  const Expanded(child: CreateTaskForm()),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            borderRadius: AppSize.s10,
                            title: AppStrings.create,
                            onTap: () {
                              controller.createProjectTask();
                            },
                            color: ColorManager.black,
                            buttonTextStyle: getSemiBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
