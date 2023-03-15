import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:qcamyapp/models/enquire_product_details.model.dart';

class EnquireProductDetailsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/all_enquire_product_not_listed";

  final client = http.Client();

  late EnquireProductDetailsModel enquireProductDetailsModel;

  Future<EnquireProductDetailsModel> getEnquireProductDetails() async {
    try {
      final request =
      await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        enquireProductDetailsModel = EnquireProductDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return enquireProductDetailsModel;
  }

}
