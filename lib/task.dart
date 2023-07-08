import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/utils/app_binding.dart';
import 'package:task/utils/navigation/navigation.dart';
import 'package:task/utils/strings_utils.dart';
import 'package:task/widgets/mybehavior.dart';

class Task extends StatelessWidget {
  const Task({super.key});
  @override
  Widget build(BuildContext context) {
   hideKeyboard(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: Routes.pages,
      initialBinding: AppBidding(),
      title: AppString.appName,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: child,
          ),
        );
      },
    );
  }
  
  void hideKeyboard(BuildContext context) {
    var currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
