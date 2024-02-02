// To parse this JSON data, do
//
//     final productScreenModel = productScreenModelFromJson(jsonString);

import 'dart:convert';

ProductScreenModel productScreenModelFromJson(String str) =>
    ProductScreenModel.fromJson(json.decode(str));

String productScreenModelToJson(ProductScreenModel data) =>
    json.encode(data.toJson());

class ProductScreenModel {
  bool? status;
  String? message;
  Data? data;

  ProductScreenModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProductScreenModel.fromJson(Map<String, dynamic> json) =>
      ProductScreenModel(
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
  ProductDetails? productDetails;

  Data({
    this.productDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        productDetails: json["product-details"] == null
            ? null
            : ProductDetails.fromJson(json["product-details"]),
      );

  Map<String, dynamic> toJson() => {
        "product-details": productDetails?.toJson(),
      };
}

class ProductDetails {
  int? id;
  String? userId;
  List<CartId>? cartId;
  String? subTotal;
  String? onPickupDiscunt;
  String? issuePoinDiscunt;
  String? couponDiscunt;
  String? couponId;
  String? netAmount;
  String? date;
  String? timing;
  String? paymentMode;
  String? paymentModeStatus;
  String? delllveryStatus;
  dynamic delleveryDate;
  dynamic cancel;
  String? complete;

  ProductDetails({
    this.id,
    this.userId,
    this.cartId,
    this.subTotal,
    this.onPickupDiscunt,
    this.issuePoinDiscunt,
    this.couponDiscunt,
    this.couponId,
    this.netAmount,
    this.date,
    this.timing,
    this.paymentMode,
    this.paymentModeStatus,
    this.delllveryStatus,
    this.delleveryDate,
    this.cancel,
    this.complete,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        id: json["id"],
        userId: json["user_id"],
        cartId: json["cart_id"] == null
            ? []
            : List<CartId>.from(
                json["cart_id"]!.map((x) => CartId.fromJson(x))),
        subTotal: json["sub_total"],
        onPickupDiscunt: json["on_pickup_discunt"],
        issuePoinDiscunt: json["issue_poin_discunt"],
        couponDiscunt: json["coupon_discunt"],
        couponId: json["coupon_id"],
        netAmount: json["net_amount"],
        date: json["date"],
        timing: json["timing"],
        paymentMode: json["payment_mode"],
        paymentModeStatus: json["payment_mode_status"],
        delllveryStatus: json["delllvery_status"],
        delleveryDate: json["dellevery_date"],
        cancel: json["cancel"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "cart_id": cartId == null
            ? []
            : List<dynamic>.from(cartId!.map((x) => x.toJson())),
        "sub_total": subTotal,
        "on_pickup_discunt": onPickupDiscunt,
        "issue_poin_discunt": issuePoinDiscunt,
        "coupon_discunt": couponDiscunt,
        "coupon_id": couponId,
        "net_amount": netAmount,
        "date": date,
        "timing": timing,
        "payment_mode": paymentMode,
        "payment_mode_status": paymentModeStatus,
        "delllvery_status": delllveryStatus,
        "dellevery_date": delleveryDate,
        "cancel": cancel,
        "complete": complete,
      };
}

class CartId {
  int? id;
  dynamic ingredientId;
  String? totalPrice;
  String? allProductPrice;
  String? quantity;
  String? productType;
  dynamic couponId;
  dynamic ingredientDetails;
  dynamic attributeDetails;
  Product? product;
  Category? category;
  dynamic attribute;

  CartId({
    this.id,
    this.ingredientId,
    this.totalPrice,
    this.allProductPrice,
    this.quantity,
    this.productType,
    this.couponId,
    this.ingredientDetails,
    this.attributeDetails,
    this.product,
    this.category,
    this.attribute,
  });

  factory CartId.fromJson(Map<String, dynamic> json) => CartId(
        id: json["id"],
        ingredientId: json["ingredient_id"],
        totalPrice: json["total_price"],
        allProductPrice: json["all_product_price"],
        quantity: json["quantity"],
        productType: json["product_type"],
        couponId: json["coupon_id"],
        ingredientDetails: json["ingredient_details"],
        attributeDetails: json["attribute_details"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ingredient_id": ingredientId,
        "total_price": totalPrice,
        "all_product_price": allProductPrice,
        "quantity": quantity,
        "product_type": productType,
        "coupon_id": couponId,
        "ingredient_details": ingredientDetails,
        "attribute_details": attributeDetails,
        "product": product?.toJson(),
        "category": category?.toJson(),
        "attribute": attribute,
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
