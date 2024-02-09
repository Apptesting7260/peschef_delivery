// To parse this JSON data, do
//
//     final orderPickedModel = orderPickedModelFromJson(jsonString);

import 'dart:convert';

OrderPickedModel orderPickedModelFromJson(String str) =>
    OrderPickedModel.fromJson(json.decode(str));

String orderPickedModelToJson(OrderPickedModel data) =>
    json.encode(data.toJson());

class OrderPickedModel {
  bool? status;
  String? message;

  OrderPickedModel({
    this.status,
    this.message,
  });

  factory OrderPickedModel.fromJson(Map<String, dynamic> json) =>
      OrderPickedModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
