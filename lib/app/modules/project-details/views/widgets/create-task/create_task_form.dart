import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_multi_line_text_form_field.dart';
import 'package:devoida/app/common/widgets/app_text_form_field.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/views/widgets/date-picker/task_deadline_date_picker.dart';
import 'package:devoida/app/modules/project-details/views/widgets/date-picker/task_start_date_picker.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-teams/create_task_teams_widget.dart';
import 'package:devoida/app/modules/project-details/views/widgets/task-users/select_user_widget.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateTaskForm extends GetView<ProjectDetailsController> {
  const CreateTaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.createTaskForm,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    AppStrings.newTask,
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
            const SelectUserWidget(),
            const Gap(AppSize.s16),
            const CreateTaskTeamsWidget(),
            const Gap(AppSize.s16),
            const TaskStartDatePicker(),
            const Gap(AppSize.s16),
            const TaskDeadlineDatePicker(),
            const Gap(AppSize.s16),
          ],
        ),
      ),
    );
  }
}
