import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class TaskDetailsNetwork {
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance<FirebaseFirestore>();

  Future<ProjectTask> getTaskById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firebaseFirestore
              .collection(AttributeString.tasksCollection)
              .doc(id)
              .get();

      return ProjectTask.fromJson(docSnapshot.data()!);
    } catch (e) {
      rethrow;
    }
  }

  Future<DevoidaUser> getUser(String id) async {
    DocumentSnapshot documentSnapshot = await _firebaseFirestore
        .collection(AttributeString.usersCollection)
        .doc(id)
        .get();

    return DevoidaUser.fromJson(
        documentSnapshot.data() as Map<String, dynamic>);
  }

  Future<List<DevoidaUser>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection(AttributeString.usersCollection)
        .get();

    List<DevoidaUser> users = querySnapshot.docs
        .map((object) => DevoidaUser.fromJson(object.data()))
        .toList();
    return users;
  }

  Future editTask(ProjectTask projectTask) async {
    try {
      await _firebaseFirestore
          .collection(AttributeString.tasksCollection)
          .doc(projectTask.id)
          .set(projectTask.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future sendTaskCompleteEmail(
      {required String email,
      required String subject,
      required String message}) async {
    String serviceId = 'service_9bek9j6';
    String templateId = 'template_f0vkfd3';
    String userId = 'uUZVP6RlpgqQTi9RY';
    String accessToken = '261nPStm1BEU3GuR0CXIM';
    final dio = Dio();

    await dio.post("https://api.emailjs.com/api/v1.0/email/send",
        options: Options(headers: {
          'origin': 'http://localhost',
          'Content-Type': "application/json",
        }),
        data: jsonEncode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'accessToken': accessToken,
          'template_params': {
            "user_name": "Task Completed",
            "user_subject": subject,
            "user_email": email,
            "user_message": message,
          }
        }));
  }
}
