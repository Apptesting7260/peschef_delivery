// To parse this JSON data, do
//
//     final declineOrderModel = declineOrderModelFromJson(jsonString);

import 'dart:convert';

DeclineOrderModel declineOrderModelFromJson(String str) =>
    DeclineOrderModel.fromJson(json.decode(str));

String declineOrderModelToJson(DeclineOrderModel data) =>
    json.encode(data.toJson());

class DeclineOrderModel {
  bool? status;
  String? message;

  DeclineOrderModel({
    this.status,
    this.message,
  });

  factory DeclineOrderModel.fromJson(Map<String, dynamic> json) =>
      DeclineOrderModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
