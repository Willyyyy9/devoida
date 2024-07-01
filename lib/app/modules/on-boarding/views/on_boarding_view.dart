import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/common/widgets/app_button.dart';
import 'package:devoida/app/modules/on-boarding/views/widgets/on_boarding_indicatior.dart';
import 'package:devoida/app/modules/on-boarding/views/widgets/on_boarding_item.dart';
import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
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
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            const OnBoardingIndicator(),
            const Gap(AppSize.s10),
            Expanded(
                child: PageView(
              onPageChanged: (value) {
                controller.contentIndex = value;
                controller.update();
              },
              children: [
                OnBoardingItem(
                    title: controller.titles[0],
                    subtitle: controller.subtitles[0],
                    image: controller.images[0]),
                OnBoardingItem(
                    title: controller.titles[1],
                    subtitle: controller.subtitles[1],
                    image: controller.images[1]),
                OnBoardingItem(
                    title: controller.titles[2],
                    subtitle: controller.subtitles[2],
                    image: controller.images[2]),
              ],
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      borderRadius: AppSize.s10,
                      title: AppStrings.signUp,
                      onTap: () {
                        Get.toNamed(Routes.SIGN_UP);
                      },
                      color: ColorManager.black,
                      buttonTextStyle: getSemiBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s16),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                child: AutoSizeText(
                  AppStrings.signIn,
                  style: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s16),
                )),
          ],
        ),
      ),
    );
  }
}
