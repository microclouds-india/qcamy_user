class ViewAddressModel {
  ViewAddressModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory ViewAddressModel.fromJson(Map<String, dynamic> json) =>
      ViewAddressModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.landmark,
    required this.phone,
    required this.alternateNumber,
    required this.pincode,
  });

  String id;
  String name;
  String address;
  String city;
  String landmark;
  String phone;
  String alternateNumber;
  String pincode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        landmark: json["landmark"],
        phone: json["phone"],
        alternateNumber: json["alternate_number"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "landmark": landmark,
        "phone": phone,
        "alternate_number": alternateNumber,
        "pincode": pincode,
      };
}
