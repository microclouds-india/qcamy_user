import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/wish_list/add_to_wishlist.model.dart';
import 'package:qcamyapp/models/wish_list/wish_list.model.dart';
import 'package:qcamyapp/repository/wish_list/wish_list.networking.dart';

class WishListNotifier extends ChangeNotifier {
  final WishListNetworking wishListNetworking = WishListNetworking();
  LocalStorage localStorage = LocalStorage();

  late WishListModel wishListModel;

  Future getWishList() async {
    try {
      final String? token = await localStorage.getToken();
      wishListModel = await wishListNetworking.getWishList(token: token!);
    } catch (e) {
      return Future.error(e);
    }
    return wishListModel;
  }

  late AddToWishListModel addToWishListModel;
  Future addToWishList({required String productId}) async {
    try {
      final String? token = await localStorage.getToken();
      addToWishListModel = await wishListNetworking.addToWishList(
          token: token!, productId: productId);
    } catch (e) {
      return Future.error(e);
    }
    return addToWishListModel;
  }

  List<int> wishListedItems = [];

  void changeColors(int index) {
    if (!wishListedItems.contains(index)) {
      wishListedItems.add(index);
      notifyListeners();
    }else {
      wishListedItems.remove(index);
      notifyListeners();
    }
  }
}
