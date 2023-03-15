class TodaysDealsModel {
  TodaysDealsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory TodaysDealsModel.fromJson(Map<String, dynamic> json) =>
      TodaysDealsModel(
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
    required this.productName,
    required this.price,
    required this.cutPrice,
    required this.offerPer,
    required this.specifications,
    required this.image,
  });

  String id;
  String categoryName;
  String productName;
  String price;
  String cutPrice;
  String offerPer;
  String specifications;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        categoryName: json["category_name"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        offerPer: json["offer_per"] ?? "",
        specifications: json["specifications"] ?? "",
        image: json["image"] ?? "",
      );
}
