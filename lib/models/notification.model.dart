class NotificationModel {
  NotificationModel({
    required this.notification,
    required this.message,
    required this.status,
    required this.response,
  });

  String notification;
  String message;
  String status;
  String response;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notification: json["notification"] ?? "",
        message: json["message"] ?? "",
        status: json["status"],
        response: json["response"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //       "notification": notification,
  //       "message": message,
  //       "status": status,
  //     };
}
