class HomeSearchModel {
  HomeSearchModel({
    required this.message,
    required this.data,
    required this.status,
    required this.response,
  });

  String message;
  List<Datum> data;
  String status;
  String response;

  factory HomeSearchModel.fromJson(Map<String, dynamic> json) =>
      HomeSearchModel(
        message: json["message"] ?? "",
        data:
            List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
        status: json["status"],
        response: json["response"] ?? "",
      );
}

class Datum {
  Datum({
    required this.id,
    required this.productName,
    required this.price,
    required this.cutPrice,
    required this.offerPer,
    required this.specifications,
    required this.image,
  });

  String id;
  String productName;
  String price;
  String cutPrice;
  String offerPer;
  String specifications;
  String image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        offerPer: json["offer_per"] ?? "",
        specifications: json["specifications"] ?? "",
        image: json["image"] ?? "",
      );
}
