class AddAddressModel {
  AddAddressModel({
    required this.userId,
    required this.name,
    required this.address,
    required this.city,
    required this.landmark,
    required this.phone,
    required this.alternateNumber,
    required this.pincode,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String name;
  String address;
  String city;
  String landmark;
  String phone;
  String alternateNumber;
  String pincode;
  DateTime tdate;
  String ttime;
  String message;
  String status;

  factory AddAddressModel.fromJson(Map<String, dynamic> json) =>
      AddAddressModel(
        userId: json["user_id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        landmark: json["landmark"],
        phone: json["phone"],
        alternateNumber: json["alternate_number"],
        pincode: json["pincode"],
        tdate: DateTime.parse(json["tdate"]),
        ttime: json["ttime"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "address": address,
        "city": city,
        "landmark": landmark,
        "phone": phone,
        "alternate_number": alternateNumber,
        "pincode": pincode,
        "tdate":
            "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
        "status": status,
      };
}
