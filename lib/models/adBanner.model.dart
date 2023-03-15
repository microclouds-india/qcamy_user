class AdBannerModel {
  AdBannerModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<AdBannerDataModel> data;
  String status;

  factory AdBannerModel.fromJson(Map<String, dynamic> json) => AdBannerModel(
        message: json["message"] ?? "",
        data: List<AdBannerDataModel>.from(
            json["data"]?.map((x) => AdBannerDataModel.fromJson(x)) ?? []),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class AdBannerDataModel {
  AdBannerDataModel({
    required this.id,
    required this.bannerTitle,
    required this.image,
    required this.linkType,
    required this.link,
  });

  String id;
  String bannerTitle;
  ImageModel image;
  String linkType;
  String link;

  factory AdBannerDataModel.fromJson(Map<String, dynamic> json) =>
      AdBannerDataModel(
        id: json["id"],
        bannerTitle: json["banner_title"],
        linkType: json["link_type"],
        link: json["link"],
        image: ImageModel.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "banner_title": bannerTitle,
        "image": image.toJson(),
      };
}

class ImageModel {
  ImageModel({
    required this.data,
  });

  List<ImageData> data;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        data: List<ImageData>.from(
            json["data"].map((x) => ImageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ImageData {
  ImageData({
    required this.id,
    required this.image,
  });

  String id;
  String image;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
