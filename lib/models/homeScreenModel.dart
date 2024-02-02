// To parse this JSON data, do
//
//     final homeScreenModel = homeScreenModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

HomeScreenModel homeScreenModelFromJson(String str) =>
    HomeScreenModel.fromJson(json.decode(str));

String homeScreenModelToJson(HomeScreenModel data) =>
    json.encode(data.toJson());

class HomeScreenModel {
  bool? status;
  String? message;
  Data? data;

  HomeScreenModel({
    this.status,
    this.message,
    this.data,
  });

  factory HomeScreenModel.fromJson(Map<String, dynamic> json) =>
      HomeScreenModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Current>? upcomming;
  List<Current>? current;
  Store? store;
  var acceptButton = 0.obs;
  var declineButton = 0.obs;

  Data({
    this.upcomming,
    this.current,
    this.store,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        upcomming: json["upcomming"] == null
            ? []
            : List<Current>.from(
                json["upcomming"]!.map((x) => Current.fromJson(x))),
        current: json["current"] == null
            ? []
            : List<Current>.from(
                json["current"]!.map((x) => Current.fromJson(x))),
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
      );

  Map<String, dynamic> toJson() => {
        "upcomming": upcomming == null
            ? []
            : List<dynamic>.from(upcomming!.map((x) => x.toJson())),
        "current": current == null
            ? []
            : List<dynamic>.from(current!.map((x) => x.toJson())),
        "store": store?.toJson(),
      };
}

class Current {
  int? id;
  String? userId;
  List<CartId>? cartId;
  String? subTotal;
  String? netAmount;
  String? date;
  String? timing;
  String? paymentMode;
  String? paymentModeStatus;
  String? delllveryStatus;
  dynamic delleveryDate;
  ShipingAddress? shipingAddress;

  Current({
    this.id,
    this.userId,
    this.cartId,
    this.subTotal,
    this.netAmount,
    this.date,
    this.timing,
    this.paymentMode,
    this.paymentModeStatus,
    this.delllveryStatus,
    this.delleveryDate,
    this.shipingAddress,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        id: json["id"],
        userId: json["user_id"],
        cartId: json["cart_id"] == null
            ? []
            : List<CartId>.from(
                json["cart_id"]!.map((x) => CartId.fromJson(x))),
        subTotal: json["sub_total"],
        netAmount: json["net_amount"],
        date: json["date"],
        timing: json["timing"],
        paymentMode: json["payment_mode"],
        paymentModeStatus: json["payment_mode_status"],
        delllveryStatus: json["delllvery_status"],
        delleveryDate: json["dellevery_date"],
        shipingAddress: json["shiping_address"] == null
            ? null
            : ShipingAddress.fromJson(json["shiping_address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "cart_id": cartId == null
            ? []
            : List<dynamic>.from(cartId!.map((x) => x.toJson())),
        "sub_total": subTotal,
        "net_amount": netAmount,
        "date": date,
        "timing": timing,
        "payment_mode": paymentMode,
        "payment_mode_status": paymentModeStatus,
        "delllvery_status": delllveryStatus,
        "dellevery_date": delleveryDate,
        "shiping_address": shipingAddress?.toJson(),
      };
}

class CartId {
  int? id;
  CartIdIngredientId? ingredientId;
  String? totalPrice;
  String? allProductPrice;
  String? quantity;
  String? productType;
  List<Detail>? ingredientDetails;
  List<Detail>? attributeDetails;
  Product? product;
  Category? category;
  Attribute? attribute;

  CartId({
    this.id,
    this.ingredientId,
    this.totalPrice,
    this.allProductPrice,
    this.quantity,
    this.productType,
    this.ingredientDetails,
    this.attributeDetails,
    this.product,
    this.category,
    this.attribute,
  });

  factory CartId.fromJson(Map<String, dynamic> json) => CartId(
        id: json["id"],
        ingredientId: json["ingredient_id"] == null
            ? null
            : CartIdIngredientId.fromJson(json["ingredient_id"]),
        totalPrice: json["total_price"],
        allProductPrice: json["all_product_price"],
        quantity: json["quantity"],
        productType: json["product_type"],
        ingredientDetails: json["ingredient_details"] == null
            ? []
            : List<Detail>.from(
                json["ingredient_details"]!.map((x) => Detail.fromJson(x))),
        attributeDetails: json["attribute_details"] == null
            ? []
            : List<Detail>.from(
                json["attribute_details"]!.map((x) => Detail.fromJson(x))),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        attribute: json["attribute"] == null
            ? null
            : Attribute.fromJson(json["attribute"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ingredient_id": ingredientId?.toJson(),
        "total_price": totalPrice,
        "all_product_price": allProductPrice,
        "quantity": quantity,
        "product_type": productType,
        "ingredient_details": ingredientDetails == null
            ? []
            : List<dynamic>.from(ingredientDetails!.map((x) => x.toJson())),
        "attribute_details": attributeDetails == null
            ? []
            : List<dynamic>.from(attributeDetails!.map((x) => x.toJson())),
        "product": product?.toJson(),
        "category": category?.toJson(),
        "attribute": attribute?.toJson(),
      };
}

class Attribute {
  int? id;
  String? childName;

  Attribute({
    this.id,
    this.childName,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        childName: json["child_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "child_name": childName,
      };
}

class Detail {
  String? id;
  String? name;
  String? price;

  Detail({
    this.id,
    this.name,
    this.price,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}

class Category {
  int? id;
  String? parentName;

  Category({
    this.id,
    this.parentName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentName: json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_name": parentName,
      };
}

class CartIdIngredientId {
  List<IngredientIdElement>? ingredientId;

  CartIdIngredientId({
    this.ingredientId,
  });

  factory CartIdIngredientId.fromJson(Map<String, dynamic> json) =>
      CartIdIngredientId(
        ingredientId: json["ingredient_id"] == null
            ? []
            : List<IngredientIdElement>.from(json["ingredient_id"]!
                .map((x) => IngredientIdElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ingredient_id": ingredientId == null
            ? []
            : List<dynamic>.from(ingredientId!.map((x) => x.toJson())),
      };
}

class IngredientIdElement {
  String? id;
  String? name;

  IngredientIdElement({
    this.id,
    this.name,
  });

  factory IngredientIdElement.fromJson(Map<String, dynamic> json) =>
      IngredientIdElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Product {
  int? id;
  String? title;
  String? description;
  String? image;
  String? productType;
  String? points;

  Product({
    this.id,
    this.title,
    this.description,
    this.image,
    this.productType,
    this.points,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        productType: json["product_type"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "product_type": productType,
        "points": points,
      };
}

class ShipingAddress {
  String? name;
  String? addressType;
  String? address;
  String? mobile;
  String? countryCode;

  ShipingAddress({
    this.name,
    this.addressType,
    this.address,
    this.mobile,
    this.countryCode,
  });

  factory ShipingAddress.fromJson(Map<String, dynamic> json) => ShipingAddress(
        name: json["name"],
        addressType: json["address_type"],
        address: json["address"],
        mobile: json["mobile"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address_type": addressType,
        "address": address,
        "mobile": mobile,
        "country_code": countryCode,
      };
}

class Store {
  int? id;
  String? image;
  String? name;
  String? address;
  String? mobile;
  String? openingHours;

  Store({
    this.id,
    this.image,
    this.name,
    this.address,
    this.mobile,
    this.openingHours,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        openingHours: json["opening_hours"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "address": address,
        "mobile": mobile,
        "opening_hours": openingHours,
      };
}
