import 'package:devoida/app/common/empty_state.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/filter/project_task_filter.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-list/project_task_item.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProjectTaskList extends GetView<ProjectDetailsController> {
  const ProjectTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProjectTaskFilter(),
        const Gap(AppSize.s10),
        Obx(
          () => controller.isLoading.value == false &&
                  controller.projectTasks.isEmpty
              ? const Expanded(
                  child: Center(
                  child: EmptyState(
                    title: AppStrings.noProjectTaskFound,
                    subtitle: AppStrings.noProjectTaskFoundSubtitle,
                  ),
                ))
              : controller.isLoading.value && controller.projectTasks.isEmpty
                  ? const Expanded(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              itemCount: controller.projectTasks.length,
                              itemBuilder: (context, index) {
                                return ProjectTaskItem(
                                    controller.projectTasks[index]);
                              },
                            ),
                          ),
                          if (controller.isLoading.value)
                            const Center(
                              child: CircularProgressIndicator(),
                            )
                        ],
                      ),
                    ),
        ),
      ],
    );
  }
}
