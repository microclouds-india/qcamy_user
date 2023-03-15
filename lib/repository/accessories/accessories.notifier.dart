import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/accessories.model.dart';
import 'package:qcamyapp/repository/accessories/accessories.networking.dart';

class AccessoriesNotifier extends ChangeNotifier {
  final AccessoriesNetworking _accessoriesNetworking = AccessoriesNetworking();

  late AccessoriesModel accessoriesModel;
  LocalStorage localStorage = LocalStorage();

  String categoryId = "1";
  String categoryName = "";
  String brandId = "1";

  Future getAccessories() async {
    try {
      final String? token = await localStorage.getToken();
      accessoriesModel = await _accessoriesNetworking.getAccessories(categoryId: categoryId, token: token!);

      notifyListeners();
      return accessoriesModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getBrandAccessories() async {
    try {
      accessoriesModel =
          await _accessoriesNetworking.getBrandsItems(brandId: brandId);

      return accessoriesModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getProducts() async {
    try {
      accessoriesModel = await _accessoriesNetworking.getProducts();

      return accessoriesModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
