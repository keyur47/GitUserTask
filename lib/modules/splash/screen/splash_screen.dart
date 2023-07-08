import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/modules/splash/controller/splash_controller.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/utils/size_utils.dart';
import 'package:task/utils/strings_utils.dart';
import 'package:task/widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      body: Center(
        child: AppText(
          text: AppString.gitUserApp,
          fontSize: SizeUtils.fSize_35(),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
