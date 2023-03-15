import 'package:flutter/material.dart';
import 'package:qcamyapp/models/orderSuccess.model.dart';
import 'package:qcamyapp/repository/buy_now/buy_now.networking.dart';

import '../../core/token_storage/storage.dart';

class OrderNotifier extends ChangeNotifier {
  final OrderNetworking _orderNetworking = OrderNetworking();
  LocalStorage localStorage = LocalStorage();

  late OrderSuccessModel orderSuccessModel;

  bool loading = false;

  bool isBuyingSingleItem = false;

  isLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  bool conformedCOD = false;

  conformCOD(bool value) {
    conformedCOD = value;
    notifyListeners();
  }

  Future buyAllCart({
    required String subTotal,
    required String totalDiscount,
    required String totalProductPrice,
    required String orderStatus,
    required String address,
    required String coupenCode,
  }) async {
    isLoading(true);
    final String? token = await localStorage.getToken();

    try {
      orderSuccessModel = await _orderNetworking.buyAllCart(
        token: token!,
        subTotal: subTotal,
        totalDiscount: totalDiscount,
        totalProductPrice: totalProductPrice,
        orderStatus: orderStatus,
        address: address,
        couponCode: coupenCode,
      );
    } catch (e) {
      return Future.error(e.toString());
    }
    isLoading(false);
    return orderSuccessModel;
  }

  Future buySingleItem({
    required String subTotal,
    required String totalDiscount,
    required String totalProductPrice,
    required String orderStatus,
    required String address,
    required String productId,
  }) async {
    isLoading(true);
    final String? token = await localStorage.getToken();

    try {
      orderSuccessModel = await _orderNetworking.buySingleItem(
          token: token!,
          subTotal: subTotal,
          totalDiscount: totalDiscount,
          totalProductPrice: totalProductPrice,
          orderStatus: orderStatus,
          address: address,
          cartId: productId);
    } catch (e) {
      return Future.error(e.toString());
    }
    isLoading(false);
    return orderSuccessModel;
  }
}
