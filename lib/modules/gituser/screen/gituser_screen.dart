import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/modules/gituser/controller/gituser_controller.dart';
import 'package:task/modules/gituser/model/arguments_gituser_details_model.dart';
import 'package:task/modules/gituser/model/gituser_model.dart';
import 'package:task/utils/assets.dart';
import 'package:task/utils/navigation/navigation.dart';
import 'package:task/utils/size_utils.dart';
import 'package:task/utils/strings_utils.dart';
import 'package:task/widgets/app_text.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/widgets/custom_appBar.dart';
import 'package:task/widgets/custom_textfield.dart';

class GitUserScreen extends StatefulWidget {
  const GitUserScreen({Key? key}) : super(key: key);

  @override
  State<GitUserScreen> createState() => _GitUserScreenState();
}

class _GitUserScreenState extends State<GitUserScreen> {
  GitUserController gitUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        automaticallyImplyLeading: false,
        title: AppText(
          text: AppString.gitUser,
          color: AppColors.whiteColor,
        ),
      ),
      body: Obx(
        () => Padding(
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
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller: gitUserController.searchController,
                        hintText: AppString.search,
                        onChanged: (value) {
                          gitUserController.filterList(searchTerm: value);
                        },
                        onSubmitted: (value) {
                          gitUserController.filterList(searchTerm: value);
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
                            gitUserController.searchController.clear();
                            gitUserController.filterList(searchTerm: gitUserController.searchController.text);
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
                      width: SizeUtils.horizontalBlockSize * 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.historyGitUserScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 2,
                        ),
                        child: Icon(
                          Icons.history,
                          size: 25,
                          color: AppColors.redColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeUtils.horizontalBlockSize * 1,
              ),
              gitUserController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blackColor,
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: SizeUtils.horizontalBlockSize * 2,
                          ),
                          itemCount: gitUserController.allGitUserModel.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = gitUserController.allGitUserModel[index].user;
                            return customDataBox(
                              onTap: () {
                                if (gitUserController.searchController.text.isNotEmpty) {
                                  gitUserController.insertGitUserData(
                                    id: gitUserController.allGitUserModel[index].id.toString(),
                                    title: gitUserController.allGitUserModel[index].title,
                                    image: data?.avatarUrl,
                                    subTitle: data?.login,
                                  );
                                }
                                ArgumentsGitUserDetailModel model = ArgumentsGitUserDetailModel(
                                  id: gitUserController.allGitUserModel[index].id.toString(),
                                  title: gitUserController.allGitUserModel[index].title,
                                  image: data?.avatarUrl,
                                  subTitle: data?.login,
                                );
                                Get.toNamed(
                                  Routes.gitUserDetailsScreen,
                                  arguments: model,
                                );
                              },
                              name: "${data?.login}",
                              title: "${gitUserController.allGitUserModel[index].title}",
                              image: "${data?.avatarUrl}",
                            );
                          },
                        ),
                      ),
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
                Flexible(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
