import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:qcamyapp/models/wish_list/add_to_wishlist.model.dart';
import 'package:qcamyapp/models/wish_list/wish_list.model.dart';
import 'package:qcamyapp/models/wishlist_item_showing.model.dart';

class WishListItemShowingNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late WishListItemShowingModel wishListItemShowingModel;

  Future<WishListItemShowingModel> getWishListItemShowing({required String token, required String productId}) async {
    try {
      final request =
      await client.post(Uri.parse(urlENDPOINT + "wishlist"), body: {
        "token": token,
        "product_id": productId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        wishListItemShowingModel = WishListItemShowingModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return wishListItemShowingModel;
  }

}
