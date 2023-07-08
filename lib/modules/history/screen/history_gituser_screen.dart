import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/modules/gituser/model/arguments_gituser_details_model.dart';
import 'package:task/modules/history/controller/history_gituser_controller.dart';
import 'package:task/modules/gituser/controller/gituser_controller.dart';
import 'package:task/utils/navigation/navigation.dart';
import 'package:task/utils/size_utils.dart';
import 'package:task/utils/strings_utils.dart';
import 'package:task/widgets/app_text.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/widgets/custom_appBar.dart';
import 'package:task/widgets/custom_textfield.dart';

class HistoryGitUserScreen extends StatefulWidget {
  const HistoryGitUserScreen({Key? key}) : super(key: key);

  @override
  State<HistoryGitUserScreen> createState() => _HistoryGitUserScreenState();
}

class _HistoryGitUserScreenState extends State<HistoryGitUserScreen> {
  GitUserController gitUserController = Get.find();
  HistoryGitUserController historyGitUserController = Get.put(HistoryGitUserController());

  @override
  void initState() {
    // TODO: implement initState
    getAllDatabase();
    super.initState();
  }

  getAllDatabase() async {
    await gitUserController.getGitUserDatabase();
    historyGitUserController.getGitUserSqDbModel.clear();
    for (var element in gitUserController.getGitUserSqDbModel) {
      historyGitUserController.getGitUserSqDbModel.add(element);
    }
    historyGitUserController.filterList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        centerTitle: true,
        leadingIconColor: AppColors.whiteColor,
        title: AppText(
          text: AppString.history,
          color: AppColors.whiteColor,
        ),
      ),
      body: Obx(
        () => gitUserController.getGitUserSqDbModel.isEmpty
            ? Center(
                child: AppText(
                  text: "No available history",
                  fontSize: SizeUtils.fSize_15(),
                  color: AppColors.blackColor,
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeUtils.horizontalBlockSize * 2,
                  horizontal: SizeUtils.horizontalBlockSize * 4,
                ),
                child: Column(
                  children: [
                    SizedBox(height: SizeUtils.horizontalBlockSize * 3),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 1.5,
                      ),
                      child: CustomTextField(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: historyGitUserController.historySearchController,
                        hintText: AppString.search,
                        onChanged: (value) {
                          historyGitUserController.filterList(searchTerm: value);
                        },
                        onSubmitted: (value) {
                          historyGitUserController.filterList(searchTerm: value);
                        },
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            top: 3,
                          ),
                          child: Icon(
                            Icons.search,
                            size: 23,
                            color: AppColors.blackColor,
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () async {
                            historyGitUserController.historySearchController.clear();
                            historyGitUserController.filterList(
                                searchTerm: historyGitUserController.historySearchController.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 3,
                            ),
                            child: Icon(
                              Icons.clear,
                              size: 23,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeUtils.horizontalBlockSize * 1,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: SizeUtils.horizontalBlockSize * 2,
                        ),
                        itemCount: historyGitUserController.allGetGitUserSqDbModel.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var data = historyGitUserController.allGetGitUserSqDbModel[index];
                          return customDataBox(
                            onTap: () {
                              ArgumentsGitUserDetailModel model = ArgumentsGitUserDetailModel(
                                id: data.id,
                                title: data.title,
                                image: data.image,
                                subTitle: data.subTitle,
                              );
                              Get.toNamed(
                                Routes.gitUserDetailsScreen,
                                arguments: model,
                              );
                            },
                            deleteOnTap: () async {
                              await historyGitUserController.deleteGitUserDatabase(
                                id: data.id.toString() ?? "0",
                              );
                              await getAllDatabase();
                            },
                            name: "${data.subTitle}",
                            title: "${data.title}",
                            image: "${data.image}",
                          );
                        },
                      )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget customDataBox({
    String? image,
    String? name,
    String? title,
    GestureTapCallback? onTap,
    GestureTapCallback? deleteOnTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeUtils.horizontalBlockSize * 1.6,
              horizontal: SizeUtils.horizontalBlockSize * 1.6,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundColor: AppColors.blackColor,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "$image",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "$name",
                        fontSize: SizeUtils.fSize_15(),
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                      SizedBox(
                        height: SizeUtils.horizontalBlockSize * 0.6,
                      ),
                      AppText(
                        text: "$title",
                        maxLines: 1,
                        fontSize: SizeUtils.fSize_13(),
                        color: AppColors.blackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 2,
                ),
                GestureDetector(
                  onTap: deleteOnTap,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 3,
                    ),
                    child: Icon(
                      Icons.clear,
                      size: 25,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: SizeUtils.horizontalBlockSize * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
