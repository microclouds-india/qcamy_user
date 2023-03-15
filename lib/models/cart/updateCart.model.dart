class UpdateCartModel {
  UpdateCartModel({
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.cutPrice,
    required this.cartStatus,
    required this.message,
    required this.status,
  });

  String price;
  String qty;
  String totalPrice;
  String cutPrice;
  String cartStatus;
  String message;
  String status;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) =>
      UpdateCartModel(
        price: json["price"] ?? "",
        qty: json["qty"] ?? "",
        totalPrice: json["total_price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        cartStatus: json["cart_status"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
      );
}
