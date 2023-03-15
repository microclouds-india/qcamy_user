class GetCouponModel {
  GetCouponModel({
    required this.userId,
    required this.message,
    required this.tdate,
    required this.ttime,
    required this.status,
    required this.couponCode,
  });

  String userId;
  String message;
  String tdate;
  String ttime;
  String status;
  String couponCode;

  factory GetCouponModel.fromJson(Map<String, dynamic> json) => GetCouponModel(
        userId: json["user_id"],
        message: json["message"],
        tdate: json["tdate"],
        ttime: json["ttime"],
        status: json["status"],
        couponCode: json["coupon_code"] ?? "",
      );
}
