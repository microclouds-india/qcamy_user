import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/rentalBookings.model.dart';

import '../../models/rentalBookingDetails.model.dart';

class MyRentalBookingsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late MyRentalBookingsModel myRentalBookingsModel;

  Future<MyRentalBookingsModel> getMyRentals({required dynamic token}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "rentalshop_orders"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        myRentalBookingsModel = MyRentalBookingsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return myRentalBookingsModel;
  }

  late RentalBookingDetailsModel rentalBookingDetailsModel;

  Future<RentalBookingDetailsModel> getRentalBookingDetails(
      {required String id}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "rentalshop_order_details"), body: {
        "order_id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalBookingDetailsModel =
            RentalBookingDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return rentalBookingDetailsModel;
  }
}
