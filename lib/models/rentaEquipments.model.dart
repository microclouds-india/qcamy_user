class RentalEquipmentModel {
  RentalEquipmentModel({
    this.message,
    this.data,
    required this.status,
  });

  String? message;
  List<dynamic>? data;
  String status;

  factory RentalEquipmentModel.fromJson(Map<String, dynamic> json) =>
      RentalEquipmentModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.descri,
    this.specifications,
    this.price,
    this.renttype,
    this.image,
  });

  String? id;
  String? name;
  String? descri;
  String? specifications;
  String? price;
  String? renttype;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        descri: json["descri"] ?? "",
        specifications: json["specifications"] ?? "",
        price: json["price"] ?? "",
        renttype: json["renttype"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "descri": descri,
        "specifications": specifications,
        "price": price,
        "renttype": renttype,
      };
}
