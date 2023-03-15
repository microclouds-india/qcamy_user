class WishListModel {
  WishListModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        message: json["message"] ?? "",
        data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
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
    required this.price,
    required this.image,
  });

  String id;
  String productId;
  String productName;
  String price;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        productId: json["product_id"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "image": image,
      };
}
