import 'package:devoida/app/resources/asset_manager.dart';
import 'package:devoida/app/resources/string_manager.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  int contentIndex = 0;
  List<String> titles = [
    AppStrings.onBoardingTitleOne,
    AppStrings.onBoardingTitleTwo,
    AppStrings.onBoardingTitleThree,
  ];
  List<String> subtitles = [
    AppStrings.onBoardingSubitleOne,
    AppStrings.onBoardingSubitleTwo,
    AppStrings.onBoardingSubitleThree,
  ];
  List<String> images = [
    ImageAssets.onBoardingOne,
    ImageAssets.onBoardingTwo,
    ImageAssets.onBoardingThree,
  ];
}
