class RelatedProductsModel {
  RelatedProductsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory RelatedProductsModel.fromJson(Map<String, dynamic> json) =>
      RelatedProductsModel(
        message: json["message"] ?? "",
        data: List<Datum>.from(json["data"]?.map((x) => Datum.fromJson(x)) ?? []),
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
    this.offerPer,
    required this.specifications,
    required this.taxPer,
    required this.cgst,
    required this.sgst,
    required this.gst,
    required this.actualPrice,
    this.image,
  });

  String id;
  String categoryName;
  String brandName;
  String productName;
  String price;
  String cutPrice;
  String mrp;
  dynamic offerPer;
  String specifications;
  String taxPer;
  String cgst;
  String sgst;
  String gst;
  String actualPrice;
  dynamic image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? "",
        categoryName: json["category_name"] ?? "",
        brandName: json["brand_name"] ?? "",
        productName: json["product_name"] ?? "",
        price: json["price"] ?? "",
        cutPrice: json["cut_price"] ?? "",
        mrp: json["mrp"] ?? "",
        offerPer: json["offer_per"] ?? "",
        specifications: json["specifications"] ?? "",
        taxPer: json["tax_per"] ?? "",
        cgst: json["cgst"] ?? "",
        sgst: json["sgst"] ?? "",
        gst: json["gst"] ?? "",
        actualPrice: json["actual_price"] ?? "",
        image: json["image"] ?? "",
      );
}
