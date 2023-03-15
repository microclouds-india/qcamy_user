class RentalShopSearchModel {
  RentalShopSearchModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory RentalShopSearchModel.fromJson(Map<String, dynamic> json) => RentalShopSearchModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    required this.id,
    required this.name,
    required this.profileImage,
    required this.description,
    required this.phone,
    required this.location,
    required this.category,
  });

  String id;
  String name;
  String profileImage;
  String description;
  String phone;
  String location;
  String category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    profileImage: json["profile_image"] ?? "",
    description: json["description"] ?? "",
    phone: json["phone"] ?? "",
    location: json["location"] ?? "",
    category: json["category"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_image": profileImage,
    "description": description,
    "phone": phone,
    "location": location,
    "category": category,
  };
}
