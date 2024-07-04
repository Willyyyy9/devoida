import 'package:devoida/app/resources/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<SplashController>(builder: (controller) {
        return Center(
          child: Image.asset(ImageAssets.devoida),
        );
      }),
    );
  }
}
