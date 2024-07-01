import 'package:devoida/app/common/widgets/app_button.dart';
import 'package:devoida/app/modules/login/views/widgets/login_form.dart';
import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
        padding: const EdgeInsets.all(AppPadding.p28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: controller.signInForm,
              child: const Expanded(child: LoginForm()),
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    borderRadius: AppSize.s10,
                    title: AppStrings.signIn,
                    onTap: () {
                      controller.signIn();
                    },
                    color: ColorManager.black,
                    buttonTextStyle: getSemiBoldStyle(
                        color: ColorManager.white, fontSize: FontSize.s16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
