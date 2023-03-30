import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/help.model.dart';
import 'package:qcamyapp/repository/help/help.networking.dart';


class HelpNotifier extends ChangeNotifier {
  final HelpNetworking _helpNetworking = HelpNetworking();

  late HelpModel helpModel;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future addHelpData({required String question}) async {
    loading(true);
    try {
      final String? token = await localStorage.getToken();
      helpModel = await _helpNetworking.addHelpData(token: token!, question: question);
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return helpModel;
  }
}
