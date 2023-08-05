// To parse this JSON data, do
//
//     final privecyPolicyModel = privecyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivecyPolicyModel privecyPolicyModelFromJson(String str) => PrivecyPolicyModel.fromJson(json.decode(str));

String privecyPolicyModelToJson(PrivecyPolicyModel data) => json.encode(data.toJson());

class PrivecyPolicyModel {
    String message;
    String privacyPolicy;
    String status;

    PrivecyPolicyModel({
        required this.message,
        required this.privacyPolicy,
        required this.status,
    });

    factory PrivecyPolicyModel.fromJson(Map<String, dynamic> json) => PrivecyPolicyModel(
        message: json["message"],
        privacyPolicy: json["privacy_policy"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "privacy_policy": privacyPolicy,
        "status": status,
    };
}
