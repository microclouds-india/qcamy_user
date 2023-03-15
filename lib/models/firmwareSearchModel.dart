// To parse this JSON data, do
//
//     final firmwareSearchModel = firmwareSearchModelFromJson(jsonString);

import 'dart:convert';

FirmwareSearchModel? firmwareSearchModelFromJson(String str) => FirmwareSearchModel.fromJson(json.decode(str));

String firmwareSearchModelToJson(FirmwareSearchModel? data) => json.encode(data!.toJson());

class FirmwareSearchModel {
  FirmwareSearchModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum?> data;
  String status;

  factory FirmwareSearchModel.fromJson(Map<String, dynamic> json) => FirmwareSearchModel(
    message: json["message"] ?? "",
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.brandId,
    required this.productName,
    required this.brandName,
  });

  String id;
  String productId;
  String brandId;
  String productName;
  String brandName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    productId: json["product_id"] ?? "",
    brandId: json["brand_id"] ?? "",
    productName: json["product_name"] ?? "",
    brandName: json["brand_name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "brand_id": brandId,
    "product_name": productName,
    "brand_name": brandName,
  };
}
