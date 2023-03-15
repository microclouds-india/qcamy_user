class MyOrdersModel {
  MyOrdersModel({
    required this.message,
    required this.data,
    required this.status,
    required this.response,
  });

  String message;
  List<Datum> data;
  String status;
  String response;

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
        message: json["message"] ?? "",
        data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
        response: json["response"] ?? "",
      );
}

class Datum {
  Datum({
    required this.orderId,
    required this.date,
    required this.totalProductPrice,
    required this.totalDisc,
    required this.noItems,
    required this.subTotal,
    required this.paymentType,
    required this.orderStatus,
    required this.couponCode,
    required this.couponOffer,
    required this.items,
    required this.expectedDeliveryDate,
  });

  String orderId;
  String date;
  String totalProductPrice;
  String totalDisc;
  String noItems;
  String subTotal;
  String paymentType;
  String orderStatus;
  String couponCode;
  String couponOffer;
  String expectedDeliveryDate;
  List<DataItems> items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id"],
        date: json["date"],
        totalProductPrice: json["total_product_price"],
        totalDisc: json["total_disc"],
        noItems: json["no_items"],
        subTotal: json["sub_total"],
        paymentType: json["payment_type"],
        orderStatus: json["order_status"],
        couponCode: json["coupon_code"],
        couponOffer: json["coupon_offer"],
        expectedDeliveryDate: json["expected_delivery_date"] ?? "",
        items: List<DataItems>.from(json["items"]?.map((x) => DataItems.fromJson(x)) ?? []),
      );
}

class DataItems {
  DataItems({required this.name, required this.image, required this.id});

  String id;
  String name;
  String image;

  factory DataItems.fromJson(Map<String, dynamic> json) => DataItems(
        id: json["id"] ?? "",
        name: json["product_name"] ?? "",
        image: json["image"] ?? "",
      );
}
