import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/modules/gituser/model/arguments_gituser_details_model.dart';
import 'package:task/utils/app_colors.dart';
import 'package:task/utils/size_utils.dart';
import 'package:task/utils/strings_utils.dart';
import 'package:task/widgets/app_text.dart';
import 'package:task/widgets/custom_appBar.dart';

class GitUserDetailsScreen extends StatefulWidget {
  const GitUserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<GitUserDetailsScreen> createState() => _GitUserDetailsScreenState();
}

class _GitUserDetailsScreenState extends State<GitUserDetailsScreen> {
  late ArgumentsGitUserDetailModel argumentsGitUserDetailModel;

  @override
  void initState() {
    // TODO: implement initState
    argumentsGitUserDetailModel = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.blackColor,
        centerTitle: true,
        leadingIconColor: AppColors.whiteColor,
        title: AppText(
          text: AppString.gitUserDetail,
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeUtils.horizontalBlockSize * 2,
          horizontal: SizeUtils.horizontalBlockSize * 4,
        ),
        child: Column(
          children: [
            SizedBox(
              height: SizeUtils.horizontalBlockSize * 1,
            ),
            customDataBox(
              title: argumentsGitUserDetailModel.title,
              name: argumentsGitUserDetailModel.subTitle,
              image: argumentsGitUserDetailModel.image,
              id: argumentsGitUserDetailModel.id,
            ),
          ],
        ),
      ),
    );
  }

  Widget customDataBox({
    String? image,
    String? name,
    String? title,
    String? id,
  }) {
    return Card(
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(
                      height: SizeUtils.horizontalBlockSize * 1,
                    ),
                    AppText(
                      text: "$id",
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
    );
  }
}
