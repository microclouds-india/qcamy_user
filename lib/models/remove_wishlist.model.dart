// To parse this JSON data, do
//
//     final removeWishlistModel = removeWishlistModelFromJson(jsonString);

import 'dart:convert';

RemoveWishlistModel? removeWishlistModelFromJson(String str) => RemoveWishlistModel.fromJson(json.decode(str));

String removeWishlistModelToJson(RemoveWishlistModel? data) => json.encode(data!.toJson());

class RemoveWishlistModel {
  RemoveWishlistModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory RemoveWishlistModel.fromJson(Map<String, dynamic> json) => RemoveWishlistModel(
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
