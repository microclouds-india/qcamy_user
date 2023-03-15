import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/together_products.model.dart';

class TogetherProductsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/together_products";

  final client = http.Client();

  late TogetherProductsModel togetherProductsModel;

  Future<TogetherProductsModel> getTogetherProducts({required String product_id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"product_id": product_id}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        togetherProductsModel = TogetherProductsModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return togetherProductsModel;
  }
}
