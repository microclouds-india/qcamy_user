class PhotographerProfileModel {
  PhotographerProfileModel({
    required this.message,
    required this.data,
    required this.image,
    required this.links,
    required this.status,
  });

  String message;
  List<Datum> data;
  List<Image> image;
  List<Links> links;
  String status;

  factory PhotographerProfileModel.fromJson(Map<String, dynamic> json) =>
      PhotographerProfileModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        image: List<Image>.from(
            json["image"]?.map((x) => Image.fromJson(x)) ?? []),
        links: List<Links>.from(
            json["links"]?.map((x) => Links.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.phone,
    required this.username,
    required this.password,
    required this.fee,
    required this.feeType,
    required this.coverImage,
    required this.profileImage,
    required this.category,
    required this.description,
  });

  String id;
  String name;
  String phone;
  String username;
  String password;
  String fee;
  String feeType;
  String coverImage;
  String profileImage;
  String category;
  String description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        fee: json["fee"] ?? "",
        feeType: json["feetype"] ?? "",
        coverImage: json["cover_image"] ?? "",
        profileImage: json["profile_image"] ?? "",
        category: json["category"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "username": username,
        "password": password,
        "fee": fee,
        "feetype": feeType,
        "cover_image": coverImage,
        "profile_image": profileImage,
      };
}

class Image {
  Image({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"] ?? "",
      );
}

class Links {
  Links({
    required this.id,
    required this.link,
  });

  String id;
  String link;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        id: json["id"],
        link: json["link"] ?? "",
      );
}
