class AccessoriesModel {
  AccessoriesModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<AccessoriesModelDatum> data;
  String status;

  factory AccessoriesModel.fromJson(Map<String, dynamic> json) =>
      AccessoriesModel(
        message: json["message"] ?? "",
        data: List<AccessoriesModelDatum>.from(
            json["data"]?.map((x) => AccessoriesModelDatum.fromJson(x)) ?? []),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class AccessoriesModelDatum {
  AccessoriesModelDatum({
    required this.id,
    required this.categoryName,
    required this.productName,
    required this.price,
    required this.specifications,
    required this.discountPercentage,
    this.image,
    required this.wishlist_id,
  });

  String id;
  String categoryName;
  String productName;
  String price;
  String specifications;
  String discountPercentage;
  String? image;
  String wishlist_id;

  factory AccessoriesModelDatum.fromJson(Map<String, dynamic> json) =>
      AccessoriesModelDatum(
        id: json["id"] ?? "",
        categoryName: json["category_name"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        specifications: json["specifications"] ?? "",
        image: json["image"] ?? "",
        discountPercentage: json["offer_per"] ?? "",
        wishlist_id: json["wishlist_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "product_name": productName,
        "price": price,
        "specifications": specifications,
        "image": image,
        "wishlist_id": wishlist_id,
      };
}

class ImageElement {
  ImageElement({
    required this.status,
  });

  String status;

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class PurpleImage {
  PurpleImage({
    required this.data,
  });

  List<ImageDatum> data;

  factory PurpleImage.fromJson(Map<String, dynamic> json) => PurpleImage(
        data: List<ImageDatum>.from(
            json["data"].map((x) => ImageDatum.fromJson(x))),
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
