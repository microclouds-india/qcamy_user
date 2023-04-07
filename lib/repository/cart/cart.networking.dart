import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/cart/addToCart.model.dart';
import 'package:qcamyapp/models/cart/cartCount.model.dart';
import 'package:qcamyapp/models/cart/removeFromCart.model.dart';
import 'package:qcamyapp/models/cart/viewCart.model.dart';
import 'package:qcamyapp/models/saveItForLaterItems.model.dart';
import 'package:qcamyapp/models/saveitforlater.model.dart';

import '../../models/cart/updateCart.model.dart';

class CartNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late ViewCartModel viewCartModel;

  //get items in the cart
  Future<ViewCartModel> getCartItems({
    required String token,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "view_cart"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      // print(token);
      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewCartModel = ViewCartModel.fromJson(response);
        // print(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return viewCartModel;
  }

  late CartCountModel cartCountModel;
  late SaveItForLaterModel saveItForLaterModel;
  late SaveItForLaterItemsModel saveItForLaterItemsModel;

  //get number of items in cart
  Future<CartCountModel> getCartCount({
    required String token,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "cart_count"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        cartCountModel = CartCountModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return cartCountModel;
  }

  late AddToCartModel addToCartModel;

  //add to cart
  Future<AddToCartModel> addToCart({
    required String userId,
    required String productId,
    required String price,
    required String qty,
    // required String totalPrice,
    required String cutPrice,
    required String offerPercentage,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "add_to_cart"), body: {
        "token": userId,
        "product_id": productId,
        "price": price,
        "qty": qty,
        // "total_price": totalPrice,
        "cut_price": cutPrice,
        "offer_per": offerPercentage,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addToCartModel = AddToCartModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return addToCartModel;
  }

  Future<AddToCartModel> addToCartWithTogether({
    required String userId,
    required String productId,
    required String together,
  }) async {
    try {
      final request =
      await client.post(Uri.parse(urlENDPOINT + "together_add_to_cart"), body: {
        "token": userId,
        "product_id": productId,
        "together": together,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addToCartModel = AddToCartModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return addToCartModel;
  }

  //remove from cart
  late RemoveFromCartModel removeCartItemModel;

  Future<RemoveFromCartModel> removeCartItem({
    required String productId,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "cart_remove"), body: {
        "id": productId,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        removeCartItemModel = RemoveFromCartModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return removeCartItemModel;
  }

  late UpdateCartModel updateCartModel;

  Future<UpdateCartModel> updateCart({
    required String cartId,
    required String qty,
    required String price,
    required String cutPrice,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "update_cart"), body: {
        "cart_id": cartId,
        "qty": qty,
        "price": price,
        "cut_price": cutPrice,
      });
      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        updateCartModel = UpdateCartModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return updateCartModel;
  }

  Future<SaveItForLaterModel> saveItForLater({
    required String token,
    required String id,
  }) async {
    try {
      final request =
      await client.post(Uri.parse(urlENDPOINT + "saveit_later"), body: {
        "token": token,
        "id": id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        saveItForLaterModel = SaveItForLaterModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return saveItForLaterModel;
  }

  Future<SaveItForLaterItemsModel> saveItForLaterItems({
    required String token,
  }) async {
    try {
      final request =
      await client.post(Uri.parse(urlENDPOINT + "saveit_later_items"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        saveItForLaterItemsModel = SaveItForLaterItemsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return saveItForLaterItemsModel;
  }
}
