// To parse this JSON data, do
//
//     final orderAcceptModel = orderAcceptModelFromJson(jsonString);

import 'dart:convert';

OrderAcceptModel orderAcceptModelFromJson(String str) =>
    OrderAcceptModel.fromJson(json.decode(str));

String orderAcceptModelToJson(OrderAcceptModel data) =>
    json.encode(data.toJson());

class OrderAcceptModel {
  bool? status;
  String? message;

  OrderAcceptModel({
    this.status,
    this.message,
  });

  factory OrderAcceptModel.fromJson(Map<String, dynamic> json) =>
      OrderAcceptModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
