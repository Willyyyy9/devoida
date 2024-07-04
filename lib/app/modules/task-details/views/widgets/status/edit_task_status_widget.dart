import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/task-details/controllers/task_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTaskStatusWidget extends GetView<TaskDetailsController> {
  const EditTaskStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          border: Border.all(width: AppSize.s1, color: ColorManager.black),
          borderRadius: BorderRadius.circular(AppSize.s16)),
      child: Row(
        children: [
          ...AppConstants.projectStatuses.map(
            (status) {
              return Obx(
                () => InkWell(
                  onTap: () {
                    controller.selectedStatus.value = status;
                  },
                  child: Container(
                    margin: const EdgeInsets.all(AppMargin.m6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8, vertical: AppPadding.p4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSize.s16),
                        color: controller.selectedStatus.value == status
                            ? AppConstants.projectStatusColors[status]
                            : ColorManager.grey.withOpacity(0.4)),
                    child: AutoSizeText(
                      status,
                      style: getRegularStyle(
                          color: ColorManager.black, fontSize: FontSize.s14),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
