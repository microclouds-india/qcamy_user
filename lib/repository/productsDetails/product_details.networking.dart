import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/viewProduct.model.dart';

class ProductDetailsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/product_view";

  final client = http.Client();

  late ViewProductModel viewProductModel;
  //fetch product data
  Future<ViewProductModel> getProductDetails(
      {required String productId, required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"id": productId, "token": token}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewProductModel = ViewProductModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return viewProductModel;
  }
}
