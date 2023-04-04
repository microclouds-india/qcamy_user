import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/supportQuestions.model.dart';
import 'package:qcamyapp/repository/supportQuestions/supportQuestions.networking.dart';


class SupportQuestionsNotifier extends ChangeNotifier {

  final SupportQuestionsNetworking _supportQuestionsNetworking = SupportQuestionsNetworking();

  late SupportQuestionsModel supportQuestionsModel;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future allSupportQuestions() async {
    loading(true);
    try {
      final String? token = await localStorage.getToken();
      supportQuestionsModel = await _supportQuestionsNetworking.allSupportQuestions(token: token!);
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return supportQuestionsModel;
  }

}
