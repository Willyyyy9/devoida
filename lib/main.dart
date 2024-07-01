import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devoida/app/common/my_app.dart';
import 'package:devoida/app/data/authentication-utils/authentication_service.dart';
import 'package:devoida/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.I.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  GetIt.I.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  GetIt.I.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  GetIt.I.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  AuthenticationService authenticationService =
      GetIt.instance<AuthenticationService>();
  await authenticationService.getCurrentUser();
  runApp(MyApp());
}
