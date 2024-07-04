import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:get/get.dart';

class TaskGanttChart extends GetView<ProjectDetailsController> {
  const TaskGanttChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: GanttChartView(
        maxDuration: const Duration(
            days:
                30 * 2), //optional, set to null for infinite horizontal scroll
        startDate: controller.getEarliestStartDate()!, //required
        dayWidth: 20, //column width for each day
        eventHeight: 30, //row height for events
        stickyAreaWidth: 100, //sticky area width
        showStickyArea: true, //show sticky area or not
        showDays: true, //show days or not
        startOfTheWeek: WeekDay.sunday, //custom start of the week
        weekEnds: const {WeekDay.friday, WeekDay.saturday}, //custom weekends

        events: [
          //event relative to startDate

          ...controller.allTasks
              .sublist(controller.allTasks.length - 4)
              .map((task) => GanttRelativeEvent(
                    relativeToStart: controller.calculateDateDifference(task),
                    duration: const Duration(days: 2),
                    displayName: task.title,
                  ))
              .toList(),
          //event with absolute start and end
        ],
      ),
    );
  }
}
