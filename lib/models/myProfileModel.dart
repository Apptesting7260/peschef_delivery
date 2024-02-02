// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) =>
    MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  bool? status;
  String? message;
  Profile? profile;

  MyProfileModel({
    this.status,
    this.message,
    this.profile,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
        status: json["status"],
        message: json["message"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profile": profile?.toJson(),
      };
}

class Profile {
  String? name;
  String? email;
  String? password;
  String? mobile;
  String? countryCode;
  String? image;
  String? address;
  String? gender;

  Profile({
    this.name,
    this.email,
    this.password,
    this.mobile,
    this.countryCode,
    this.image,
    this.address,
    this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
        image: json["image"],
        address: json["address"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "mobile": mobile,
        "country_code": countryCode,
        "image": image,
        "address": address,
        "gender": gender,
      };
}
