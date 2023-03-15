class BottomSlidingAdDetailsModel {
  BottomSlidingAdDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<BottomSlidingAdDetailsModelDatum> data;
  String status;

  factory BottomSlidingAdDetailsModel.fromJson(Map<String, dynamic> json) =>
      BottomSlidingAdDetailsModel(
        message: json["message"],
        data: List<BottomSlidingAdDetailsModelDatum>.from(json["data"]
            .map((x) => BottomSlidingAdDetailsModelDatum.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class BottomSlidingAdDetailsModelDatum {
  BottomSlidingAdDetailsModelDatum({
    required this.id,
    required this.bannerTitle,
    required this.info,
    required this.image,
  });

  String id;
  String bannerTitle;
  String info;
  Image image;

  factory BottomSlidingAdDetailsModelDatum.fromJson(
          Map<String, dynamic> json) =>
      BottomSlidingAdDetailsModelDatum(
        id: json["id"],
        bannerTitle: json["banner_title"],
        info: json["info"],
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_title": bannerTitle,
        "info": info,
        "image": image.toJson(),
      };
}

class Image {
  Image({
    required this.data,
  });

  List<ImageDatum> data;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
