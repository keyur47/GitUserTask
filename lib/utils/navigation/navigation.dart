import 'package:get/get.dart';
import 'package:task/modules/gituser/screen/gituser_details_screen.dart';
import 'package:task/modules/history/screen/history_gituser_screen.dart';
import 'package:task/modules/gituser/screen/gituser_screen.dart';
import 'package:task/modules/splash/screen/splash_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String splash = '/splash';
  static const String gitUserScreen = '/gitUserScreen';
  static const String historyGitUserScreen = '/historyGitUserScreen';
  static const String gitUserDetailsScreen = '/gitUserDetailsScreen';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: splash,
      page: () => SplashScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: gitUserScreen,
      page: () => GitUserScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: historyGitUserScreen,
      page: () => const HistoryGitUserScreen(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: gitUserDetailsScreen,
      page: () => const GitUserDetailsScreen(),
      transition: defaultTransition,
    ),
  ];
}
