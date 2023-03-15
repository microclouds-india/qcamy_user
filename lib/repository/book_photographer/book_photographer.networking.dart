import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/bookPhotographer.model.dart';

class BookPhotographerNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/request_booking";

  final client = http.Client();

  late BookPhotographerModel bookPhotographerModel;

  //function to book photographer
  Future<BookPhotographerModel> bookPhotographer({
    required String token,
    required String photographerId,
    required String bookingDate,
    required String bookingPlace,
    required String name,
    required String phone,
    required String alternateNumber,
    required String bookingPurpose,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "photographer_id": photographerId,
        "booking_date": bookingDate,
        "booking_place": bookingPlace,
        "name": name,
        "alternate_number": alternateNumber,
        "phone": phone,
        "booking_purpose": bookingPurpose,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        bookPhotographerModel = BookPhotographerModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return bookPhotographerModel;
  }
}
