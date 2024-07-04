import 'package:devoida/app/modules/project-details/views/widgets/analytics/project_tasks_analytics.dart';
import 'package:devoida/app/modules/project-details/views/widgets/edit/edit_project_bottomsheet.dart';
import 'package:devoida/app/modules/project-details/views/widgets/empty-state/project_details_empty_state.dart';
import 'package:devoida/app/modules/project-details/views/widgets/floating-button/create_task_floating_button.dart';
import 'package:devoida/app/modules/project-details/views/widgets/project-detail/project_detail_content.dart';
import 'package:devoida/app/modules/project-details/views/widgets/project-detail/project_details_header.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-list/project_task_list.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/project_details_controller.dart';

class ProjectDetailsView extends GetView<ProjectDetailsController> {
  const ProjectDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CreateTaskFloatingButton(),
      appBar: AppBar(
        title: Text(
          AppStrings.projectDetails,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s16),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.handleProjectResponse();
              Get.bottomSheet(const EditProjectBottomsheet(),
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
          if (controller.isProjectLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.project == null &&
              controller.isProjectError.value == true) {
            return const ProjectDetailsEmptyState();
          } else {
            if (controller.project == null) {
              return const ProjectDetailsEmptyState();
            } else {
              return Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(children: [
                  ProjectDetailsHeader(controller.project!),
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                            controller: controller.tabController,
                            isScrollable: false,
                            labelColor: ColorManager.black,
                            indicatorColor: ColorManager.black,
                            labelStyle: getSemiBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14),
                            unselectedLabelStyle: getRegularStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s12),
                            splashBorderRadius:
                                BorderRadius.circular(AppSize.s16),
                            indicatorWeight: 3,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(
                                child: Text(
                                  "Details",
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Analytics",
                                ),
                              ),
                              Tab(
                                child: Text("Tasks"),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        ProjectDetailContent(project: controller.project!),
                        const ProjectTasksAnalytics(),
                        const ProjectTaskList()
                      ],
                    ),
                  )
                ]),
              );
            }
          }
        },
      ),
    );
  }
}
