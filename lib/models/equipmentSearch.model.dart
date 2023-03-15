// To parse this JSON data, do
//
//     final equipmentSearchModel = equipmentSearchModelFromJson(jsonString);

import 'dart:convert';

EquipmentSearchModel? equipmentSearchModelFromJson(String str) => EquipmentSearchModel.fromJson(json.decode(str));

String equipmentSearchModelToJson(EquipmentSearchModel? data) => json.encode(data!.toJson());

class EquipmentSearchModel {
  EquipmentSearchModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum?> data;
  String status;

  factory EquipmentSearchModel.fromJson(Map<String, dynamic> json) => EquipmentSearchModel(
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
    required this.name,
    required this.descri,
    required this.specifications,
    required this.price,
    required this.renttype,
    required this.stock,
    required this.image,
  });

  String id;
  String name;
  String descri;
  String specifications;
  String price;
  String renttype;
  String stock;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    descri: json["descri"] ?? "",
    specifications: json["specifications"] ?? "",
    price: json["price"] ?? "",
    renttype: json["renttype"] ?? "",
    stock: json["stock"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "descri": descri,
    "specifications": specifications,
    "price": price,
    "renttype": renttype,
    "stock": stock,
    "image": image,
  };
}
