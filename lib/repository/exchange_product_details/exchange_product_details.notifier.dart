import 'package:flutter/material.dart';
import 'package:qcamyapp/models/exchange_product_details.model.dart';
import 'package:qcamyapp/repository/exchange_product_details/exchange_product_details_networking.dart';

class ExchangeProductDetailsNotifier extends ChangeNotifier {
  final ExchangeProductDetailsNetworking exchangeProductDetailsNetworking = ExchangeProductDetailsNetworking();

  ExchangeProductDetailsModel? exchangeProductDetailsModel;

  bool isLoading = false;

  Future getExchangeProductDetails() async {
    isLoading = true;
    try {
      exchangeProductDetailsModel = await exchangeProductDetailsNetworking.getExchangeProductDetails();
    } catch (e) {
      return Future.error(e);
    }
    isLoading = false;
    notifyListeners();
    return exchangeProductDetailsModel;
  }
}
