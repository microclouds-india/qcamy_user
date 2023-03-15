import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/rentalEquipmentDetails.model.dart';

class RentalEquipmentDetailsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/profile_equipment";

  final client = http.Client();

  late RentalEquipmentDetailsModel rentalEquipmentDetailsModel;

  //get details of selected rental equipments in a shop
  Future<RentalEquipmentDetailsModel> getRentalEquipmentDetails({
    required String id,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalEquipmentDetailsModel =
            RentalEquipmentDetailsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return rentalEquipmentDetailsModel;
  }
}
