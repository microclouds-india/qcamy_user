class MyRentalBookingsModel {
  MyRentalBookingsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory MyRentalBookingsModel.fromJson(Map<String, dynamic> json) =>
      MyRentalBookingsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.orderId,
    required this.rentalshopId,
    required this.bookingDate,
    required this.equipmentId,
    required this.address,
    required this.orderStatus,
    required this.coverImg,
    required this.equipmentName,
    required this.date,
    required this.returnDate,
  });

  String orderId;
  String rentalshopId;
  String bookingDate;
  String equipmentId;
  String address;
  String orderStatus;
  String coverImg;
  String equipmentName;
  String date;
  String returnDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"] ?? "",
        rentalshopId: json["rentalshop_id"] ?? "",
        bookingDate: json["booking_date"] ?? "",
        equipmentId: json["equipment_id"] ?? "",
        address: json["address"] ?? "",
        orderStatus: json["order_status"] ?? "",
        coverImg: json["photo"] ?? "",
        equipmentName: json["equipment_name"] ?? "",
        date: json["date"] ?? "",
        returnDate: json["booking_todate"] ?? "",
      );
}
