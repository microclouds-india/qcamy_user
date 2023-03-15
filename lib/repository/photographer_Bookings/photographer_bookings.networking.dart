import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/photographerBookings.model.dart';

class PhotographerBookingsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late PhotographerBookingsModel photographerBookingsModel;

  Future<PhotographerBookingsModel> getPhotographerBookings(
      {required dynamic token}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "photographer_user_bookings"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        photographerBookingsModel =
            PhotographerBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return photographerBookingsModel;
  }
}
