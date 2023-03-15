import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/adBanner.model.dart';
import 'package:qcamyapp/models/applyInBottomAds.model.dart';
import 'package:qcamyapp/models/bottomSlidingAdDetails.model.dart';

import '../../models/bottomSlidingAds.model.dart';

class SliderAdBannerNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late AdBannerModel adBannerModel;

  //fetches slider adBanner data
  Future<AdBannerModel> getSliderAdBanners() async {
    try {
      final request = await client.get(Uri.parse(urlENDPOINT + "banners"));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        adBannerModel = AdBannerModel.fromJson(response);

        return adBannerModel;
      }
    } catch (e) {
      throw Exception(e);
    }
    return adBannerModel;
  }

  late BottomSlidingAdsModel bottomAdBannersModel;

  Future<BottomSlidingAdsModel> getBottomSlidingAds() async {
    try {
      final request =
          await client.get(Uri.parse(urlENDPOINT + "tools_banners"));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        bottomAdBannersModel = BottomSlidingAdsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return bottomAdBannersModel;
  }

  late BottomSlidingAdDetailsModel bottomSlidingAdDetailsModel;
  Future<BottomSlidingAdDetailsModel> getBottomSlidingAdDetails(
      {required String bannerId}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "view_tools_banner"), body: {
        "banner_id": bannerId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        bottomSlidingAdDetailsModel =
            BottomSlidingAdDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return bottomSlidingAdDetailsModel;
  }

  late ApplyInBottomAdsModel applyInBottomAdsModel;
  Future<ApplyInBottomAdsModel> applyInBottomAds(
      {required String bannerId,
      required String name,
      required String phone,
      required String email,
      required String token}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "tools_apply"), body: {
        "token": token,
        "name": name,
        "phone": phone,
        "email": email,
        "banner_id": bannerId,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        applyInBottomAdsModel = ApplyInBottomAdsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return applyInBottomAdsModel;
  }
}
