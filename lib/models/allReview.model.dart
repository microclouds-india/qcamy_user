class AllReviewsModel {
  AllReviewsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory AllReviewsModel.fromJson(Map<String, dynamic> json) {
    return AllReviewsModel(
      message: json["message"] ?? "",
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) ?? [],
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "status": status,
    };
  }
}

class Datum {
  Datum({
    required this.name,
    required this.rating,
    required this.comment,
    required this.images,
    required this.photo

  });

  String name;
  String rating;
  String comment;
  String photo;
  List<ImageData> images;

  factory Datum.fromJson(Map<String, dynamic> json) {
    var imageDataJson = json["images"];
    List<ImageData> imageData = [];

    if (imageDataJson is List) {
      imageData = List<ImageData>.from(imageDataJson.map((x) => ImageData.fromJson(x)));
    } else if (imageDataJson is Map) {
      var dataList = imageDataJson["data"];
      if (dataList is List) {
        imageData = List<ImageData>.from(dataList.map((x) => ImageData.fromJson(x)));
      }
    }

    return Datum(
      name: json["name"] ?? "",
      rating: json["rating"] ?? "",
      comment: json["comment"] ?? "",
      images: imageData,
      photo: json["photo"]??""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "rating": rating,
      "comment": comment,
      "photo":photo,
      "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
  }
}

class ImageData {
  ImageData({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json["id"] ?? "",
      image: json["image"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
    };
  }
}
