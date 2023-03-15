class CameraRepairModel {
  CameraRepairModel({
    required this.userId,
    required this.name,
    required this.descri,
    required this.phone,
    required this.equipmentName,
    required this.address,
    // required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String name;
  String descri;
  String phone;
  String equipmentName;
  String address;
  // DateTime tdate;
  String ttime;
  String message;
  String status;

  factory CameraRepairModel.fromJson(Map<String, dynamic> json) =>
      CameraRepairModel(
        userId: json["user_id"] ?? "",
        name: json["name"] ?? "",
        descri: json["descri"] ?? "",
        phone: json["phone"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        address: json["address"] ?? "",
        // tdate: DateTime.parse(json["tdate"] ?? ""),
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "descri": descri,
        "phone": phone,
        "equipment_name": equipmentName,
        "address": address,
        // "tdate":
        //     "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
        "status": status,
      };
}
