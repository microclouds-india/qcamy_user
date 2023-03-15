class SpecificationsModel {
  SpecificationsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SpecificationsModel.fromJson(Map<String, dynamic> json) => SpecificationsModel(
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
    required this.specCat,
    required this.catValue,
    required this.measure,
  });

  String id;
  String specCat;
  String catValue;
  String measure;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    specCat: json["spec_cat"] ?? "",
    catValue: json["cat_value"] ?? "",
    measure: json["measure"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "spec_cat": specCat,
    "cat_value": catValue,
    "measure": measure,
  };
}
