import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthenticationService {
  FirebaseAuth firebaseAuth = GetIt.instance<FirebaseAuth>();
  FirebaseFirestore firebaseFirestore = GetIt.instance<FirebaseFirestore>();
  DevoidaUser? currentUser;

  getCurrentUser() async {
    if (firebaseAuth.currentUser != null) {
      DocumentSnapshot documentSnapshot = await firebaseFirestore
          .collection(AttributeString.usersCollection)
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      currentUser =
          DevoidaUser.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    }
  }

  Future<DevoidaUser> getUser(String id) async {
    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection(AttributeString.usersCollection)
        .doc(id)
        .get();

    return DevoidaUser.fromJson(
        documentSnapshot.data() as Map<String, dynamic>);
  }
}
