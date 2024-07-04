import 'package:devoida/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class SplashController extends GetxController {
  FirebaseAuth firebaseAuth = GetIt.instance<FirebaseAuth>();
  checkIfUserLoggedIn() {
    if (firebaseAuth.currentUser != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.ON_BOARDING);
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      checkIfUserLoggedIn();
    });
  }
}
