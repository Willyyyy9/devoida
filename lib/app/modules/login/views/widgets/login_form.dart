import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_text_form_field.dart';
import 'package:devoida/app/modules/login/controllers/login_controller.dart';
import 'package:devoida/app/resources/asset_manager.dart';
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

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.3,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 1],
                  colors: [
                    Colors.blue.withOpacity(0.1),
                    Colors.purple.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSize.s16)),
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Center(
              child: Image.asset(ImageAssets.login),
            ),
          ),
          const Gap(AppSize.s16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                AppStrings.welcomeBack,
                style: getBoldStyle(
                    color: ColorManager.black, fontSize: FontSize.s28),
              ),
              Row(
                children: [
                  AutoSizeText(
                    "${AppStrings.welcomeBackSubtitle} ",
                    style: getMediumStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  ),
                  GradientText(
                    AppStrings.devoida,
                    colors: const [
                      Colors.blue,
                      Colors.purple,
                    ],
                    style: getSemiBoldStyle(
                        color: ColorManager.grey, fontSize: FontSize.s16),
                  )
                ],
              ),
              const Gap(AppSize.s28),
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
                      return null;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        controller.resetPassword();
                      },
                      child: AutoSizeText(
                        AppStrings.forgotPassword,
                        style: getSemiBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
