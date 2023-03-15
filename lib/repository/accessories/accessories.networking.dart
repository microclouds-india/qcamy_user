import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/accessories.model.dart';

class AccessoriesNetworking {
  // static const String urlENDPOINT = "https://cashbes.com/photography/apis/products?catid=1";
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/products";
  static const String urlENDPOINTPRODUCTS = "https://cashbes.com/photography/apis/products";

  final client = http.Client();

  late AccessoriesModel accessoriesModel;

  //fetch categories data
  Future<AccessoriesModel> getAccessories({required String categoryId, required String token}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"catid": categoryId, "token": token}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        accessoriesModel = AccessoriesModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return accessoriesModel;
  }

  Future<AccessoriesModel> getBrandsItems({required String brandId}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"brand_id": brandId}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        accessoriesModel = AccessoriesModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return accessoriesModel;
  }

  Future<AccessoriesModel> getProducts() async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINTPRODUCTS)).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        accessoriesModel = AccessoriesModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return accessoriesModel;
  }
}
