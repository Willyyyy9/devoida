import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/modules/home/network/home_network.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final FirebaseAuth _firebaseAuth = GetIt.instance<FirebaseAuth>();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  final createProjectForm = GlobalKey<FormState>();
  RxList<String> selectedTeams = RxList<String>([]);
  final ScrollController scrollController = ScrollController();
  RxList<Project> projects = <Project>[].obs;
  RxBool isLoading = false.obs;
  DocumentSnapshot? lastDocument;
  final int limit = 5;
  RxString selectedFilterTeam = ''.obs;
  bool isLastProject = false;

  logout() {
    _firebaseAuth.signOut();
    Get.offAllNamed(Routes.ON_BOARDING);
  }

  createProject() async {
    try {
      if (createProjectForm.currentState!.validate()) {
        if (selectedTeams.isEmpty) {
          EasyLoading.showError(AppStrings.pleaseSelectTeam);
        } else {
          EasyLoading.show(status: AppStrings.loading);
          Uuid uuid = const Uuid();
          Project project = Project(
              id: uuid.v4(),
              title: nameTextController.text,
              description: descriptionTextController.text,
              createdAt: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
              endedAt: "",
              status: AttributeString.statusNew,
              createdBy: _firebaseAuth.currentUser!.uid,
              teams: selectedTeams);
          await HomeNetwork().createProject(project);
          clearValues();
          EasyLoading.dismiss();
          onRefresh();
          Get.back();
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  clearValues() {
    nameTextController.clear();
    descriptionTextController.clear();
    selectedTeams.clear();
  }

  Future<void> getProjects() async {
    if (isLastProject == false) {
      if (isLoading.value) return;

      isLoading.value = true;
      update();

      try {
        QuerySnapshot<Map<String, dynamic>> querySnapshot;
        if (lastDocument == null) {
          querySnapshot = await HomeNetwork()
              .getProjects(limit: limit, team: selectedFilterTeam.value);
        } else {
          querySnapshot = await HomeNetwork().getProjects(
              limit: limit,
              team: selectedFilterTeam.value,
              startAfter: lastDocument);
        }

        List<Project> newProjects = querySnapshot.docs
            .map((doc) => Project.fromJson(doc.data()))
            .toList();

        if (newProjects.isNotEmpty) {
          projects.addAll(newProjects);
          lastDocument = querySnapshot.docs.last;
        }
        if (newProjects.length < limit) {
          isLastProject = true;
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
      getProjects();
    }
  }

  onRefresh() {
    lastDocument = null;
    isLastProject = false;
    projects.clear();
    getProjects();
  }

  @override
  void onReady() {
    getProjects();
    scrollController.addListener(_scrollListener);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  String formatDate(String dateTimeString) {
    // Parse the date-time string
    DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy HH:mm");
    DateTime dateTime = dateTimeFormat.parse(dateTimeString);

    // Format to date only
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String dateOnlyString = dateFormat.format(dateTime);

    return dateOnlyString;
  }
}
