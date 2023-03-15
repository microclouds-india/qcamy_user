class PhotographerBookingsModel {
  PhotographerBookingsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory PhotographerBookingsModel.fromJson(Map<String, dynamic> json) =>
      PhotographerBookingsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.orderId,
    required this.date,
    required this.photographerName,
    required this.photographerId,
    required this.userId,
    required this.status,
    required this.bookingDate,
    required this.bookingPlace,
    required this.phone,
    required this.photographerProfileImg,
    required this.category,
    required this.occassion,
  });

  String orderId;
  String date;
  String photographerName;
  String photographerProfileImg;
  String photographerId;
  String userId;
  String status;
  String bookingDate;
  String bookingPlace;
  String phone;
  String category;
  String occassion;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"] ?? "",
        date: json["date"] ?? "",
        photographerName: json["photographer_name"] ?? "",
        photographerId: json["photographer_id"] ?? "",
        userId: json["user_id"] ?? "",
        status: json["status"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        bookingPlace: json["booking_place"] ?? "",
        phone: json["phone"] ?? "",
        photographerProfileImg: json["photographer_image"] ?? "",
        category: json["category"] ?? "",
        occassion: json["booking_purpose"] ?? "Not Specified",
      );
}
