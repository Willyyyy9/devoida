import 'package:auto_size_text/auto_size_text.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/font_manager.dart';
import 'package:devoida/app/resources/style_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image});
  final String title;
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
      width: MediaQuery.sizeOf(context).width - 32,
      child: Column(
        children: [
          Expanded(
              child: Container(
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
              child: Image.asset(image),
            ),
          )),
          const Gap(AppSize.s16),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p16,
            ),
            child: Column(
              children: [
                AutoSizeText(
                  title,
                  maxLines: 3,
                  style: getBoldStyle(
                      color: ColorManager.black, fontSize: FontSize.s22),
                ),
                const Gap(AppSize.s10),
                Expanded(
                  child: AutoSizeText(
                    subtitle,
                    style: getRegularStyle(
                        color: ColorManager.lightGrey, fontSize: FontSize.s16),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
