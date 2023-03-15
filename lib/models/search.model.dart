class SearchModel {
  SearchModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
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
    required this.name,
    required this.profileImage,
    required this.phone,
    required this.location,
    required this.description,
  });

  String id;
  String name;
  dynamic profileImage;
  dynamic phone;
  String location;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        profileImage: json["profile_image"],
        phone: json["phone"],
        location: json["location"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_image": profileImage,
        "phone": phone,
        "location": location,
      };
}
