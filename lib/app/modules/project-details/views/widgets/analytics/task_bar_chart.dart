import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TaskBarChart extends GetView<ProjectDetailsController> {
  const TaskBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.7,
      child: Column(
        children: [
          AutoSizeText(
            AppStrings.numberOfUsersTasks,
            style:
                getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
          ),
          const Gap(AppSize.s10),
          Expanded(
            child: BarChart(
              BarChartData(
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups,
                gridData: const FlGridData(show: true),
                alignment: BarChartAlignment.spaceAround,
                maxY: controller.allTasks.length.toDouble(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    TextStyle style = getBoldStyle(
      color: Colors.black,
      fontSize: 14,
    );
    String text = controller.users[value.toInt()].name.split(" ").first;

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: RotatedBox(
          quarterTurns: 3,
          child: SizedBox(
              width: 100,
              child: AutoSizeText(
                text,
                style: style,
                maxLines: 2,
                textAlign: TextAlign.center,
              ))),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 100,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => [
        ...controller.users
            .asMap()
            .map(
              (key, value) {
                return MapEntry(
                    key,
                    BarChartGroupData(
                      x: key,
                      barRods: [
                        BarChartRodData(
                          toY: int.parse(controller.allTasks
                                  .where(
                                    (element) => element.assigneeId == value.id,
                                  )
                                  .length
                                  .toStringAsFixed(0))
                              .toDouble(),
                        )
                      ],
                      showingTooltipIndicators: [0],
                    ));
              },
            )
            .values
            .toList(),
      ];
}
