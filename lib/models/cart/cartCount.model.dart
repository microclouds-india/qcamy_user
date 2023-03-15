class CartCountModel {
  CartCountModel({
    required this.message,
    required this.count,
    required this.status,
  });

  String? message;
  int? count;
  String status;

  factory CartCountModel.fromJson(Map<String, dynamic> json) => CartCountModel(
        message: json["message"] ?? "",
        count: json["count"] ?? 0,
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "count": count,
        "status": status,
      };
}
