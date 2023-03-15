import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/hot_products.model.dart';

import 'hot_products.networking.dart';

class HotProductsNotifier extends ChangeNotifier {
  final HotProductsNetworking _hotProductsNetworking = HotProductsNetworking();

  late HotProductsModel hotProductsModel;
  LocalStorage localStorage = LocalStorage();

  Future getHotProducts() async {
    try {
      final String? token = await localStorage.getToken();
      hotProductsModel = await _hotProductsNetworking.getHotProducts(token: token!);
    } catch (e) {
      // throw Exception(e);

    }
    notifyListeners();
    return hotProductsModel;
  }
}
