class UploadProfilePicModel {
  UploadProfilePicModel({
    required this.message,
    required this.image,
    required this.status,
  });

  String message;
  String image;
  String status;

  factory UploadProfilePicModel.fromJson(Map<String, dynamic> json) =>
      UploadProfilePicModel(
        message: json["message"] ?? "",
        image: json["image"] ?? "",
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "image": image,
        "status": status,
      };
}
