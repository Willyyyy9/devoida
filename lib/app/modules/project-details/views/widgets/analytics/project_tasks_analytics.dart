import 'package:devoida/app/common/widgets/app_divider.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/analytics/task_bar_chart.dart';
import 'package:devoida/app/modules/project-details/views/widgets/analytics/task_pie_chart.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProjectTasksAnalytics extends GetView<ProjectDetailsController> {
  const ProjectTasksAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TaskPieChart(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: AppDivider(),
            ),
            TaskBarChart(),
            Gap(AppSize.s75)
          ],
        ),
      ),
    );
  }
}
