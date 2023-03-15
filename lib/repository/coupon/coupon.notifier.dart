import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qcamyapp/repository/coupon/coupon.networking.dart';

import '../../core/token_storage/storage.dart';
import '../../models/coupon.model.dart';
import '../../models/get_coupon.model.dart';

class CouponNotifier extends ChangeNotifier {
  final CouponNetworking _couponNetworking = CouponNetworking();
  LocalStorage localStorage = LocalStorage();

  late CouponModel couponModel;

  bool isCouponAdded = false;

  isLoading(bool value) {
    isCouponAdded = value;
    notifyListeners();
  }

  Future applyCoupon({required String couponCode}) async {
    final String? token = await localStorage.getToken();

    try {
      couponModel = await _couponNetworking.applyCoupon(
        token: token!,
        couponCode: couponCode,
      );
    } catch (e) {
      isLoading(false);
      return Future.error(e.toString());
    }
    isLoading(true);
    return couponModel;
  }

  late GetCouponModel getCouponModel;
  Future getCoupon() async {
    final String? token = await localStorage.getToken();
    try {
      getCouponModel = await _couponNetworking.getCoupon(token: token!);
      return getCouponModel;
    } catch (e) {
      // return Future.error(e);
      log(e.toString());
    }
  }
}
