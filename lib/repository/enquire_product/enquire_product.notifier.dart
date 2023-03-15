import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/models/enquire_product.model.dart';

import 'package:qcamyapp/repository/enquire_product/enquire_product.networking.dart';

class EnquireProductNotifier extends ChangeNotifier {
  final EnquireProductNetworking _enquireProductNetworking = EnquireProductNetworking();

  bool isLoading = false;

  late EnquireProductModel enquireProductModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future submitEnquireProduct({
    required String token,
    required String product_id,
    required String name,
    required String mobileNumber,
    required String email,
    required String productName,
    required String productDescription,
    required String modelNumber,
    required List<XFile> imageList,
  }) async {
    loading(true);

    try {
      enquireProductModel = await _enquireProductNetworking.enquireProduct(
        token: token,
        product_id: product_id,
        name: name,
        mobileNumber: mobileNumber,
        email: email,
        productName: productName,
        productDescription: productDescription,
        modelNumber: modelNumber,
        imageList: imageList,
      );

      loading(false);

      return enquireProductModel;
    } on Exception catch (e) {
      //catch late initialization error
      // cameraRepairModel = await _cameraRepairNetworking.cameraRepair(
      //   token: token,
      //   name: name,
      //   mobileNumber: mobileNumber,
      //   address: address,
      //   equipmentName: equipmentName,
      //   description: description,
      //   imageList: imageList,
      // );

      loading(false);
      return Future.error(e);
      // return cameraRepairModel;
    } catch (e) {
      loading(false);
      return Future.error(e.toString());
    }
  }
}
