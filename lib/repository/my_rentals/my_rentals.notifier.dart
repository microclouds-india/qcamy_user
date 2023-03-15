import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/rentalBookings.model.dart';
import 'package:qcamyapp/repository/my_rentals/my_rentals.networking.dart';

import '../../models/rentalBookingDetails.model.dart';

class MyRentalBookingsNotifier extends ChangeNotifier {
  final MyRentalBookingsNetworking _myRentalBookingsNetworking =
      MyRentalBookingsNetworking();

  String orderId = "0";

  late MyRentalBookingsModel myRentalBookingsModel;
  Future getMyRentalBookings() async {
    LocalStorage localStorage = LocalStorage();
    final String? token = await localStorage.getToken();

    try {
      myRentalBookingsModel =
          await _myRentalBookingsNetworking.getMyRentals(token: token);
    } catch (e) {
      return Future.error(e);
    }
    return myRentalBookingsModel;
  }

  late RentalBookingDetailsModel rentalBookingDetailsModel;
  Future getRentalBookingDetails() async {
    try {
      rentalBookingDetailsModel = await _myRentalBookingsNetworking
          .getRentalBookingDetails(id: orderId);
    } catch (e) {
      return Future.error(e);
    }
    return rentalBookingDetailsModel;
  }
}
