import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/rentaEquipments.model.dart';

class RentalEquipmentsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/equipments";

  final client = http.Client();

  late RentalEquipmentModel rentalEquipmentModel;

  //get list of rental equipments in a shop
  Future<RentalEquipmentModel> getRentalEquipments({
    required String id,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "id": id,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalEquipmentModel = RentalEquipmentModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return rentalEquipmentModel;
  }
}
