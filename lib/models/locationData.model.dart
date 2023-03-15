class LocationDataModel {
  LocationDataModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory LocationDataModel.fromJson(Map<String, dynamic> json) => LocationDataModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    status: json["status"] ?? "",
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
    required this.phone,
    required this.lat,
    required this.long,
  });

  String id;
  String name;
  String phone;
  String lat;
  String long;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    phone: json["phone"] ?? "",
    lat: json["lat"] ?? "",
    long: json["long"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "lat": lat,
    "long": long,
  };
}
