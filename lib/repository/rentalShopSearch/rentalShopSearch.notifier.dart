import 'package:flutter/material.dart';
import 'package:qcamyapp/models/rentalShopSearch.model.dart';
import 'package:qcamyapp/repository/rentalShopSearch/rentalShopSearch.networking.dart';

class RentalShopSearchNotifier extends ChangeNotifier {
  final RentalShopSearchNetworking _rentalShopSearchNetworking = RentalShopSearchNetworking();

  late RentalShopSearchModel rentalShopSearchModel;

  Future searchData({required String title}) async {
    try {
      rentalShopSearchModel = await _rentalShopSearchNetworking.searchData(title: title);

      return rentalShopSearchModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
