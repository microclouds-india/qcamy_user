class BookPhotographerModel {
  BookPhotographerModel({
    required this.userId,
    required this.photographerId,
    required this.request,
    required this.bookingDate,
    required this.bookingPlace,
    // required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
    required this.name,
    required this.phone,
    required this.alternateNumber,
  });

  String userId;
  String photographerId;
  String request;
  String bookingDate;
  String bookingPlace;
  // DateTime tdate;
  String ttime;
  String message;
  String status;
  String name;
  String phone;
  String alternateNumber;

  factory BookPhotographerModel.fromJson(Map<String, dynamic> json) =>
      BookPhotographerModel(
        userId: json["user_id"] ?? "",
        photographerId: json["photographer_id"] ?? "",
        request: json["request"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        bookingPlace: json["booking_place"] ?? "",
        // tdate: DateTime.parse(json["tdate"] ?? ""),
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        name: json["name"] ?? "",
        phone: json["phone"] ?? "",
        alternateNumber: json["alternate_number"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "photographer_id": photographerId,
        "request": request,
        "booking_date": bookingDate,
        "booking_place": bookingPlace,
        // "tdate":
        //     "${tdate.year.toString().padLeft(4, '0')}-${tdate.month.toString().padLeft(2, '0')}-${tdate.day.toString().padLeft(2, '0')}",
        "ttime": ttime,
        "message": message,
        "status": status,
      };
}
