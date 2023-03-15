import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/new_products.model.dart';

class NewProductsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/new_products";

  final client = http.Client();

  late NewArrivalsModel newArrivalsModel;

  Future<NewArrivalsModel> getNewProducts({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        newArrivalsModel = NewArrivalsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return newArrivalsModel;
  }
}
