class NewArrivalsModel {
  NewArrivalsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory NewArrivalsModel.fromJson(Map<String, dynamic> json) =>
      NewArrivalsModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.categoryName,
    required this.brandName,
    required this.productName,
    required this.price,
    required this.cutPrice,
    required this.mrp,
    required this.offerPer,
    required this.image,
  });

  String id;
  String categoryName;
  String brandName;
  String productName;
  String price;
  String cutPrice;
  String mrp;
  dynamic offerPer;

  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryName: json["category_name"] ?? "",
        brandName: json["brand_name"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        mrp: json["mrp"] ?? "",
        offerPer: json["offer_per"] ?? "",
        image: json["image"] ?? "",
      );
}
