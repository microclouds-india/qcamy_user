import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/new_products.model.dart';

import 'new_products.networking.dart';

class NewProductsNotifier extends ChangeNotifier {
  final NewProductsNetworking _newProductsNetworking = NewProductsNetworking();

  late NewArrivalsModel newArrivalsModel;
  LocalStorage localStorage = LocalStorage();

  Future getHotProducts() async {
    try {
      final String? token = await localStorage.getToken();
      newArrivalsModel = await _newProductsNetworking.getNewProducts(token: token!);
    } catch (e) {
      // throw Exception(e);
      Future.error(e);

    }
    return newArrivalsModel;
  }
}
