// To parse this JSON data, do
//
//     final userUpdateModel = userUpdateModelFromJson(jsonString);

import 'dart:convert';

UserUpdateModel userUpdateModelFromJson(String str) => UserUpdateModel.fromJson(json.decode(str));

String userUpdateModelToJson(UserUpdateModel data) => json.encode(data.toJson());

class UserUpdateModel {
  UserUpdateModel({
    this.name,
    this.job,
    this.updatedAt,
  });

  String? name;
  String? job;
  DateTime? updatedAt;

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) => UserUpdateModel(
        name: json["name"],
        job: json["job"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "job": job,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
