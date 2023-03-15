import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/models/exchange_product.model.dart';
import 'package:qcamyapp/repository/exchange_product/exchange_product.networking.dart';


class ExchangeProductNotifier extends ChangeNotifier {
  final ExchangeProductNetworking _exchangeProductNetworking = ExchangeProductNetworking();

  bool isLoading = false;

  late ExchangeProductModel exchangeProductModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future submitExchangeProduct({
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
      exchangeProductModel = await _exchangeProductNetworking.exchangeProduct(
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

      return exchangeProductModel;
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
