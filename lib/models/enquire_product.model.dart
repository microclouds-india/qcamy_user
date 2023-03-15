class EnquireProductModel {
  EnquireProductModel({
    required this.userId,
    required this.productId,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String productId;
  String tdate;
  String ttime;
  String message;
  String status;

  factory EnquireProductModel.fromJson(Map<String, dynamic> json) => EnquireProductModel(
    userId: json["user_id"] ?? "",
    productId: json["product_id"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "product_id": productId,
    "tdate": tdate,
    "ttime": ttime,
    "message": message,
    "status": status,
  };
}
