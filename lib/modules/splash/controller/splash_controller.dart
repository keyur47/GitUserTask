import 'package:get/get.dart';
import 'package:task/utils/navigation/navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    openScreen();
  }

  void openScreen() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    Get.offAndToNamed(Routes.gitUserScreen);
  }
}
