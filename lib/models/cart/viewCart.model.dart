// To parse this JSON data, do
//
//     final viewCartModel = viewCartModelFromJson(jsonString);

// import 'dart:convert';

// ViewCartModel viewCartModelFromJson(String str) =>
//     ViewCartModel.fromJson(json.decode(str));

// String viewCartModelToJson(ViewCartModel data) => json.encode(data.toJson());

// class ViewCartModel {
//   ViewCartModel({
//     required this.message,
//     required this.data,
//     required this.status,
//     required this.totalItems,
//     required this.totalProductPrice,
//     required this.totalDiscount,
//     required this.subTotal,
//   });

//   String message;
//   List<Datum> data;
//   String status;
//   dynamic totalItems;
//   dynamic totalProductPrice;
//   dynamic totalDiscount;
//   String subTotal;

//   factory ViewCartModel.fromJson(Map<String, dynamic> json) => ViewCartModel(
//         message: json["message"] ?? "",
//         data:
//             List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
//         status: json["status"] ?? "",
//         totalItems: json["total_items"] ?? "",
//         totalProductPrice: json["total_product_price"] ?? "",
//         totalDiscount: json["total_discount"] ?? "",
//         subTotal: json["sub_total"] ?? "",
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "status": status,
//         "total_items": totalItems,
//         "total_product_price": totalProductPrice,
//         "total_discount": totalDiscount,
//         "sub_total": subTotal,
//       };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.productName,
//     required this.price,
//     required this.qty,
//     required this.totalPrice,
//     required this.offerPrice,
//     required this.offerPer,
//   });

//   String id;
//   String productName;
//   String price;
//   String qty;
//   String totalPrice;
//   String offerPrice;
//   String offerPer;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         productName: json["product_name"] ?? "",
//         price: json["price"],
//         qty: json["qty"],
//         totalPrice: json["total_price"],
//         offerPrice: json["total_price"] ?? "",
//         offerPer: json["offer_per"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "product_name": productName,
//         "price": price,
//         "qty": qty,
//         "total_price": totalPrice,
//         "offer_price": offerPrice,
//         "offer_per": offerPer,
//       };
// }
// To parse this JSON data, do
//
//     final viewCartModel = viewCartModelFromJson(jsonString);

class ViewCartModel {
  ViewCartModel({
    required this.message,
    required this.data,
    required this.status,
    required this.totalItems,
    required this.totalProductPrice,
    required this.totalDiscount,
    required this.subTotal,
  });

  String message;
  List<Datum> data;
  String status;
  dynamic totalItems;
  String totalProductPrice;
  dynamic totalDiscount;
  String subTotal;

  factory ViewCartModel.fromJson(Map<String, dynamic> json) => ViewCartModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"] ?? "",
        totalItems: json["total_items"] ?? "",
        totalProductPrice: json["total_product_price"] ?? "",
        totalDiscount: json["total_discount"] ?? "",
        subTotal: json["sub_total"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "total_items": totalItems,
        "total_product_price": totalProductPrice,
        "total_discount": totalDiscount,
        "sub_total": subTotal,
      };
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
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "qty": qty,
        "total_price": totalPrice,
        "cut_price": cutPrice,
        "offer_per": offerPer,
      };
}
