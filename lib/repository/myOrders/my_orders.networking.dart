import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/cancelOrder.model.dart';
import 'package:qcamyapp/models/orderDetails.model.dart';

import '../../models/myOrders.model.dart';

class MyOrdersNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late MyOrdersModel myOrdersModel;

  Future<MyOrdersModel> getMyOrders({required dynamic token}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "my_orders"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        myOrdersModel = MyOrdersModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return myOrdersModel;
  }

  late OrderDetailsModel orderDetailsModel;

  Future<OrderDetailsModel> getOrderDetails({required String orderId}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "order_details"), body: {
        "order_id": orderId,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        orderDetailsModel = OrderDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return orderDetailsModel;
  }

  late CancelOrderModel cancelOrderModel;

  Future<CancelOrderModel> cancelOrder({required dynamic orderId}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "order_cancel"), body: {
        "order_id": orderId,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        cancelOrderModel = CancelOrderModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return cancelOrderModel;
  }
}
