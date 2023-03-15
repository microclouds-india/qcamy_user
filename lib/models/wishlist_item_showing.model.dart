class WishListItemShowingModel {
  WishListItemShowingModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory WishListItemShowingModel.fromJson(Map<String, dynamic> json) => WishListItemShowingModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}


class Datum {
  Datum({
    required this.id,
    required this.productId,
  });

  String id;
  String productId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    productId: json["product_id"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
  };
}
