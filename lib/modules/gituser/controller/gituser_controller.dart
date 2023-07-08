import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/helper/db_helper.dart';
import 'package:task/modules/gituser/model/gituser_model.dart';
import 'package:task/modules/history/model/history_model.dart';
import 'package:task/modules/gituser/service/gituser_service.dart';

class GitUserController extends GetxController {
  RxList<GitUserModel> allGitUserModel = <GitUserModel>[].obs;
  RxList<GitUserModel> gitUserModel = <GitUserModel>[].obs;
  RxList<GetGitUserSqDbModel> getGitUserSqDbModel = <GetGitUserSqDbModel>[].obs;
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    gitUserData();
    super.onInit();
  }

  Future<void> insertGitUserData({
    String? title,
    String? subTitle,
    String? image,
    String? id,
  }) async {
    try {
      final db = await initDatabase;
      final batch = db?.batch();
      batch?.insert(
        'gitUser',
        {
          'id': id,
          'image': image,
          'title': title,
          'subTitle': subTitle,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await batch?.commit();
      await getGitUserDatabase();
    } catch (e, st) {}
  }

  Future<List<Map<String, dynamic>>> getGitUserDatabase() async {
    try {
      final db = await initDatabase;
      final List<Map<String, dynamic>> gitUser = await db!.query('gitUser');
      getGitUserSqDbModel.clear();

      for (var data in gitUser) {

        GetGitUserSqDbModel getGitUserSqDb = GetGitUserSqDbModel(
          subTitle: data["subTitle"],
          title: data["title"],
          id: data["id"],
          image: data["image"],
        );
        getGitUserSqDbModel.add(getGitUserSqDb);
      }
      return gitUser.toList();
    } catch (e, st) {
      return [];
    }
  }

  void filterList({String searchTerm = ''}) {
    if (searchTerm.isEmpty) {
      allGitUserModel.assignAll(gitUserModel);
    } else {
      allGitUserModel.assignAll(
          gitUserModel.where((item) => item.user?.login?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false));
    }
  }

  Future gitUserData() async {
    try {
      isLoading.value = true;
      gitUserModel.value = await GitUserService.gitUser();
      filterList();
      isLoading.value = false;
    } catch (e, st) {
    } finally {
      isLoading.value = false;
    }
  }
}
