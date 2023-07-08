import 'package:get/get.dart';
import 'package:task/modules/gituser/controller/gituser_controller.dart';
import 'package:task/modules/splash/controller/splash_controller.dart';

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<GitUserController>(GitUserController());
  }
}
