import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/bottomSlidingAds.model.dart';

import '../../models/adBanner.model.dart';
import '../../models/applyInBottomAds.model.dart';
import '../../models/bottomSlidingAdDetails.model.dart';
import 'sliderAdBanner.networking.dart';

class SliderAdBannerNotifier extends ChangeNotifier {
  final SliderAdBannerNetworking _sliderAdBannerNetworking =
      SliderAdBannerNetworking();

  // bool isLoading = false;

  late AdBannerModel adBannerModel;

  bool haveError = false;

  Future getSliderAdBanners(BuildContext context) async {
    try {
      adBannerModel = await _sliderAdBannerNetworking.getSliderAdBanners();
      haveError = false;
      notifyListeners();
      return adBannerModel;
    } catch (e) {
      // loading(false);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   backgroundColor: Colors.red,
      //   behavior: SnackBarBehavior.floating,
      //   content: Text("something went wrong!"),
      // ));
      haveError = true;
      notifyListeners();
    }
  }

  late BottomSlidingAdsModel bottomSlidingAdsModel;

  String bannedId = "";
  Future getBottomSlidingAds() async {
    try {
      bottomSlidingAdsModel =
          await _sliderAdBannerNetworking.getBottomSlidingAds();
    } catch (e) {
      return Future.error(e);
    }
    return bottomSlidingAdsModel;
  }

  late BottomSlidingAdDetailsModel bottomSlidingAdDetailsModel;
  Future getBottomSlidingAdDetails() async {
    try {
      bottomSlidingAdDetailsModel = await _sliderAdBannerNetworking
          .getBottomSlidingAdDetails(bannerId: bannedId);
    } catch (e) {
      return Future.error(e);
    }
    return bottomSlidingAdDetailsModel;
  }

  late ApplyInBottomAdsModel applyInBottomAdsModel;
  bool isApplying = false;
  Future applyInBottomAds(
      {required String name,
      required String email,
      required String phone}) async {
    try {
      isApplying = true;
      notifyListeners();
      LocalStorage localStorage = LocalStorage();
      final String? token = await localStorage.getToken();
      applyInBottomAdsModel = await _sliderAdBannerNetworking.applyInBottomAds(
          token: token!,
          name: name,
          phone: phone,
          email: email,
          bannerId: bannedId);
      isApplying = false;
      notifyListeners();
    } catch (e) {
      isApplying = false;
      notifyListeners();
      return Future.error(e);
    }
    return applyInBottomAdsModel;
  }
}
