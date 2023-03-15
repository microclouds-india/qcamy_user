import 'package:flutter/material.dart';
import 'package:qcamyapp/models/authentication/otpVerification.model.dart';
import 'package:qcamyapp/repository/otp%20verification/otpVerification.networking.dart';

class OTPNotifier extends ChangeNotifier {
  final VerifyOtpNetworking _verifyOtpNetworking = VerifyOtpNetworking();

  late String otp;
  bool isLoading = false;

  late VerifyOtpModel verifyOtpModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  verifyOTP({required dynamic mobileNumber, required dynamic otp}) async {
    loading(true);

    try {
      verifyOtpModel = await _verifyOtpNetworking.verifyOtp(
          mobileNumber: mobileNumber, otp: otp);

      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  verifyOTPForNewUser(
      {required dynamic mobileNumber,
      required dynamic otp,
      required dynamic name,
      required String gender,
      required String email}) async {
    loading(true);

    try {
      verifyOtpModel = await _verifyOtpNetworking.verifyOtpForNewUser(
          mobileNumber: mobileNumber,
          otp: otp,
          name: name,
          gender: gender,
          email: email);

      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
