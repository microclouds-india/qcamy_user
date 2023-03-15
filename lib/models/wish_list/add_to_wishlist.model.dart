class AddToWishListModel {
  AddToWishListModel({
    required this.userId,
    required this.productId,
    required this.tdate,
    required this.ttime,
    required this.message,
    required this.status,
    required this.wishlistId,
    required this.productName,
    required this.fileName,
  });

  dynamic userId;
  dynamic productId;
  String tdate;
  String ttime;
  String message;
  String status;
  dynamic wishlistId;
  String productName;
  String fileName;

  factory AddToWishListModel.fromJson(Map<String, dynamic> json) =>
      AddToWishListModel(
        userId: json["user_id"] ?? "",
        productId: json["product_id"] ?? "",
        tdate: json["tdate"] ?? "",
        ttime: json["ttime"] ?? "",
        message: json["message"] ?? "",
        status: json["status"] ?? "",
        wishlistId: json["wishlist_id"] ?? "",
        productName: json["product_name"] ?? "",
        fileName: json["file_name"] ?? "",
      );
}
