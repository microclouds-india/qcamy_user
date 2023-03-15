import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/related_products.model.dart';

class RelatedProductsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/related_products";

  final client = http.Client();

  late RelatedProductsModel relatedProductsModel;

  Future<RelatedProductsModel> getRelatedProducts(
      {required String categoryId}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"catid": categoryId}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        relatedProductsModel = RelatedProductsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return relatedProductsModel;
  }
}
