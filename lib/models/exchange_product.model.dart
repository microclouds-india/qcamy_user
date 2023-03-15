class ExchangeProductModel {
  ExchangeProductModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory ExchangeProductModel.fromJson(Map<String, dynamic> json) => ExchangeProductModel(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
