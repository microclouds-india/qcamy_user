import 'dart:convert';

import 'package:qcamyapp/models/notification.model.dart';
import 'package:http/http.dart' as http;

class NotificationNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/notifications";

  final client = http.Client();

  late NotificationModel notificationModel;

  Future<NotificationModel> getNotifications({
    required String token,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        notificationModel = NotificationModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return notificationModel;
  }
}
