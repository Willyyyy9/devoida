import 'package:devoida/app/common/widgets/app_button.dart';
import 'package:devoida/app/modules/sign-up/views/widgets/form/sign_up_form.dart';
import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: AppSize.s100,
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Image.asset(
            ImageAssets.devoida,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: SignUpForm()),
            const Gap(AppSize.s16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      borderRadius: AppSize.s10,
                      title: AppStrings.signUp,
                      onTap: () {
                        controller.signUp();
                      },
                      color: ColorManager.black,
                      buttonTextStyle: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
