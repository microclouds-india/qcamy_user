import 'package:flutter/material.dart';
import 'package:qcamyapp/models/homeSearch.model.dart';
import 'package:qcamyapp/repository/home_search/home_search.networking.dart';

class HomeSearchNotifier extends ChangeNotifier {
  final HomeSearchNetworking _homeSearchNetworking = HomeSearchNetworking();

  late HomeSearchModel homeSearchModel;

  Future searchData({required String title}) async {
    try {
      homeSearchModel = await _homeSearchNetworking.searchData(title: title);
      notifyListeners();
      return homeSearchModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
