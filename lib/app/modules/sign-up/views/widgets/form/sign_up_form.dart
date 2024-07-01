import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_text_form_field.dart';
import 'package:devoida/app/modules/sign-up/controllers/sign_up_controller.dart';
import 'package:devoida/app/modules/sign-up/views/widgets/teams/teams_widget.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SignUpForm extends GetView<SignUpController> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpForm,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              AppStrings.getStarted,
              style: getBoldStyle(
                  color: ColorManager.black, fontSize: FontSize.s32),
            ),
            Row(
              children: [
                AutoSizeText(
                  "${AppStrings.withText} ",
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s32),
                ),
                GradientText(
                  AppStrings.devoida,
                  colors: const [Colors.blue, Colors.purple],
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s32),
                )
              ],
            ),
            const Gap(AppSize.s8),
            AutoSizeText(
              AppStrings.getStartedSubtitle,
              style: getMediumStyle(
                  color: ColorManager.grey, fontSize: FontSize.s16),
            ),
            const Gap(AppSize.s32),
            AppTextFormField(
              hint: AppStrings.fullName,
              autofillHints: const [AutofillHints.name],
              controller: controller.fullNameController,
              prefixIcon: FontAwesomeIcons.user,
            ),
            const Gap(AppSize.s10),
            AppTextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (EmailValidator.validate(email ?? "")) {
                    return null;
                  } else {
                    return AppStrings.enterValidEmail;
                  }
                },
                autofillHints: const [AutofillHints.email],
                hint: AppStrings.emailAddress,
                prefixIcon: FontAwesomeIcons.envelope,
                controller: controller.emailController),
            const Gap(AppSize.s10),
            Obx(() => AppTextFormField(
                keyboardType: TextInputType.visiblePassword,
                autofillHints: const [AutofillHints.password],
                validator: (password) {
                  if (password != null && password.length >= 6) {
                    if (password == controller.confirmPassowrdController.text) {
                      return null;
                    } else {
                      return AppStrings.passwordMustMatch;
                    }
                  } else {
                    return AppStrings.enterValidPassword;
                  }
                },
                hint: AppStrings.password,
                prefixIcon: FontAwesomeIcons.shieldHalved,
                suffixIcon: controller.isPasswordVisible.value
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                obscureText: controller.isPasswordVisible.value,
                onSuffixPressed: () {
                  controller.isPasswordVisible.value =
                      !controller.isPasswordVisible.value;
                },
                controller: controller.passwordController)),
            const Gap(AppSize.s10),
            Obx(() => AppTextFormField(
                validator: (password) {
                  if (password != null && password.length >= 6) {
                    if (password == controller.passwordController.text) {
                      return null;
                    } else {
                      return AppStrings.passwordMustMatch;
                    }
                  } else {
                    return AppStrings.enterValidPassword;
                  }
                },
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                hint: AppStrings.confirmPassword,
                prefixIcon: FontAwesomeIcons.shieldHalved,
                suffixIcon: controller.isConfirmPasswordVisible.value
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                obscureText: controller.isConfirmPasswordVisible.value,
                onSuffixPressed: () {
                  controller.isConfirmPasswordVisible.value =
                      !controller.isConfirmPasswordVisible.value;
                },
                controller: controller.confirmPassowrdController)),
            const Gap(AppSize.s10),
            const TeamsWidget(),
          ],
        ),
      ),
    );
  }
}
