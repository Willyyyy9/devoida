import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_multi_line_text_form_field.dart';
import 'package:devoida/app/common/widgets/app_text_form_field.dart';
import 'package:devoida/app/modules/home/controllers/home_controller.dart';
import 'package:devoida/app/modules/home/views/widgets/teams/project_teams_widget.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateProjectForm extends GetView<HomeController> {
  const CreateProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.createProjectForm,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    AppStrings.newProject,
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
              hint: AppStrings.projectName,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              controller: controller.nameTextController,
              prefixIcon: FontAwesomeIcons.user,
            ),
            const Gap(AppSize.s16),
            AppMultiLineTextFormField(
              hint: AppStrings.projectDescription,
              controller: controller.descriptionTextController,
              prefixIcon: FontAwesomeIcons.message,
            ),
            const Gap(AppSize.s16),
            const ProjectTeamsWidget()
          ],
        ),
      ),
    );
  }
}
