import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/modules/home/models/project.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:get_it/get_it.dart';

class HomeNetwork {
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance<FirebaseFirestore>();

  Future createProject(Project project) async {
    try {
      await _firebaseFirestore
          .collection(AttributeString.projectsCollection)
          .doc(project.id)
          .set(project.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProjects(
      {int? limit, String? team, DocumentSnapshot? startAfter}) async {
    try {
      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection(AttributeString.projectsCollection)
          .orderBy('createdAt', descending: true);

      if (limit != null) {
        query = query.limit(limit);
      }

      if (team != null && team.isNotEmpty) {
        query = query.where('teams', arrayContains: team);
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
}
