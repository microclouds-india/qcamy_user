import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/cart/addToCart.model.dart';
import 'package:qcamyapp/models/cart/cartCount.model.dart';
import 'package:qcamyapp/models/cart/removeFromCart.model.dart';
import 'package:qcamyapp/models/cart/updateCart.model.dart';
import 'package:qcamyapp/models/cart/viewCart.model.dart';
import 'package:qcamyapp/repository/cart/cart.networking.dart';

class CartNotifier extends ChangeNotifier {
  final CartNetworking _cartNetworking = CartNetworking();
  LocalStorage localStorage = LocalStorage();

  late ViewCartModel viewCartModel;

  // double totalPrice = 0;

  Future getCartItems() async {
    final String? token = await localStorage.getToken();

    try {
      viewCartModel = await _cartNetworking.getCartItems(token: token!);
      // print(getTotalPrice());
    } catch (e) {
      // print(e);
      return Future.error(e.toString());
    }
    return viewCartModel;
  }

  // getTotalPrice() {
  //   totalPrice = 0;
  //   for (int i = 0; i < viewCartModel.data.length; i++) {
  //     totalPrice = totalPrice + double.parse(viewCartModel.data![i].price);
  //   }
  //   return totalPrice;
  // }

  late CartCountModel cartCountModel;

  Future getCartCount() async {
    final String? token = await localStorage.getToken();

    try {
      cartCountModel = await _cartNetworking.getCartCount(token: token!);
      // notifyListeners();
    } catch (e) {
      return Future.error(e.toString());
    }
    notifyListeners();
    return cartCountModel;
  }

  late AddToCartModel addToCartModel;
  bool isAddingToCart = false;

  Future addToCart({
    required String productId,
    required String price,
    required String qty,
    required String cutPrice,
    required String offerPercentage,
  }) async {
    final String? token = await localStorage.getToken();
    isAddingToCart = true;
    notifyListeners();
    // double total = double.parse(price) * int.parse(qty);

    try {
      addToCartModel = await _cartNetworking.addToCart(
        userId: token!,
        productId: productId,
        qty: qty,
        price: price,
        // totalPrice: total.toString(),
        cutPrice: cutPrice,
        offerPercentage: offerPercentage,
      );
    } catch (e) {
      return Future.error(e.toString());
    }
    isAddingToCart = false;
    notifyListeners();
    return addToCartModel;
  }

  Future addToCartWithTogether({
    required String productId,
    required String together,
  }) async {
    final String? token = await localStorage.getToken();
    isAddingToCart = true;
    notifyListeners();
    // double total = double.parse(price) * int.parse(qty);

    try {
      addToCartModel = await _cartNetworking.addToCartWithTogether(
        userId: token!,
        productId: productId,
        together: together,
      );
    } catch (e) {
      return Future.error(e.toString());
    }
    isAddingToCart = false;
    notifyListeners();
    return addToCartModel;
  }

  //remove from cart
  late RemoveFromCartModel removeFromCartModel;
  Future removeProductFromCart({
    required String productId,
  }) async {
    try {
      removeFromCartModel = await _cartNetworking.removeCartItem(
        productId: productId,
      );
    } catch (e) {
      return Future.error(e.toString());
    }
    notifyListeners();
    return removeFromCartModel;
  }

  late UpdateCartModel updateCartModel;

  Future updateCart({
    required String cartId,
    required String qty,
    required String price,
    required String cutPrice,
  }) async {
    try {
      updateCartModel = await _cartNetworking.updateCart(
        cartId: cartId,
        qty: qty,
        price: price,
        cutPrice: cutPrice,
      );
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
    return updateCartModel;
  }
}
