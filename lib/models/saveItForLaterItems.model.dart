class SaveItForLaterItemsModel {
  SaveItForLaterItemsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SaveItForLaterItemsModel.fromJson(Map<String, dynamic> json) => SaveItForLaterItemsModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)) ?? []),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.productName,
    required this.image,
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.cutPrice,
    required this.offerPer,
    required this.cstatus,
  });

  String id;
  String productId;
  String productName;
  String image;
  String price;
  String qty;
  String totalPrice;
  String cutPrice;
  String offerPer;
  String cstatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    productId: json["product_id"] ?? "",
    productName: json["product_name"] ?? "",
    image: json["image"] ?? "",
    price: json["price"] ?? "",
    qty: json["qty"] ?? "",
    totalPrice: json["total_price"] ?? "",
    cutPrice: json["cut_price"] ?? "",
    offerPer: json["offer_per"] ?? "",
    cstatus: json["cstatus"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "product_name": productName,
    "image": image,
    "price": price,
    "qty": qty,
    "total_price": totalPrice,
    "cut_price": cutPrice,
    "offer_per": offerPer,
    "cstatus": cstatus,
  };
}
