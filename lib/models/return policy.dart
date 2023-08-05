// To parse this JSON data, do
//
//     final returnPolicyModel = returnPolicyModelFromJson(jsonString);

import 'dart:convert';

ReturnPolicyModel returnPolicyModelFromJson(String str) => ReturnPolicyModel.fromJson(json.decode(str));

String returnPolicyModelToJson(ReturnPolicyModel data) => json.encode(data.toJson());

class ReturnPolicyModel {
    String message;
    String returnPolicy;
    String status;

    ReturnPolicyModel({
        required this.message,
        required this.returnPolicy,
        required this.status,
    });

    factory ReturnPolicyModel.fromJson(Map<String, dynamic> json) => ReturnPolicyModel(
        message: json["message"],
        returnPolicy: json["return_policy"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "return_policy": returnPolicy,
        "status": status,
    };
}
