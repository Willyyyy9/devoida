import 'package:devoida/app/common/empty_state.dart';
import 'package:devoida/app/modules/task-details/controllers/task_details_controller.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TaskDetailsEmptyState extends GetView<TaskDetailsController> {
  const TaskDetailsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyState(
            title: AppStrings.noProjectTaskFound,
            subtitle: AppStrings.noProjectTaskFoundSubtitle),
        const Gap(AppSize.s10),
        IconButton(
            onPressed: () {
              controller.getTaskById(Get.arguments);
            },
            icon: const Icon(
              FontAwesomeIcons.arrowRotateRight,
              color: Colors.black,
            ))
      ],
    ));
  }
}
