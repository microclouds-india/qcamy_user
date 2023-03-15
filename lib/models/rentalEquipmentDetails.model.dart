class RentalEquipmentDetailsModel {
  RentalEquipmentDetailsModel({
    required this.message,
    required this.data,
    required this.image,
    required this.status,
  });

  String message;
  List<Datum> data;
  List<Image> image;
  String status;

  factory RentalEquipmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      RentalEquipmentDetailsModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        status: json["status"],
      );

  // Map<String, dynamic> toJson() => {
  //       "message": message,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //       "image": List<dynamic>.from(image.map((x) => x.toJson())),
  //       "status": status,
  //     };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.descri,
    required this.specifications,
    required this.price,
    required this.renttype,
    required this.stock,
  });

  String id;
  String name;
  String descri;
  String specifications;
  String price;
  String renttype;
  String stock;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        descri: json["descri"],
        specifications: json["specifications"],
        price: json["price"],
        renttype: json["renttype"],
        stock: json["stock"],
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "descri": descri,
  //       "specifications": specifications,
  //       "price": price,
  //       "renttype": renttype,
  //     };
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
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
