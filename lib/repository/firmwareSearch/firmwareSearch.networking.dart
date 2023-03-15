import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/firmwareSearchModel.dart';

class FirmwareSearchNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/search_firmwares";

  final client = http.Client();

  late FirmwareSearchModel firmwareSearchModel;

  Future<FirmwareSearchModel> searchData({required String title}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "title": title,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        firmwareSearchModel = FirmwareSearchModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return firmwareSearchModel;
  }
}
