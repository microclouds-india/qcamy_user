class ApplyInBottomAdsModel {
  ApplyInBottomAdsModel({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.bannerId,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String name;
  String phone;
  String email;
  String bannerId;
  String tdate;
  String ttime;
  String message;
  String status;

  factory ApplyInBottomAdsModel.fromJson(Map<String, dynamic> json) =>
      ApplyInBottomAdsModel(
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        bannerId: json["banner_id"],
        tdate: json["tdate"],
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
      );
}
