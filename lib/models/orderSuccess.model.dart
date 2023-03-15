class OrderSuccessModel {
  OrderSuccessModel({
    required this.userId,
    required this.totalProductPrice,
    required this.totalDisc,
    required this.subTotal,
    required this.address,
    required this.orderStatus,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
    required this.cartId,
  });

  String userId;
  String totalProductPrice;
  dynamic totalDisc;
  dynamic subTotal;
  String address;
  String orderStatus;
  String tdate;
  String ttime;
  String message;
  String status;
  String cartId;

  factory OrderSuccessModel.fromJson(Map<String, dynamic> json) =>
      OrderSuccessModel(
        userId: json["user_id"] ?? "",
        totalProductPrice: json["total_product_price"] ?? "",
        totalDisc: json["total_disc"] ?? "",
        subTotal: json["sub_total"] ?? "",
        address: json["address"] ?? "",
        orderStatus: json["order_status"] ?? "",
        tdate: json["tdate"] ?? "",
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        cartId: json["cart_id"] ?? "",
      );
}
