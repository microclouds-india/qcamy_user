import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/search.model.dart';

class SearchNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/search";

  final client = http.Client();

  late SearchModel searchModel;

  //funtion to search and fetch all photographers and rental shops data
  Future<SearchModel> searchData(
      {String? keyword, required String category}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"title": keyword, "category": category});

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        searchModel = SearchModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return searchModel;
  }
}
