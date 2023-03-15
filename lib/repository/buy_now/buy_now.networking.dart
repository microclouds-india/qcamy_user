import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/orderSuccess.model.dart';

class OrderNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late OrderSuccessModel orderSuccessModel;

  //get order response
  Future<OrderSuccessModel> buyAllCart({
    required String token,
    required String subTotal,
    required String totalDiscount,
    required String totalProductPrice,
    required String orderStatus,
    required String address,
    required String couponCode,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "buy_now_allcart"), body: {
        "token": token,
        "sub_total": subTotal,
        "total_discount": totalDiscount,
        "order_status": orderStatus,
        "total_product_price": totalProductPrice,
        "address": address,
        "coupon_code": couponCode,
      });
      // print(token);
      // print(subTotal);
      // print(totalDiscount);
      // print(totalProductPrice);
      // print(orderStatus);
      // print(address);

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        orderSuccessModel = OrderSuccessModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return orderSuccessModel;
  }

  Future<OrderSuccessModel> buySingleItem({
    required String token,
    required String subTotal,
    required String totalDiscount,
    required String totalProductPrice,
    required String orderStatus,
    required String cartId,
    required String address,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "buy_now"), body: {
        "token": token,
        "sub_total": subTotal,
        "total_discount": totalDiscount,
        "order_status": orderStatus,
        "total_product_price": totalProductPrice,
        "cart_id": cartId,
        "address": address,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        orderSuccessModel = OrderSuccessModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return orderSuccessModel;
  }
}
