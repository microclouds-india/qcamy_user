import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/cart/viewCart.model.dart';
import 'package:qcamyapp/models/notification.model.dart';
import 'package:qcamyapp/repository/notification/notification.networking.dart';

class NotificationNotifier extends ChangeNotifier {
  final NotificationNetworking _notificationNetworking =
      NotificationNetworking();
  LocalStorage localStorage = LocalStorage();

  late ViewCartModel viewCartModel;

  late NotificationModel notificationModel;

  Future getNotifications() async {
    final String? token = await localStorage.getToken();
    // print(token);
    try {
      notificationModel =
          await _notificationNetworking.getNotifications(token: token!);
    } catch (e) {
      return Future.error(e.toString());
    }
    return notificationModel;
  }
}
