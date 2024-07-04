import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/modules/project-details/controllers/project_details_controller.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
import 'package:devoida/app/modules/task-details/network/task_details_network.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskDetailsController extends GetxController {
  ProjectTask? projectTask;
  DevoidaUser? taskCreator;
  DevoidaUser? taskAssignee;
  RxBool isProjectTaskLoading = false.obs;
  RxBool isProjectTaskError = false.obs;
  RxList<DevoidaUser> users = RxList<DevoidaUser>([]);
  Rx<DevoidaUser?> selectedUser = Rx(null);

  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  final editProjectForm = GlobalKey<FormState>();
  final editTaskForm = GlobalKey<FormState>();
  RxList<String> selectedTeams = RxList<String>([]);
  RxString selectedTaskTeam = RxString("");
  RxString selectedStatus = ''.obs;
  Rx<DateTime?> selectedFromDate = Rx(null);
  Rx<DateTime?> selectedToDate = Rx(null);
  ProjectDetailsController? projectDetailsController;

  Future getTaskById(String projectTaskId) async {
    try {
      isProjectTaskLoading.value = true;
      isProjectTaskError.value = false;

      projectTask = await TaskDetailsNetwork().getTaskById(projectTaskId);
      if (projectTask != null) {
        taskCreator = await getTaskUser(projectTask!.createdBy);
        taskAssignee = await getTaskUser(projectTask!.assigneeId);
      }
      isProjectTaskLoading.value = false;
    } catch (e) {
      isProjectTaskLoading.value = false;
      isProjectTaskError.value = true;
    }
  }

  Future<DevoidaUser?> getTaskUser(String userId) async {
    try {
      isProjectTaskLoading.value = true;
      isProjectTaskError.value = false;

      DevoidaUser? user = await TaskDetailsNetwork().getUser(userId);
      isProjectTaskLoading.value = false;
      return user;
    } catch (e) {
      isProjectTaskLoading.value = false;
      isProjectTaskError.value = true;
      return null;
    }
  }

  Future getUsers() async {
    try {
      users.value = await TaskDetailsNetwork().getUsers();
    } catch (_) {}
  }

  String formatDate(String dateTimeString) {
    DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm");
    DateTime dateTime = dateTimeFormat.parse(dateTimeString);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String dateOnlyString = dateFormat.format(dateTime);

    return dateOnlyString;
  }

  handleTaskResponse() {
    nameTextController.text = projectTask!.title;
    descriptionTextController.text = projectTask!.description;
    selectedTaskTeam.value = projectTask!.team;
    selectedStatus.value = projectTask!.status;
    selectedUser.value = users.firstWhereOrNull(
      (element) => element.id == projectTask?.assigneeId,
    );
    DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm");
    selectedFromDate.value = dateTimeFormat.parse(projectTask!.startedDate);
    selectedToDate.value = dateTimeFormat.parse(projectTask!.deadlineDate);
  }

  clearValues() {
    nameTextController.clear();
    descriptionTextController.clear();
    selectedTeams.clear();
    selectedStatus.value = "";
    selectedTaskTeam.value = "";
    selectedFromDate.value = null;
    selectedToDate.value = null;
    selectedUser.value = null;
  }

  editTask() async {
    try {
      if (editTaskForm.currentState!.validate()) {
        if (selectedTaskTeam.isEmpty) {
          EasyLoading.showError(AppStrings.pleaseSelectTeam);
        } else if (selectedUser.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectAssignee);
        } else if (selectedUser.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectAssignee);
        } else if (selectedFromDate.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectStartDate);
        } else if (selectedToDate.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectEndDate);
        } else {
          EasyLoading.show(status: AppStrings.loading);
          projectTask!.assigneeId = selectedUser.value!.id;
          projectTask!.deadlineDate =
              DateFormat('dd-MM-yyyy HH:mm').format(selectedToDate.value!);
          projectTask!.startedDate =
              DateFormat('dd-MM-yyyy HH:mm').format(selectedFromDate.value!);
          projectTask!.title = nameTextController.text;
          projectTask!.description = descriptionTextController.text;
          projectTask!.status = selectedStatus.value;
          projectTask!.team = selectedTaskTeam.value;

          if (selectedStatus.value == AttributeString.statusCompleted) {
            projectTask!.finishedDate =
                DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
            sendTaskUpdateEmail();
          } else if (selectedStatus.value == AttributeString.statusInProgress) {
            sendTaskUpdateEmail();
          } else {
            projectTask!.finishedDate = "";
          }

          await TaskDetailsNetwork().editTask(projectTask!);
          clearValues();
          EasyLoading.dismiss();
          projectDetailsController!.onRefreshTasks();
          onRefresh(projectTask!.id);
          Get.back();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  onRefresh(String taskId) {
    getTaskById(taskId);
  }

  Future sendTaskUpdateEmail() async {
    TaskDetailsNetwork().sendTaskCompleteEmail(
        email: taskCreator!.email,
        subject: "Task ${projectTask!.title} ${projectTask!.status}",
        message: "The ${projectTask!.title} is ${projectTask!.status} today");
  }

  @override
  void onInit() {
    if (!Get.isRegistered<ProjectDetailsController>()) {
      Get.put(() => ProjectDetailsController());
    }
    projectDetailsController = Get.find<ProjectDetailsController>();
    super.onInit();
  }

  @override
  void onReady() async {
    await getTaskById(Get.arguments);
    await getUsers();
    super.onReady();
  }
}
