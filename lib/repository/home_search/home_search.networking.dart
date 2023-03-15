import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/homeSearch.model.dart';

class HomeSearchNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/search_products";

  final client = http.Client();

  late HomeSearchModel homeSearchModel;

  Future<HomeSearchModel> searchData({required String title}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "title": title,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        homeSearchModel = HomeSearchModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return homeSearchModel;
  }
}
