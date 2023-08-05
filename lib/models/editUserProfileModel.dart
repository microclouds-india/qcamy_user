// To parse this JSON data, do
//
//     final editUserProfileModel = editUserProfileModelFromJson(jsonString);

import 'dart:convert';

EditUserProfileModel editUserProfileModelFromJson(String str) => EditUserProfileModel.fromJson(json.decode(str));

String editUserProfileModelToJson(EditUserProfileModel data) => json.encode(data.toJson());

class EditUserProfileModel {
    String message;
    List<Datum> data;
    String status;

    EditUserProfileModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory EditUserProfileModel.fromJson(Map<String, dynamic> json) => EditUserProfileModel(
        message: json["message"]??"",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"]??"",
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    String id;
    String name;
    String phone;
    String images;

    Datum({
        required this.id,
        required this.name,
        required this.phone,
        required this.images,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"]??"",
        name: json["name"]??"",
        phone: json["phone"]??"",
        images: json["images"]??"",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "images": images,
    };
}
