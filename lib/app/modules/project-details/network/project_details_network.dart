import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/modules/project-details/models/project_details.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:get_it/get_it.dart';

class ProjectDetailsNetwork {
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance<FirebaseFirestore>();

  Future<Project> getProjectById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _firebaseFirestore
              .collection(AttributeString.projectsCollection)
              .doc(id)
              .get();

      return Project.fromJson(docSnapshot.data()!);
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

  Future updateProject(Project project) async {
    try {
      await _firebaseFirestore
          .collection(AttributeString.projectsCollection)
          .doc(project.id)
          .update(project.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future createProjectTask(ProjectTask projectTask) async {
    try {
      await _firebaseFirestore
          .collection(AttributeString.tasksCollection)
          .doc(projectTask.id)
          .set(projectTask.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProjectTasks(
      {int? limit,
      String? team,
      required String projectId,
      DocumentSnapshot? startAfter}) async {
    try {
      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection(AttributeString.tasksCollection)
          .where('projectId', isEqualTo: projectId)
          .orderBy('createdAt', descending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (team != null && team.isNotEmpty) {
        query = query.where('team', isEqualTo: team);
      }

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllProjectTasks({
    required String projectId,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection(AttributeString.tasksCollection)
          .where('projectId', isEqualTo: projectId);

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
