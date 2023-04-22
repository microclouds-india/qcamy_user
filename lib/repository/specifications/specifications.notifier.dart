import 'package:flutter/material.dart';
import 'package:qcamyapp/models/specifications.model.dart';
import 'package:qcamyapp/repository/specifications/specifications.networking.dart';

class SpecificationsNotifier extends ChangeNotifier {
  final SpecificationsNetworking _specificationsNetworking = SpecificationsNetworking();

  late SpecificationsModel specificationsModel;

  String productId = "1";
  bool isLoading = false;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future getSpecifications(String productId) async {
    try {
      loading(true);
      specificationsModel = await _specificationsNetworking.getSpecifications(productId: productId);
      loading(false);
      return specificationsModel;
    } catch (e) {
      loading(false);
      return Future.error(e);
    }
  }
}
