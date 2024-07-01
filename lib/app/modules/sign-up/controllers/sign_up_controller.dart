import 'package:devoida/app/data/models/devoida_user.dart';
import 'package:devoida/app/modules/sign-up/network/sign_up_network.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class SignUpController extends GetxController {
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassowrdController = TextEditingController();
  RxList<String> selectedTeams = RxList<String>([]);
  final signUpForm = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = GetIt.instance<FirebaseAuth>();

  Future<UserCredential?> createUserCredential() async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        EasyLoading.dismiss();

        EasyLoading.showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        EasyLoading.dismiss();

        EasyLoading.showError('The account already exists for that email.');
      } else {
        EasyLoading.dismiss();

        EasyLoading.showError(AppStrings.internalServerError);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  signUp() async {
    try {
      if (signUpForm.currentState!.validate()) {
        if (selectedTeams.isEmpty) {
          EasyLoading.showError(AppStrings.pleaseSelectTeam);
        } else {
          EasyLoading.show(status: AppStrings.loading);
          UserCredential? userCredential = await createUserCredential();
          if (userCredential != null) {
            DevoidaUser devoidaUser = DevoidaUser(
                id: userCredential.user!.uid,
                name: fullNameController.text,
                email: emailController.text,
                image: "",
                teams: selectedTeams,
                createdAt: DateFormat('dd-MM-yyy').format(DateTime.now()));
            await SignUpNetwork().signUp(devoidaUser);
            clearValues();
            Get.offAllNamed(Routes.HOME);
            EasyLoading.dismiss();
          }
        }
      }
    } catch (e) {
      EasyLoading.dismiss();

      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  clearValues() {
    emailController.clear();
    selectedTeams.clear();
    passwordController.clear();
    confirmPassowrdController.clear();
    fullNameController.clear();
  }
}
