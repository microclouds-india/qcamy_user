import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/hot_products.model.dart';

class HotProductsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/hot_products";

  final client = http.Client();

  late HotProductsModel hotProductsModel;

  Future<HotProductsModel> getHotProducts({required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        hotProductsModel = HotProductsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return hotProductsModel;
  }
}
