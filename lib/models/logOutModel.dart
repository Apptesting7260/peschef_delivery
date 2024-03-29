// To parse this JSON data, do
//
//     final logOutModel = logOutModelFromJson(jsonString);

import 'dart:convert';

LogOutModel logOutModelFromJson(String str) =>
    LogOutModel.fromJson(json.decode(str));

String logOutModelToJson(LogOutModel data) => json.encode(data.toJson());

class LogOutModel {
  bool? status;
  String? message;

  LogOutModel({
    this.status,
    this.message,
  });

  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
