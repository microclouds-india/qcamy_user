class CancelOrderModel {
  CancelOrderModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
