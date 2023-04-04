class AllReviewsModel {
  AllReviewsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory AllReviewsModel.fromJson(Map<String, dynamic> json) => AllReviewsModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) ?? [],
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
    required this.name,
    required this.rating,
    required this.comment,
  });

  String name;
  String rating;
  String comment;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] ?? "",
    rating: json["rating"] ?? "",
    comment: json["comment"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rating": rating,
    "comment": comment,
  };
}
