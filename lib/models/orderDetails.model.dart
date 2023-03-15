class OrderDetailsModel {
  OrderDetailsModel({
    required this.message,
    required this.data,
    required this.status,
    required this.id,
    required this.noProducts,
    required this.totalProductPrice,
    required this.totalDisc,
    required this.subTotal,
    required this.orderStatus,
    required this.address,
    required this.paymentType,
    required this.expectedDeliveryDate,
  });

  String message;
  List<Datum> data;
  String status;
  String id;
  String noProducts;
  String totalProductPrice;
  String totalDisc;
  String subTotal;
  String orderStatus;
  String address;
  String paymentType;
  String expectedDeliveryDate;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"] ?? "",
        id: json["id"] ?? "",
        noProducts: json["no_products"] ?? "",
        totalProductPrice: json["total_product_price"] ?? "",
        totalDisc: json["total_disc"] ?? "",
        subTotal: json["sub_total"] ?? "",
        orderStatus: json["order_status"] ?? "",
        address: json["address"] ?? "",
        paymentType: json["payment_type"] ?? "",
        expectedDeliveryDate: json["expected_delivery_date"] ?? "",
      );
}

class Datum {
  Datum({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.cutPrice,
    required this.offerPer,
    required this.cstatus,
    required this.image,
  });

  String id;
  String productId;
  String productName;
  String price;
  String qty;
  String totalPrice;
  String cutPrice;
  String offerPer;
  String cstatus;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        productId: json["product_id"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        qty: json["qty"] ?? "",
        totalPrice: json["total_price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        offerPer: json["offer_per"] ?? "",
        cstatus: json["cstatus"] ?? "",
        image: json["image"] ?? "",
      );
}
