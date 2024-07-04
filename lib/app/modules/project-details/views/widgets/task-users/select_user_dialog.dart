import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SelectUserDialog extends GetView<ProjectDetailsController> {
  const SelectUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: AutoSizeText(
                    AppStrings.selectAssignee,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                ),
                const Gap(AppSize.s10),
                Wrap(
                  children: [
                    ...controller.users.map(
                      (user) {
                        return InkWell(
                          onTap: () {
                            if (controller.selectedUser.value?.id == user.id) {
                              controller.selectedUser.value = null;
                            } else {
                              controller.selectedUser.value = user;
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(AppMargin.m4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p8,
                                vertical: AppPadding.p4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s16),
                              color:
                                  controller.selectedUser.value?.id == user.id
                                      ? ColorManager.black
                                      : ColorManager.backgroundGreyGrey,
                            ),
                            child: AutoSizeText(
                              user.name,
                              style: getRegularStyle(
                                color:
                                    controller.selectedUser.value?.id == user.id
                                        ? ColorManager.white
                                        : ColorManager.black,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
