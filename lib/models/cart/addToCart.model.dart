class AddToCartModel {
  AddToCartModel({
    required this.userId,
    required this.productId,
    required this.cartId,
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.cutPrice,
    required this.offerPer,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
    required this.response,
    required this.discountPrice,
    required this.image,
    required this.productName,
  });

  String userId;
  String productId;
  dynamic cartId;
  String price;
  String qty;
  dynamic totalPrice;
  dynamic cutPrice;
  String offerPer;
  String tdate;
  String ttime;
  String message;
  String status;
  String response;
  dynamic discountPrice;
  String productName;
  String image;

  factory AddToCartModel.fromJson(Map<String, dynamic> json) => AddToCartModel(
        userId: json["user_id"] ?? "",
        productId: json["product_id"] ?? "",
        cartId: json["cart_id"] ?? "",
        price: json["price"] ?? "",
        qty: json["qty"] ?? "",
        totalPrice: json["total_price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        offerPer: json["offer_per"] ?? "",
        tdate: json["tdate"] ?? "",
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        response: json["response"] ?? "",
        discountPrice: json["discount_price"] ?? "",
        productName: json["product_name"] ?? "",
        image: json["file_name"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //       "user_id": userId,
  //       "product_id": productId,
  //       "price": price,
  //       "qty": qty,
  //       "total_price": totalPrice,
  //       "cut_price": cutPrice,
  //       "offer_per": offerPer,
  //       "tdate":
  //           "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
  //       "ttime": ttime,
  //       "message": message,
  //       "status": status,
  //     };
}
