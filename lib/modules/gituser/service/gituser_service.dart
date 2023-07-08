import 'dart:convert';
import 'dart:developer';

import 'package:task/helper/network_helper.dart';
import 'package:task/modules/gituser/model/gituser_model.dart';
import 'package:task/utils/app_config.dart';

class GitUserService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  static Future<List<GitUserModel>> gitUser() async {
    try {
      var headers = {'Accept': 'application/vnd.github+json', 'Authorization': 'Bearer ${AppConfig.token}'};
      final result = await _networkAPICall.get(
        AppConfig.gitUser,
        header: headers,
      );
      return gitUserFromJson(jsonEncode(result));
    } catch (e, st) {
      rethrow;
    }
  }
}
