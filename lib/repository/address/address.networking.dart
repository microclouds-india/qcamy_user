import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/address/addAddress.model.dart';
import 'package:qcamyapp/models/address/viewAddress.model.dart';

class AddressNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late ViewAddressModel viewAddressModel;

  Future<ViewAddressModel> getAddress({
    required String token,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "view_address"), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewAddressModel = ViewAddressModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return viewAddressModel;
  }

  late AddAddressModel addAddressModel;

  Future<AddAddressModel> addAddress({
    required String token,
    required String name,
    required String address,
    required String city,
    required String landmark,
    required String phone1,
    required String phone2,
    required String pincode,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "add_address"), body: {
        "token": token,
        "name": name,
        "address": address,
        "city": city,
        "landmark": landmark,
        "phone": phone1,
        "alternate_number": phone2,
        "pincode": pincode,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addAddressModel = AddAddressModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return addAddressModel;
  }
}
