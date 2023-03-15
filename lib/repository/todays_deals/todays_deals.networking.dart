import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/todaysDeals.model.dart';

class TodaysDealsNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/all_deals";

  final client = http.Client();

  late TodaysDealsModel todaysDealsModel;

  Future<TodaysDealsModel> getTodaysDeals() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        todaysDealsModel = TodaysDealsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return todaysDealsModel;
  }
}
