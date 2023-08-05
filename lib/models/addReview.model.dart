// To parse this JSON data, do
//
//     final addReviewModel = addReviewModelFromJson(jsonString);

import 'dart:convert';

AddReviewModel addReviewModelFromJson(String str) => AddReviewModel.fromJson(json.decode(str));

String addReviewModelToJson(AddReviewModel data) => json.encode(data.toJson());

class AddReviewModel {
    String productId;
    String userId;
    String rating;
    String comment;
    DateTime tdate;
    String ttime;
    String message;
    String status;

    AddReviewModel({
        required this.productId,
        required this.userId,
        required this.rating,
        required this.comment,
        required this.tdate,
        required this.ttime,
        required this.message,
        required this.status,
    });

    factory AddReviewModel.fromJson(Map<String, dynamic> json) => AddReviewModel(
        productId: json["product_id"],
        userId: json["user_id"],
        rating: json["rating"],
        comment: json["comment"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "user_id": userId,
        "rating": rating,
        "comment": comment,
        "tdate": "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
        "status": status,
    };
}
