import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/photographerBookings.model.dart';
import 'package:qcamyapp/repository/photographer_Bookings/photographer_bookings.networking.dart';

class PhotographerBookingsNotifier extends ChangeNotifier {
  final PhotographerBookingsNetworking _photographerBookingsNetworking =
      PhotographerBookingsNetworking();

  String orderId = "0";

  late PhotographerBookingsModel photographerBookingsModel;
  Future getPhotographerBookings() async {
    LocalStorage localStorage = LocalStorage();
    final String? token = await localStorage.getToken();

    try {
      photographerBookingsModel = await _photographerBookingsNetworking
          .getPhotographerBookings(token: token);
    } catch (e) {
      return Future.error(e);
    }
    return photographerBookingsModel;
  }
}
