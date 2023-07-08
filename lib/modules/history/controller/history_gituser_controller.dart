import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task/helper/db_helper.dart';
import 'package:task/helper/toast_helper.dart';
import 'package:task/modules/history/model/history_model.dart';

class HistoryGitUserController extends GetxController {
  RxList<GetGitUserSqDbModel> getGitUserSqDbModel = <GetGitUserSqDbModel>[].obs;
  RxList<GetGitUserSqDbModel> allGetGitUserSqDbModel = <GetGitUserSqDbModel>[].obs;
  RxBool isLoading = false.obs;
  TextEditingController historySearchController = TextEditingController();

  void filterList({String searchTerm = ''}) {
    if (searchTerm.isEmpty) {
      allGetGitUserSqDbModel.assignAll(getGitUserSqDbModel);
    } else {
      allGetGitUserSqDbModel.assignAll(getGitUserSqDbModel
          .where((item) => item.subTitle?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false));
    }
  }

  deleteGitUserDatabase({required String id}) async {
    final db = await initDatabase;
    try {
      await db?.delete(
        'gitUser',
        where: 'id = ?',
        whereArgs: [id],
      );

      AppToast.toastMessage('Deleted!!');
    } catch (e, st) {}
  }
}
