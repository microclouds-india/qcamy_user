class TrackingStatusModel {
  TrackingStatusModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory TrackingStatusModel.fromJson(Map<String, dynamic> json) => TrackingStatusModel(
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
    required this.orderId,
    required this.cstatus,
    required this.tdate,
    required this.ttime,
  });

  String id;
  String orderId;
  String cstatus;
  String tdate;
  String ttime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] ?? "",
    orderId: json["order_id"] ?? "",
    cstatus: json["cstatus"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "cstatus": cstatus,
    "tdate": tdate,
    "ttime": ttime,
  };
}
