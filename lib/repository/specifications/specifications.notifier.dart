import 'package:flutter/material.dart';
import 'package:qcamyapp/models/specifications.model.dart';
import 'package:qcamyapp/repository/specifications/specifications.networking.dart';

class SpecificationsNotifier extends ChangeNotifier {
  final SpecificationsNetworking _specificationsNetworking = SpecificationsNetworking();

  late SpecificationsModel specificationsModel;

  String productId = "1";

  bool isDataLoaded = false;

  Future getSpecifications(String productId) async {
    try {
      specificationsModel = await _specificationsNetworking.getSpecifications(productId: productId);
      isDataLoaded = true;
      notifyListeners();

      return specificationsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
