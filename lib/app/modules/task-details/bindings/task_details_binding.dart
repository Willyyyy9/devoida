import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:get/get.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskDetailsController>(
      () => TaskDetailsController(),
    );
    Get.lazyPut<ProjectDetailsController>(
      () => ProjectDetailsController(),
    );
  }
}
