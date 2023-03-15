class CategoryModel {
  CategoryModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.categoryname,
    this.image,
  });

  String id;
  String categoryname;
  dynamic image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryname: json["categoryname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryname": categoryname,
        "image": image,
      };
}
