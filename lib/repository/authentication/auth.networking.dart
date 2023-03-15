import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/authentication/authentication.model.dart';

class AuthenticationNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/login/index";

  final client = http.Client();

  late AuthenticationModel authModel;

  //send otp and autehnticate user
  Future<AuthenticationModel> loginUser({required String mobileNumber}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"phone": mobileNumber}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        authModel = AuthenticationModel.fromJson(response);

        return authModel;
      }
    } catch (e) {
      throw Exception(e);
    }
    return authModel;
  }
}
