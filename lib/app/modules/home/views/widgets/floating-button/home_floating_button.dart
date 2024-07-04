import 'package:devoida/app/modules/home/controllers/home_controller.dart';
import 'package:devoida/app/modules/home/views/widgets/create-project/create_project_bottomsheet.dart';
import 'package:devoida/app/resources/color_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeFloatingButton extends StatelessWidget {
  const HomeFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return FloatingActionButton(
        backgroundColor: ColorManager.transparent,
        shape: const CircleBorder(),
        child: Container(
          width: AppSize.s60,
          height: AppSize.s60,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue])),
          child: Icon(
            FontAwesomeIcons.plus,
            color: ColorManager.white,
          ),
        ),
        onPressed: () {
          Get.bottomSheet(const CreateProjectBottomsheet(),
              enableDrag: false, isScrollControlled: true);
        },
      );
    });
  }
}
