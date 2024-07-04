import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_multi_line_text_form_field.dart';
import 'package:devoida/app/common/widgets/app_text_form_field.dart';
import 'package:devoida/app/modules/task-details/controllers/task_details_controller.dart';
import 'package:devoida/app/modules/task-details/views/widgets/date-picker/edit_task_deadline_date_picker.dart';
import 'package:devoida/app/modules/task-details/views/widgets/date-picker/edit_task_start_date_picker.dart';
import 'package:devoida/app/modules/task-details/views/widgets/status/edit_task_status_widget.dart';
import 'package:devoida/app/modules/task-details/views/widgets/task-teams/edit_task_teams_widget.dart';
import 'package:devoida/app/modules/task-details/views/widgets/task-users/edit_task_select_user_widget.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditTaskForm extends GetView<TaskDetailsController> {
  const EditTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.editTaskForm,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    AppStrings.updateTask,
                    style: getSemiBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s22),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    FontAwesomeIcons.xmark,
                    color: ColorManager.black,
                  ),
                )
              ],
            ),
            const Gap(AppSize.s16),
            AppTextFormField(
              hint: AppStrings.taskName,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              controller: controller.nameTextController,
              prefixIcon: FontAwesomeIcons.user,
            ),
            const Gap(AppSize.s16),
            AppMultiLineTextFormField(
              hint: AppStrings.taskDescription,
              controller: controller.descriptionTextController,
              prefixIcon: FontAwesomeIcons.message,
            ),
            const Gap(AppSize.s16),
            const EditTaskSelectUserWidget(),
            const Gap(AppSize.s16),
            const EditTaskTeamsWidget(),
            const Gap(AppSize.s16),
            const EditTaskStatusWidget(),
            const Gap(AppSize.s16),
            const EditTaskStartDatePicker(),
            const Gap(AppSize.s16),
            const EditTaskDeadlineDatePicker(),
            const Gap(AppSize.s16),
          ],
        ),
      ),
    );
  }
}
