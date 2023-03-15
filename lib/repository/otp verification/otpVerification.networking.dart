import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/authentication/otpVerification.model.dart';

class VerifyOtpNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/login/existuser_otp";

  final client = http.Client();

  late VerifyOtpModel verifyOtpModel;

  //function to verify otp for existing user
  Future<VerifyOtpModel> verifyOtp(
      {required String mobileNumber, required String otp}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "phone": mobileNumber,
        "otp": otp
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        verifyOtpModel = VerifyOtpModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return verifyOtpModel;
  }

  //function to verify otp for new user
  static const String urlENDPOINT2 =
      "https://cashbes.com/photography/login/register";

  Future<VerifyOtpModel> verifyOtpForNewUser(
      {required String mobileNumber,
      required String otp,
      required String name,
      required String gender,
      required String email}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT2), body: {
        "phone": mobileNumber,
        "name": name,
        "otp": otp,
        "gender": gender,
        "email": email
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        verifyOtpModel = VerifyOtpModel.fromJson(response);
        // print(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return verifyOtpModel;
  }
}
