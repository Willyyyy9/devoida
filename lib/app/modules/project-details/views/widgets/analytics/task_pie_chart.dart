import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/constant_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class TaskPieChart extends GetView<ProjectDetailsController> {
  const TaskPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectDetailsController>(builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            AppStrings.projectCompletionRate,
            style:
                getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
          ),
          const Gap(AppSize.s16),
          AspectRatio(
            aspectRatio: 1.3,
            child: Row(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: showingSections(),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ...AppConstants.projectStatusColors
                        .map(
                          (key, value) {
                            return MapEntry(
                                key,
                                Row(
                                  children: [
                                    Container(
                                      width: AppSize.s16,
                                      height: AppSize.s16,
                                      color: value,
                                    ),
                                    const Gap(AppSize.s10),
                                    Text(
                                      key,
                                      style: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s14),
                                    )
                                  ],
                                ));
                          },
                        )
                        .values
                        .toList()
                    // Indicator(
                    //   color: AppColors.contentColorBlue,
                    //   text: 'First',
                    //   isSquare: true,
                    // ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // Indicator(
                    //   color: AppColors.contentColorYellow,
                    //   text: 'Second',
                    //   isSquare: true,
                    // ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // Indicator(
                    //   color: AppColors.contentColorPurple,
                    //   text: 'Third',
                    //   isSquare: true,
                    // ),
                    // SizedBox(
                    //   height: 4,
                    // ),
                    // Indicator(
                    //   color: AppColors.contentColorGreen,
                    //   text: 'Fourth',
                    //   isSquare: true,
                    // ),
                    ,
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  List<PieChartSectionData> showingSections() {
    return AppConstants.projectStatuses.map(
      (status) {
        return PieChartSectionData(
          color: AppConstants.projectStatusColors[status],
          value: controller.allTasks
              .where((element) => element.status == status)
              .length
              .toDouble(),
          title:
              "${((controller.allTasks.where((element) => element.status == status).length.toDouble() / controller.allTasks.length) * 100).toStringAsFixed(0)}%",
          titleStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        );
      },
    ).toList();
  }
}
