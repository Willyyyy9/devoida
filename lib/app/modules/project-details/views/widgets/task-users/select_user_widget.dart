import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-users/select_user_dialog.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SelectUserWidget extends GetView<ProjectDetailsController> {
  const SelectUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(const SelectUserDialog());
      },
      child: Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          decoration: BoxDecoration(
              border: Border.all(width: AppSize.s1, color: ColorManager.black),
              borderRadius: BorderRadius.circular(AppSize.s16)),
          child: Obx(
            () => Row(
              children: [
                const Icon(Icons.person),
                const Gap(AppSize.s10),
                controller.selectedUser.value != null
                    ? Container(
                        margin: const EdgeInsets.all(AppMargin.m4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p8, vertical: AppPadding.p4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          color: ColorManager.black,
                        ),
                        child: AutoSizeText(
                          controller.selectedUser.value!.name,
                          style: getRegularStyle(
                            color: ColorManager.white,
                          ),
                        ),
                      )
                    : AutoSizeText(
                        AppStrings.selectAssignee,
                        style: getRegularStyle(
                            color: ColorManager.grey, fontSize: FontSize.s12),
                      ),
                const Spacer(),
                const Icon(
                  Icons.add,
                )
              ],
            ),
          )),
    );
  }
}
