import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/cancelOrder.model.dart';
import 'package:qcamyapp/models/myOrders.model.dart';
import 'package:qcamyapp/models/orderDetails.model.dart';
import 'package:qcamyapp/repository/myOrders/my_orders.networking.dart';

class MyOrdersNotifier extends ChangeNotifier {
  final MyOrdersNetworking _myOrdersNetworking = MyOrdersNetworking();

  String orderId = "0";

  late MyOrdersModel myOrdersModel;
  Future getMyOrder() async {
    LocalStorage localStorage = LocalStorage();
    final String? token = await localStorage.getToken();

    try {
      myOrdersModel = await _myOrdersNetworking.getMyOrders(token: token);
    } catch (e) {
      return Future.error(e);
    }
    return myOrdersModel;
  }

  bool isCancelingOrder = false;

  cancelingOrder(bool value) {
    isCancelingOrder = value;
    notifyListeners();
  }

  late OrderDetailsModel orderDetailsModel;
  Future getOrderDetails() async {
    try {
      orderDetailsModel =
          await _myOrdersNetworking.getOrderDetails(orderId: orderId);
    } catch (e) {
      return Future.error(e);
    }
    return orderDetailsModel;
  }

  late CancelOrderModel cancelOrderModel;
  Future cancelOrder({required dynamic orderId}) async {
    cancelingOrder(true);
    try {
      cancelOrderModel =
          await _myOrdersNetworking.cancelOrder(orderId: orderId);
      cancelingOrder(false);
    } catch (_) {
      cancelingOrder(false);
    }
  }
}
