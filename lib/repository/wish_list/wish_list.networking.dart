import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:qcamyapp/models/wish_list/add_to_wishlist.model.dart';
import 'package:qcamyapp/models/wish_list/wish_list.model.dart';

class WishListNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late WishListModel wishListModel;

  Future<WishListModel> getWishList({required String token}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "wishlist"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        wishListModel = WishListModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return wishListModel;
  }

  late AddToWishListModel addToWishListModel;
  Future<AddToWishListModel> addToWishList(
      {required String token, required String productId}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "add_to_wishlist"), body: {
        "token": token,
        "product_id": productId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addToWishListModel = AddToWishListModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return addToWishListModel;
  }
}
