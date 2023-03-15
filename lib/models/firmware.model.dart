// To parse this JSON data, do
//
//     final firmwareModel = firmwareModelFromJson(jsonString);

import 'dart:convert';

FirmwareModel? firmwareModelFromJson(String str) => FirmwareModel.fromJson(json.decode(str));

String firmwareModelToJson(FirmwareModel? data) => json.encode(data!.toJson());

class FirmwareModel {
  FirmwareModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum?> data;
  String status;

  factory FirmwareModel.fromJson(Map<String, dynamic> json) => FirmwareModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x!.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.brandName,
    required this.productName,
    required this.files,
  });

  String id;
  String brandName;
  String productName;
  String files;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    brandName: json["brand_name"] ?? "",
    productName: json["product_name"] ?? "",
    files: json["files"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand_name": brandName,
    "product_name": productName,
    "files": files,
  };
}
