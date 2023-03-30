class AddReviewModel {
  AddReviewModel({
    required this.userId,
    required this.rating,
    required this.comment,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String rating;
  String comment;
  DateTime tdate;
  String ttime;
  String message;
  String status;

  factory AddReviewModel.fromJson(Map<String, dynamic> json) => AddReviewModel(
    userId: json["user_id"] ?? "",
    rating: json["rating"] ?? "",
    comment: json["comment"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "rating": rating,
    "comment": comment,
    "tdate": tdate,
    "ttime": ttime,
    "message": message,
    "status": status,
  };
}
