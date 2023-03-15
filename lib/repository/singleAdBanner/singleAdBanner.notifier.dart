import 'package:flutter/material.dart';
import 'package:qcamyapp/models/singleAdBanner.model.dart';
import 'package:qcamyapp/repository/singleAdBanner/singleAdBanner.networking.dart';

class SingleAdBannerNotifier extends ChangeNotifier {
  final SingleAdBannerNetworking _singleAdBannerNetworking =
      SingleAdBannerNetworking();

  // bool haveError = false;

  late SingleAdbannerModel singleAdbannerModel;

  Future getSingleAdBanner() async {
    try {
      singleAdbannerModel = await _singleAdBannerNetworking.getSingleAdBanner();

      return singleAdbannerModel;
    } catch (e) {
      // haveError = true;
      // notifyListeners();
      return Future.error(e);
    }
  }
}
