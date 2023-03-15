import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/viewProduct.model.dart';
import 'package:qcamyapp/repository/productsDetails/product_details.networking.dart';

class ViewProductNotifier extends ChangeNotifier {
  final ProductDetailsNetworking _productDetailsNetworking =
      ProductDetailsNetworking();

  late ViewProductModel viewProductModel;
  LocalStorage localStorage = LocalStorage();

  String productId = "0";

  bool isDataLoaded = false;

  //get product details
  Future getProductDetails() async {
    try {
      final String? token = await localStorage.getToken();
      viewProductModel = await _productDetailsNetworking.getProductDetails(
          productId: productId, token: token!);
      isDataLoaded = true;
      notifyListeners();
      productId = "0";
      return viewProductModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  String selectedImage = "";
  changeSelectedImage(var image) {
    selectedImage = image;
    notifyListeners();
  }
}
