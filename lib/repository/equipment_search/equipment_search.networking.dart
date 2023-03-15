import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/equipmentSearch.model.dart';

class EquipmentSearchNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/search_equipments";

  final client = http.Client();

  late EquipmentSearchModel equipmentSearchModel;

  Future<EquipmentSearchModel> searchData({required String title}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "title": title,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        equipmentSearchModel = EquipmentSearchModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return equipmentSearchModel;
  }
}
