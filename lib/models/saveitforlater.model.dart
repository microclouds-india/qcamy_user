class SaveItForLaterModel {
  SaveItForLaterModel({
    required this.savelater,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String savelater;
  String tdate;
  String ttime;
  String message;
  String status;

  factory SaveItForLaterModel.fromJson(Map<String, dynamic> json) => SaveItForLaterModel(
    savelater: json["savelater"] ?? "",
    tdate: json["tdate"] ?? "",
    ttime: json["ttime"] ?? "",
    message: json["message"] ?? "",
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "savelater": savelater,
    "tdate": tdate,
    "ttime": ttime,
    "message": message,
    "status": status,
  };
}
