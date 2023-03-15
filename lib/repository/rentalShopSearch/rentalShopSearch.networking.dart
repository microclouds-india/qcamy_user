import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/rentalShopSearch.model.dart';

class RentalShopSearchNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/search_rentalshop";

  final client = http.Client();

  late RentalShopSearchModel rentalShopSearchModel;

  Future<RentalShopSearchModel> searchData({required String title}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "title": title,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        rentalShopSearchModel = RentalShopSearchModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return rentalShopSearchModel;
  }
}
