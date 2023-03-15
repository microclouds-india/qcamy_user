import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/remove_wishlist.model.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.networking.dart';

class RemoveWishListNotifier extends ChangeNotifier {
  final RemoveWishListNetworking removewishListNetworking = RemoveWishListNetworking();
  LocalStorage localStorage = LocalStorage();

  late RemoveWishlistModel removeWishlistModel;

  Future removeWishList({required String productId}) async {
    try {
      final String? token = await localStorage.getToken();
      removeWishlistModel = await removewishListNetworking.removeWishList(token: token!, productId: productId);
    } catch (e) {
      return Future.error(e);
    }
    return removewishListNetworking;
  }

  List<int> wishListedItems = [];

  void changeColors(int index) {
    if (!wishListedItems.contains(index)) {
      wishListedItems.remove(index);
      notifyListeners();
    }
  }
}