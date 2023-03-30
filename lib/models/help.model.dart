class HelpModel {
  HelpModel({
    required this.userId,
    required this.question,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String question;
  String tdate;
  String ttime;
  String message;
  String status;

  factory HelpModel.fromJson(Map<String, dynamic> json) => HelpModel(
    userId: json["user_id"] ?? "",
    question: json["question"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "question": question,
    "tdate": tdate,
    "ttime": ttime,
    "message": message,
    "status": status,
  };
}
