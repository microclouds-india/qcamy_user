import 'package:flutter/material.dart';
import 'package:qcamyapp/repository/authentication/auth.networking.dart';
import 'package:qcamyapp/models/authentication/authentication.model.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthenticationNetworking _authenticationNetworking =
      AuthenticationNetworking();

  late String mobileNumber;
  bool isLoading = false;

  late AuthenticationModel authModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  loginUser({required dynamic mobileNumber}) async {
    loading(true);

    try {
      authModel =
          await _authenticationNetworking.loginUser(mobileNumber: mobileNumber);

      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
