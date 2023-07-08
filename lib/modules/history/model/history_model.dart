import 'dart:convert';

GetGitUserSqDbModel getCartSqDbModelFromJson(String str) => GetGitUserSqDbModel.fromJson(json.decode(str));

String getCartSqDbModelToJson(GetGitUserSqDbModel data) => json.encode(data.toJson());

class GetGitUserSqDbModel {
  String? title;
  String? subTitle;
  String? image;
  String? id;

  GetGitUserSqDbModel({
    this.title,
    this.image,
    this.subTitle,
    this.id,
  });

  factory GetGitUserSqDbModel.fromJson(Map<String, dynamic> json) => GetGitUserSqDbModel(
        id: json["Id"],
        subTitle: json["subTitle"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "subTitle": subTitle,
        "title": title,
        "image": image,
      };
}
