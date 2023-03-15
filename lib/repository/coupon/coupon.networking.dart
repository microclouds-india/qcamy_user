import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/coupon.model.dart';
import 'package:qcamyapp/models/get_coupon.model.dart';

class CouponNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late CouponModel couponModel;

  Future<CouponModel> applyCoupon({
    required String token,
    required String couponCode,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "coupon_apply"), body: {
        "token": token,
        "coupon_code": couponCode,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        couponModel = CouponModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return couponModel;
  }

  late GetCouponModel getCouponModel;

  Future<GetCouponModel> getCoupon({
    required String token,
  }) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "get_coupon"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        getCouponModel = GetCouponModel.fromJson(response);
      }
    } catch (e) {
      // print(e);
      return Future.error(e.toString());
    }
    return getCouponModel;
  }
}
