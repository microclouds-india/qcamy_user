import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/brands.model.dart';

class BrandsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/brands";

  final client = http.Client();

  late BrandsModel brandsModel;

  Future<BrandsModel> getBrands() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        brandsModel = BrandsModel.fromJson(response);
        print(brandsModel);
      }
    } catch (e) {
      throw Exception(e);
    }
    return brandsModel;
  }
}
