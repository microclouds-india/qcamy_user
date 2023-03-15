class EnquireProductDetailsModel {
  EnquireProductDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<EnquireProductDetailsModelDatum> data;
  String status;

  factory EnquireProductDetailsModel.fromJson(Map<String, dynamic> json) => EnquireProductDetailsModel(
    message: json["message"] ?? "",
    data: List<EnquireProductDetailsModelDatum>.from(json["data"].map((x) => EnquireProductDetailsModelDatum.fromJson(x))),
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class EnquireProductDetailsModelDatum {
  EnquireProductDetailsModelDatum({
    required this.id,
    required this.userId,
    required this.productId,
    required this.name,
    required this.email,
    required this.phone,
    required this.productName,
    required this.productDescription,
    required this.modelNumber,
    required this.image,
  });

  String id;
  String userId;
  String productId;
  String name;
  String email;
  String phone;
  String productName;
  String productDescription;
  String modelNumber;
  Image image;

  factory EnquireProductDetailsModelDatum.fromJson(Map<String, dynamic> json) => EnquireProductDetailsModelDatum(
    id: json["id"] ?? "",
    userId: json["user_id"] ?? "",
    productId: json["product_id"] ?? "",
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    productName: json["product_name"] ?? "",
    productDescription: json["product_description"] ?? "",
    modelNumber: json["model_number"] ?? "",
    image: Image.fromJson(json["image"] ?? ""),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "name": name,
    "email": email,
    "phone": phone,
    "product_name": productName,
    "product_description": productDescription,
    "model_number": modelNumber,
    "image": image.toJson(),
  };
}

class Image {
  Image({
    required this.data,
  });

  List<ImageDatum> data;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    data: List<ImageDatum>.from(json["data"].map((x) => ImageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ImageDatum {
  ImageDatum({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory ImageDatum.fromJson(Map<String, dynamic> json) => ImageDatum(
    id: json["id"] ?? "",
    image: json["image"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
