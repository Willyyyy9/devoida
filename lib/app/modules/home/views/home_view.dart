import 'package:devoida/app/common/empty_state.dart';
import 'package:devoida/app/modules/home/views/widgets/filter/project_filter.dart';
import 'package:devoida/app/modules/home/views/widgets/floating-button/home_floating_button.dart';
import 'package:devoida/app/modules/home/views/widgets/list/project_item.dart';
import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () {
              controller.logout();
            },
            child: const Padding(
              padding: EdgeInsets.all(AppPadding.p8),
              child: Icon(FontAwesomeIcons.arrowRightFromBracket),
            ),
          )
        ],
      ),
      floatingActionButton: const HomeFloatingButton(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            const ProjectFilter(),
            Obx(
              () => controller.isLoading.value == false &&
                      controller.projects.isEmpty
                  ? const Expanded(
                      child: Center(
                      child: EmptyState(
                        title: AppStrings.noProjectFound,
                        subtitle: AppStrings.noProjectFoundSubtitle,
                      ),
                    ))
                  : controller.isLoading.value && controller.projects.isEmpty
                      ? const Expanded(
                          child: Center(
                          child: CircularProgressIndicator(),
                        ))
                      : Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  controller: controller.scrollController,
                                  shrinkWrap: true,
                                  itemCount: controller.projects.length,
                                  itemBuilder: (context, index) {
                                    return ProjectItem(
                                        controller.projects[index]);
                                  },
                                ),
                              ),
                              if (controller.isLoading.value)
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
