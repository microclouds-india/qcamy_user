import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/singleAdBanner.model.dart';

class SingleAdBannerNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/single_banner";

  final client = http.Client();

  late SingleAdbannerModel singleAdbannerModel;

  //function to fetch single adBanner data
  Future<SingleAdbannerModel> getSingleAdBanner() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        singleAdbannerModel = SingleAdbannerModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return singleAdbannerModel;
  }
}
