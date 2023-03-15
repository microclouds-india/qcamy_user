class RentalProductBookingResponseModel {
  RentalProductBookingResponseModel({
    required this.userId,
    required this.rentalshopId,
    required this.equipmentId,
    required this.phone,
    required this.qty,
    required this.address,
    required this.bookingDate,
    required this.orderStatus,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
  });

  String userId;
  String rentalshopId;
  String equipmentId;
  String phone;
  String qty;
  String address;
  String bookingDate;
  String orderStatus;
  String tdate;
  String ttime;
  String message;
  String status;

  factory RentalProductBookingResponseModel.fromJson(
          Map<String, dynamic> json) =>
      RentalProductBookingResponseModel(
        userId: json["user_id"] ?? "",
        rentalshopId: json["rentalshop_id"] ?? "",
        equipmentId: json["equipment_id"] ?? "",
        phone: json["phone"] ?? "",
        qty: json["qty"] ?? "",
        address: json["address"],
        bookingDate: json["booking_date"] ?? "",
        orderStatus: json["order_status"] ?? "",
        tdate: json["tdate"] ?? "",
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
      );
}
