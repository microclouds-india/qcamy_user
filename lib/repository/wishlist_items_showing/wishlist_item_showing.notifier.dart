import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/wishlist_item_showing.model.dart';
import 'package:qcamyapp/repository/wishlist_items_showing/wishlist_item_showing.networking.dart';

class WishListItemShowingNotifier extends ChangeNotifier {
  final WishListItemShowingNetworking wishListItemShowingNetworking = WishListItemShowingNetworking();
  LocalStorage localStorage = LocalStorage();

  WishListItemShowingModel? wishListItemShowingModel;

  String removeproductId = "1";
  bool isLoading = false;

  Future getWishListItemShowing({required String productId}) async {
    isLoading = true;
    try {
      final String? token = await localStorage.getToken();
      wishListItemShowingModel = await wishListItemShowingNetworking.getWishListItemShowing(
          token: token!, productId: productId);
    } catch (e) {
      return Future.error(e);
    }
    isLoading = false;
    notifyListeners();
    return wishListItemShowingModel;
  }
}
