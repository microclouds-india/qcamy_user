class CouponModel {
  CouponModel({
    required this.message,
    required this.data,
    required this.status,
    required this.totalProductPrice,
    required this.totalDiscount,
    required this.subTotal,
  });

  String message;
  List<Datum> data;
  String status;
  dynamic totalProductPrice;
  dynamic totalDiscount;
  dynamic subTotal;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
        totalProductPrice: json["total_product_price"] ?? "",
        totalDiscount: json["total_discount"] ?? "",
        subTotal: json["sub_total"] ?? "",
      );
}

class Datum {
  Datum({
    required this.id,
    required this.couponCode,
    required this.couponOffer,
    required this.startDate,
    required this.endDate,
  });

  String id;
  String couponCode;
  String couponOffer;
  String startDate;
  String endDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        couponCode: json["coupon_code"] ?? "",
        couponOffer: json["coupon_offer"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
      );
}
