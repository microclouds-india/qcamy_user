class MyRepairsModel {
  MyRepairsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory MyRepairsModel.fromJson(Map<String, dynamic> json) => MyRepairsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
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
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        descri: json["descri"] ?? "",
        address: json["address"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        date: json["date"]?? "",
      );
}
