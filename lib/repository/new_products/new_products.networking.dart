import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/new_products.model.dart';

class NewProductsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/new_products";

  late NewArrivalsModel newArrivalsModel;

  Future<NewArrivalsModel> getNewProducts({required String token}) async {
    try {
      final request = await http.post(Uri.parse(urlENDPOINT),);

      if (request.statusCode == 200) {
        final response = jsonDecode(request.body);
        newArrivalsModel = NewArrivalsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return newArrivalsModel;
  }
}
