import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class TaskStartDatePicker extends GetView<ProjectDetailsController> {
  const TaskStartDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          showOmniDateTimePicker(
            context: context,
            initialDate: controller.selectedToDate.value != null
                ? controller.selectedToDate.value!
                    .subtract(const Duration(days: 1))
                : DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: controller.selectedToDate.value != null
                ? controller.selectedToDate.value!
                    .subtract(const Duration(days: 1))
                : DateTime(2100),
            is24HourMode: true,
            isShowSeconds: false,
            minutesInterval: 1,
            secondsInterval: 1,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            constraints: const BoxConstraints(
              maxWidth: 350,
              maxHeight: 650,
            ),
            transitionBuilder: (context, anim1, anim2, child) {
              return FadeTransition(
                opacity: anim1.drive(
                  Tween(
                    begin: 0,
                    end: 1,
                  ),
                ),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 200),
            barrierDismissible: true,
          ).then((selectedDate) {
            controller.selectedFromDate.value = selectedDate;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            border: Border.all(
              color: ColorManager.black,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    controller.selectedFromDate.value != null
                        ? DateFormat("dd-MM-yyyy HH:mm")
                            .format(controller.selectedFromDate.value!)
                        : "Task Start Date",
                    style: getRegularStyle(
                      color: ColorManager.grey,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.calendar_month,
              )
            ],
          ),
        ),
      ),
    );
  }
}
