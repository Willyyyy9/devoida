import 'package:devoida/app/modules/task-details/views/widgets/edit-task/edit_task_bottomsheet.dart';
import 'package:devoida/app/modules/task-details/views/widgets/empty-state/task_details_empty_state.dart';
import 'package:devoida/app/modules/task-details/views/widgets/task-detail/task_detail_content.dart';
import 'package:devoida/app/modules/task-details/views/widgets/task-detail/task_details_header.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.taskDetails,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.handleTaskResponse();
              Get.bottomSheet(const EditTaskBottomsheet(),
                  isScrollControlled: true, enableDrag: false);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.solidPenToSquare,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isProjectTaskLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.projectTask == null &&
              controller.isProjectTaskError.value == true) {
            return const TaskDetailsEmptyState();
          } else {
            if (controller.projectTask == null) {
              return const TaskDetailsEmptyState();
            } else {
              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(children: [
                  TaskDetailsHeader(controller.projectTask!),
                  TaskDetailContent(task: controller.projectTask!)
                ]),
              );
            }
          }
        },
      ),
    );
  }
}
