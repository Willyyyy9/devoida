import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:get_it/get_it.dart';

class SignUpNetwork {
  final FirebaseFirestore _firebaseFirestore =
      GetIt.instance<FirebaseFirestore>();

  Future signUp(DevoidaUser user) async {
    try {
      await _firebaseFirestore
          .collection(AttributeString.usersCollection)
          .doc(user.id)
          .set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
