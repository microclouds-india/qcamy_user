import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/enquire_product_details.model.dart';
import 'package:qcamyapp/repository/enquire_product_details/enquire_product_details_networking.dart';

class EnquireProductDetailsNotifier extends ChangeNotifier {
  final EnquireProductDetailsNetworking enquireProductDetailsNetworking = EnquireProductDetailsNetworking();

  EnquireProductDetailsModel? enquireProductDetailsModel;

  bool isLoading = false;

  Future getEnquireProductDetails() async {
    isLoading = true;
    try {
      enquireProductDetailsModel = await enquireProductDetailsNetworking.getEnquireProductDetails();
    } catch (e) {
      return Future.error(e);
    }
    isLoading = false;
    notifyListeners();
    return enquireProductDetailsModel;
  }
}
