import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:qcamyapp/models/remove_wishlist.model.dart';

class RemoveWishListNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late RemoveWishlistModel removeWishlistModel;

  Future<RemoveWishlistModel> removeWishList(
      {required String token, required String productId}) async {
    try {
      final request =
      await client.post(Uri.parse(urlENDPOINT + "wishlist_remove"), body: {
        "token": token,
        "id": productId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        removeWishlistModel = RemoveWishlistModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return removeWishlistModel;
  }
}
