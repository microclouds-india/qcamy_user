import 'package:flutter/material.dart';
import 'package:qcamyapp/models/singleAdBanner.model.dart';
import 'package:qcamyapp/repository/singleAdBanner/singleAdBanner.networking.dart';

class RefreshNotifier extends ChangeNotifier {
  final SingleAdBannerNetworking _singleAdBannerNetworking =
      SingleAdBannerNetworking();

  late SingleAdbannerModel singleAdbannerModel;

  // a function to refresh data using single adBanner data
  //it just try to fetch data from api and if the request is successfull then it will notify the listeners
  //and use consumer to update the entire ui and data
  Future refresh() async {
    try {
      singleAdbannerModel = await _singleAdBannerNetworking.getSingleAdBanner();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
    return singleAdbannerModel;
  }
}
