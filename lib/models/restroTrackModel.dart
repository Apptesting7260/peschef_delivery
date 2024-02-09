// To parse this JSON data, do
//
//     final restroTrackModel = restroTrackModelFromJson(jsonString);

import 'dart:convert';

RestroTrackModel restroTrackModelFromJson(String str) =>
    RestroTrackModel.fromJson(json.decode(str));

String restroTrackModelToJson(RestroTrackModel data) =>
    json.encode(data.toJson());

class RestroTrackModel {
  bool? status;
  String? message;
  ResturantDetails? resturantDetails;

  RestroTrackModel({
    this.status,
    this.message,
    this.resturantDetails,
  });

  factory RestroTrackModel.fromJson(Map<String, dynamic> json) =>
      RestroTrackModel(
        status: json["status"],
        message: json["message"],
        resturantDetails: json["resturant_details"] == null
            ? null
            : ResturantDetails.fromJson(json["resturant_details"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resturant_details": resturantDetails?.toJson(),
      };
}

class ResturantDetails {
  String? address;
  double? latitude;
  double? longitude;

  ResturantDetails({
    this.address,
    this.latitude,
    this.longitude,
  });

  factory ResturantDetails.fromJson(Map<String, dynamic> json) =>
      ResturantDetails(
        address: json["address"],
        latitude: json["Latitude"]?.toDouble(),
        longitude: json["Longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
