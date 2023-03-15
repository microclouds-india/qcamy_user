import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:qcamyapp/models/enquire_product_details.model.dart';
import 'package:qcamyapp/models/exchange_product_details.model.dart';

class ExchangeProductDetailsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/all_exchange_product";

  final client = http.Client();

  late ExchangeProductDetailsModel exchangeProductDetailsModel;

  Future<ExchangeProductDetailsModel> getExchangeProductDetails() async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        exchangeProductDetailsModel = ExchangeProductDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return exchangeProductDetailsModel;
  }

}
