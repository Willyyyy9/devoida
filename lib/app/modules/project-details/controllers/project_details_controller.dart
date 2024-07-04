import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
import 'package:devoida/app/modules/project-details/network/project_details_network.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ProjectDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = GetIt.instance<FirebaseAuth>();

  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  final editProjectForm = GlobalKey<FormState>();
  final createTaskForm = GlobalKey<FormState>();
  RxList<String> selectedTeams = RxList<String>([]);
  RxString selectedTaskTeam = RxString("");
  RxList<DevoidaUser> users = RxList<DevoidaUser>([]);
  Rx<DevoidaUser?> selectedUser = Rx(null);
  RxString selectedStatus = ''.obs;
  Rx<DateTime?> selectedFromDate = Rx(null);
  Rx<DateTime?> selectedToDate = Rx(null);
  Project? project;
  DevoidaUser? projectCreator;
  RxBool isProjectLoading = false.obs;
  RxBool isProjectError = false.obs;
  late TabController tabController;
  final ScrollController scrollController = ScrollController();
  RxList<ProjectTask> projectTasks = <ProjectTask>[].obs;
  RxBool isLoading = false.obs;
  DocumentSnapshot? lastDocument;
  final int limit = 5;
  RxString selectedFilterTeam = ''.obs;
  bool isLastProjectTask = false;
  List<ProjectTask> allTasks = [];

  Future<void> getProjectTasks() async {
    if (isLastProjectTask == false) {
      if (isLoading.value) return;

      isLoading.value = true;
      update();

      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot;
        if (lastDocument == null) {
          querySnapshot = await ProjectDetailsNetwork().getProjectTasks(
              limit: limit,
              projectId: project!.id,
              team: selectedFilterTeam.value);
        } else {
          querySnapshot = await ProjectDetailsNetwork().getProjectTasks(
              limit: limit,
              projectId: project!.id,
              team: selectedFilterTeam.value,
              startAfter: lastDocument);
        }

        List<ProjectTask> newProjectTasks = querySnapshot.docs
            .map((doc) => ProjectTask.fromJson(doc.data()))
            .toList();

        if (newProjectTasks.isNotEmpty) {
          projectTasks.addAll(newProjectTasks);
          lastDocument = querySnapshot.docs.last;
        }
        if (newProjectTasks.length < limit) {
          isLastProjectTask = true;
        }
      } catch (_) {
      } finally {
        isLoading.value = false;
      }
    }
  }

  void _scrollListener() {
    double threshold = 0.7 * scrollController.position.maxScrollExtent;
    if (scrollController.position.pixels > threshold && !isLoading.value) {
      getProjectTasks();
    }
  }

  Future getProjectById(String projectId) async {
    try {
      isProjectLoading.value = true;
      isProjectError.value = false;

      project = await ProjectDetailsNetwork().getProjectById(projectId);
      if (project != null) {
        await getProjectUser(project!.createdBy);
        await getProjectTasks();
      }
      isProjectLoading.value = false;
    } catch (e) {
      isProjectLoading.value = false;
      isProjectError.value = true;
    }
  }

  Future getProjectUser(String userId) async {
    try {
      isProjectLoading.value = true;
      isProjectError.value = false;

      projectCreator = await ProjectDetailsNetwork().getUser(userId);
      isProjectLoading.value = false;
    } catch (e) {
      isProjectLoading.value = false;
      isProjectError.value = true;
    }
  }

  String formatDate(String dateTimeString) {
    DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm");
    DateTime dateTime = dateTimeFormat.parse(dateTimeString);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String dateOnlyString = dateFormat.format(dateTime);

    return dateOnlyString;
  }

  DateTime? getEarliestStartDate() {
    List<ProjectTask> tasks = List.from(allTasks.sublist(allTasks.length - 4));

    if (tasks.isEmpty) {
      return null;
    }

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime earliestDate = dateFormat.parse(tasks.first.startedDate);

    for (ProjectTask task in tasks) {
      DateTime taskDate = dateFormat.parse(task.startedDate);
      if (taskDate.isBefore(earliestDate)) {
        earliestDate = taskDate;
      }
    }

    return earliestDate;
  }

  Duration calculateDateDifference(ProjectTask task) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    DateTime startDate = dateFormat.parse(task.startedDate);
    DateTime deadlineDate = dateFormat.parse(task.deadlineDate);

    return deadlineDate.difference(startDate);
  }

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

  onRefreshTasks() {
    lastDocument = null;
    isLastProjectTask = false;
    projectTasks.clear();
    getProjectTasks();
  }

  @override
  void onReady() async {
    super.onReady();
    await getProjectById(Get.arguments);
    await getUsers();
    await getAllProjectTasks();
    scrollController.addListener(_scrollListener);
  }

  onRefresh(String projectId) {
    getProjectById(projectId);
  }

  handleProjectResponse() {
    nameTextController.text = project!.title;
    descriptionTextController.text = project!.description;
    selectedTeams.value = project!.teams;
    selectedStatus.value = project!.status;
  }

  updateProject() async {
    try {
      if (editProjectForm.currentState!.validate()) {
        if (selectedTeams.isEmpty) {
          EasyLoading.showError(AppStrings.pleaseSelectTeam);
        } else {
          EasyLoading.show(status: AppStrings.loading);
          project!.title = nameTextController.text;
          project!.description = descriptionTextController.text;
          project!.teams = selectedTeams;
          project!.status = selectedStatus.value;
          if (selectedStatus.value == AttributeString.statusCompleted) {
            project!.endedAt =
                DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
          } else {
            project!.endedAt = "";
          }
          await ProjectDetailsNetwork().updateProject(project!);
          clearValues();
          EasyLoading.dismiss();
          onRefresh(project!.id);
          Get.back();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  Future getUsers() async {
    try {
      users.value = await ProjectDetailsNetwork().getUsers();
    } catch (_) {}
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

  createProjectTask() async {
    try {
      if (createTaskForm.currentState!.validate()) {
        if (selectedTaskTeam.isEmpty) {
          EasyLoading.showError(AppStrings.pleaseSelectTeam);
        } else if (selectedUser.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectAssignee);
        } else if (selectedFromDate.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectStartDate);
        } else if (selectedToDate.value == null) {
          EasyLoading.showError(AppStrings.pleaseSelectEndDate);
        } else {
          EasyLoading.show(status: AppStrings.loading);
          Uuid uuid = const Uuid();
          ProjectTask projectTask = ProjectTask(
              id: uuid.v4(),
              projectId: project!.id,
              assigneeId: selectedUser.value!.id,
              deadlineDate:
                  DateFormat('dd-MM-yyyy HH:mm').format(selectedToDate.value!),
              startedDate: DateFormat('dd-MM-yyyy HH:mm')
                  .format(selectedFromDate.value!),
              title: nameTextController.text,
              description: descriptionTextController.text,
              createdAt: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
              finishedDate: "",
              status: AttributeString.statusNew,
              createdBy: firebaseAuth.currentUser!.uid,
              team: selectedTaskTeam.value);
          await ProjectDetailsNetwork().createProjectTask(projectTask);
          clearValues();
          EasyLoading.dismiss();
          onRefreshTasks();
          Get.back();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  Future<void> getAllProjectTasks() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;

      querySnapshot = await ProjectDetailsNetwork().getAllProjectTasks(
        projectId: project!.id,
      );

      List<ProjectTask> newProjectTasks = querySnapshot.docs
          .map((doc) => ProjectTask.fromJson(doc.data()))
          .toList();
      allTasks = List.from(newProjectTasks);
    } catch (_) {
    } finally {}
  }
}
