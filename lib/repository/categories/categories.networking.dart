import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/categories.model.dart';

class CategoryNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/categories";

  final client = http.Client();

  late CategoryModel categoryModel;

  //fetches list of categories
  Future<CategoryModel> getCategories() async {
    try {
      final request = await client
          .get(Uri.parse(urlENDPOINT))
          .timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        categoryModel = CategoryModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return categoryModel;
  }
}
