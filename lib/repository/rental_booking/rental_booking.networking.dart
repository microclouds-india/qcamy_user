import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/models/rentalBookingResponse.model.dart';

class BookRentalsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/rentalshop_booking";

  final client = http.Client();

  late RentalProductBookingResponseModel rentalProductBookingResponseModel;

  Future<RentalProductBookingResponseModel> bookRentalEquipment({
    required String token,
    required String rentalShopId,
    required String bookingDate,
    required String address,
    required String phone,
    required String qty,
    required String equipmentId,
    required String bookingTime,
    required String bookingToDate,
    required String bookingToTime,
    required List<XFile>? imageList,
  }) async {
    // try {
    //   final request = await client.post(Uri.parse(urlENDPOINT), body: {
    //     "token": token,
    //     "rentalshop_id": rentalShopId,
    //     "equipment_id": equipmentId,
    //     "booking_date": bookingDate,
    //     "booking_time": bookingTime,
    //     "booking_todate": bookingToDate,
    //     "booking_totime": bookingToTime,
    //     "address": address,
    //     "qty": qty,
    //     "phone": phone,
    //     "order_status": "ordered",
    //   });
    //
    //   if (request.statusCode == 200) {
    //     final response = json.decode(request.body);
    //     rentalProductBookingResponseModel =
    //         RentalProductBookingResponseModel.fromJson(response);
    //   }
    // } catch (e) {
    //   throw Exception(e);
    // }
    try {
      final request = http.MultipartRequest('POST', Uri.parse(urlENDPOINT));
      request.fields['token'] = token;
      request.fields['rentalshop_id'] = rentalShopId;
      request.fields['equipment_id'] = equipmentId;
      request.fields['booking_date'] = bookingDate;
      request.fields['booking_time'] = bookingTime;
      request.fields['booking_todate'] = bookingToDate;
      request.fields['booking_totime'] = bookingToTime;
      request.fields['address'] = address;
      request.fields['qty'] = qty;
      request.fields['phone'] = phone;
      request.fields['order_status'] = "ordered";

      //add multiple image to the request
      for (var i = 0; i < imageList!.length; i++) {
        request.files.add(
          http.MultipartFile("aadhar", imageList[i].readAsBytes().asStream(),
              await imageList[i].length(),
              filename: imageList[i].name),
        );
      }
      var requestResponse = await request.send();

      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;

        if (requestResponse.statusCode == 200) {
          rentalProductBookingResponseModel = RentalProductBookingResponseModel.fromJson(jsonResponse);
        }
      });
    } catch (e) {
      throw Exception(e);
    }
    return rentalProductBookingResponseModel;
  }
}
