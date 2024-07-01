import 'package:devoida/app/data/authentication-utils/authentication_service.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:devoida/app/routes/app_pages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = true.obs;
  final signInForm = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = GetIt.instance<FirebaseAuth>();
  final AuthenticationService _authenticationService =
      GetIt.instance<AuthenticationService>();

  signIn() async {
    try {
      if (signInForm.currentState!.validate()) {
        EasyLoading.show(status: AppStrings.loading);

        await _firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await _authenticationService.getCurrentUser();

        clearValues();
        EasyLoading.dismiss();
        Get.offAllNamed(Routes.HOME);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        EasyLoading.dismiss();
        EasyLoading.showError('No user found for that email.');
      } else if (e.code == 'invalid-credential') {
        EasyLoading.dismiss();
        EasyLoading.showError('Wrong password provided for that user.');
      } else {
        EasyLoading.dismiss();

        EasyLoading.showError(AppStrings.internalServerError);
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }

  clearValues() {
    emailController.clear();
    passwordController.clear();
  }

  resetPassword() async {
    try {
      if (EmailValidator.validate(emailController.text)) {
        EasyLoading.show(status: AppStrings.loading);

        await _firebaseAuth.sendPasswordResetEmail(
          email: emailController.text,
        );

        EasyLoading.dismiss();
        EasyLoading.showSuccess(AppStrings.resetPasswordEmailSent);
      } else {
        EasyLoading.showError(AppStrings.enterValidEmail);
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.message ?? "");
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AppStrings.internalServerError);
    }
  }
}
