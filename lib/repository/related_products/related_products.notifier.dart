import 'package:flutter/material.dart';
import 'package:qcamyapp/models/related_products.model.dart';

import 'related_products.networking.dart';

class RelatedProductsNotifier extends ChangeNotifier {
  final RelatedProductsNetworking _relatedProductsNetworking =
      RelatedProductsNetworking();

  late RelatedProductsModel relatedProductsModel;

  // String categoryId = "1";
  // String categoryName = "";

  Future getRelatedProducts({required String categoryId}) async {
    try {
      relatedProductsModel = await _relatedProductsNetworking
          .getRelatedProducts(categoryId: categoryId);

      return relatedProductsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
