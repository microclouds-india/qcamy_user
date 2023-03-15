class SingleAdbannerModel {
  SingleAdbannerModel({
    required this.image1,
    required this.image2,
    required this.image3,
    required this.image4,
    required this.image5,
    required this.status,
  });

  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String status;

  factory SingleAdbannerModel.fromJson(Map<String, dynamic> json) =>
      SingleAdbannerModel(
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "status": status,
      };
}
