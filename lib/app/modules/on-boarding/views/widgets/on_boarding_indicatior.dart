import 'package:devoida/app/modules/on-boarding/controllers/on_boarding_controller.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingIndicator extends GetView<OnBoardingController> {
  const OnBoardingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (controller) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              width: controller.contentIndex == 0 ? AppSize.s32 : AppSize.s10,
              height: AppSize.s10,
              decoration: BoxDecoration(
                  shape: controller.contentIndex == 0
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: controller.contentIndex == 0
                      ? BorderRadius.circular(AppSize.s10)
                      : null,
                  color: controller.contentIndex == 0
                      ? ColorManager.black
                      : ColorManager.grey),
            ),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              width: controller.contentIndex == 1 ? AppSize.s32 : AppSize.s10,
              height: AppSize.s10,
              decoration: BoxDecoration(
                  shape: controller.contentIndex == 1
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: controller.contentIndex == 1
                      ? BorderRadius.circular(AppSize.s10)
                      : null,
                  color: controller.contentIndex == 1
                      ? ColorManager.black
                      : ColorManager.grey),
            ),
            Container(
              margin: const EdgeInsets.all(AppMargin.m8),
              width: controller.contentIndex == 2 ? AppSize.s32 : AppSize.s10,
              height: AppSize.s10,
              decoration: BoxDecoration(
                  shape: controller.contentIndex == 2
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  borderRadius: controller.contentIndex == 2
                      ? BorderRadius.circular(AppSize.s10)
                      : null,
                  color: controller.contentIndex == 2
                      ? ColorManager.black
                      : ColorManager.grey),
            ),
          ],
        ),
      );
    });
  }
}
