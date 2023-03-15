import 'package:flutter/material.dart';
import 'package:qcamyapp/models/together_products.model.dart';
import 'package:qcamyapp/repository/together_product/together_products.networking.dart';


class TogetherProductsNotifier extends ChangeNotifier {
  final TogetherProductsNetworking _togetherProductsNetworking = TogetherProductsNetworking();

  late TogetherProductsModel togetherProductsModel;

  Future getTogetherProducts({required String product_id, required String together}) async {
    try {
      togetherProductsModel = await _togetherProductsNetworking.getTogetherProducts(product_id: product_id);
    } catch (e) {
      // throw Exception(e);
    }
    return togetherProductsModel;
  }
}
