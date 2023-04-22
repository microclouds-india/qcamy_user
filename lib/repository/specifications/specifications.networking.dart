import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/specifications.model.dart';

class SpecificationsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/spec_template";

  final client = http.Client();

  late SpecificationsModel specificationsModel;
  //fetch product data
  Future<SpecificationsModel> getSpecifications(
      {required String productId}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"product_id": productId}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        print("aaaaa"+specificationsModel.status);
        specificationsModel = SpecificationsModel.fromJson(response);
        print("bbbbb"+specificationsModel.status);
      }
    } catch (e) {
      throw Exception(e);
    }
    return specificationsModel;
  }
}
