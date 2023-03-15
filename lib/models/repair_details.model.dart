class RepairDetailsModel {
  RepairDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory RepairDetailsModel.fromJson(Map<String, dynamic> json) =>
      RepairDetailsModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
      );

  // Map<String, dynamic> toJson() => {
  //       "message": message,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //       "status": status,
  //     };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.phone,
    required this.descri,
    required this.address,
    required this.equipmentName,
    required this.date,
  });

  String id;
  String name;
  String phone;
  String descri;
  String address;
  String equipmentName;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        descri: json["descri"] ?? "",
        address: json["address"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        date: json["date"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "phone": phone,
  //       "descri": descri,
  //       "address": address,
  //       "equipment_name": equipmentName,
  //     };
}
