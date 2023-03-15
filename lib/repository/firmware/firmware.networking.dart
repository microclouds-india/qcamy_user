import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/firmware.model.dart';

class FirmwareNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/firewares";

  final client = http.Client();

  late FirmwareModel firmwareModel;

  Future<FirmwareModel> searchData() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT),
      );

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        firmwareModel = FirmwareModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return firmwareModel;
  }
}
