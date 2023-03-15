import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/locationData.model.dart';


class LocationDataNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/lat_long_user";

  final client = http.Client();

  late LocationDataModel locationDataModel;

  Future<LocationDataModel> addLocationData({required String token, required String lat, required String long}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "lat": lat,
        "long": long,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        locationDataModel = LocationDataModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return locationDataModel;
  }
}
