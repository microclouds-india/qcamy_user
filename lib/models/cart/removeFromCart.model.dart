class RemoveFromCartModel {
  RemoveFromCartModel({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory RemoveFromCartModel.fromJson(Map<String, dynamic> json) =>
      RemoveFromCartModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
