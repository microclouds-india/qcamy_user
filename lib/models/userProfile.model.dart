class UserProfileModel {
  UserProfileModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
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
    required this.phone,
    required this.email,
    required this.gender,
    required this.lat,
    required this.long,
    required this.profileImage,
  });

  String id;
  String name;
  String phone;
  String email;
  String gender;
  String lat;
  String long;
  String profileImage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        gender: json["gender"] ?? "",
        lat: json["lat"] ?? "",
        long: json["long"] ?? "",
        profileImage: json["profile_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "gender": gender,
        "lat": lat,
        "long": long,
        "profile_image": profileImage,
      };
}
