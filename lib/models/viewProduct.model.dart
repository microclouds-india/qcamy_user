// class ViewProductModel {
//   ViewProductModel({
//     required this.message,
//     required this.data,
//     required this.image,
//     required this.status,
//   });

//   String message;
//   List<Datum> data;
//   List<Image> image;
//   String status;

//   factory ViewProductModel.fromJson(Map<String, dynamic> json) =>
//       ViewProductModel(
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
//         status: json["status"],
//       );

//   // Map<String, dynamic> toJson() => {
//   //       "message": message,
//   //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   //       "image": List<dynamic>.from(image.map((x) => x.toJson())),
//   //       "status": status,
//   //     };
// }

// class Datum {
//   Datum({
//     required this.id,
//     required this.productName,
//     required this.price,
//     required this.specifications,
//     required this.description,
//     required this.offerPrice,
//     required this.offerPer,
//     required this.stock,
//     required this.startDate,
//     required this.endDate,
//   });

//   String id;
//   String? productName;
//   String? price;
//   String? specifications;
//   String? description;
//   String? offerPrice;
//   String? offerPer;
//   String? stock;
//   String? startDate;
//   String? endDate;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         productName: json["product_name"] ?? "",
//         price: json["price"] ?? "",
//         specifications: json["specifications"] ?? "",
//         description: json["description"] ?? "",
//         offerPrice: json["offer_price"] ?? "",
//         offerPer: json["offer_per"] ?? "",
//         stock: json["stock"] ?? "",
//         startDate: json["start_date"] ?? "",
//         endDate: json["end_date"] ?? "",
//       );

//   // Map<String, dynamic> toJson() => {
//   //       "id": id,
//   //       "product_name": productName,
//   //       "price": price,
//   //       "specifications": specifications,
//   //       "description": description,
//   //       "offer_price": offerPrice,
//   //       "offer_per": offerPer,
//   //       "stock": stock,
//   //       "start_date":
//   //           "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
//   //       "end_date":
//   //           "${endDate?.year.toString().padLeft(4, '0')}-${endDate?.month.toString().padLeft(2, '0')}-${endDate?.day.toString().padLeft(2, '0')}",
//   //     };
// }

// class Image {
//   Image({
//     required this.id,
//     required this.image,
//   });

//   String id;
//   String image;

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json["id"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//       };
// }

class ViewProductModel {
  ViewProductModel({
    required this.message,
    required this.data,
    required this.image,
    required this.status,
  });

  String message;
  List<Datum> data;
  List<Image> image;
  String status;

  factory ViewProductModel.fromJson(Map<String, dynamic> json) =>
      ViewProductModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        status: json["status"],
      );

  // Map<String, dynamic> toJson() => {
  //     "message": message,
  //     "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //     "image": List<dynamic>.from(image.map((x) => x.toJson())),
  //     "status": status,
  // };
}

class Datum {
  Datum({
    required this.id,
    required this.together,
    required this.traderName,
    required this.productName,
    required this.price,
    required this.cutPrice,
    required this.offerPer,
    required this.specifications,
    required this.description,
    required this.stock,
    required this.startDate,
    required this.endDate,
    required this.sgst,
    required this.cgst,
    required this.taxPer,
    required this.wishlist_id,
  });

  String id;
  String together;
  String traderName;
  String productName;
  String price;
  String cutPrice;
  String offerPer;
  String specifications;
  String description;
  String stock;
  String startDate;
  String endDate;
  String cgst;
  String sgst;
  String taxPer;
  String wishlist_id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        together: json["together"] ?? "",
        traderName: json["trader_name"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        offerPer: json["offer_per"] ?? "",
        specifications: json["specifications"] ?? "",
        description: json["description"] ?? "",
        stock: json["stock"] ?? "",
        startDate: json["start_date"] ?? "",
        endDate: json["end_date"] ?? "",
        taxPer: json["tax_per"] ?? "",
        cgst: json["cgst"] ?? "",
        sgst: json["sgst"] ?? "",
        wishlist_id: json["wishlist_id"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "product_name": productName,
  //     "price": price,
  //     "cut_price": cutPrice,
  //     "offer_per": offerPer,
  //     "specifications": specifications,
  //     "description": description,
  //     "stock": stock,
  //     "start_date": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
  //     "end_date": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
  // };
}

class Image {
  Image({required this.id, required this.image, required this.format});

  String id;
  String image;
  String format;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"] ?? "",
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
