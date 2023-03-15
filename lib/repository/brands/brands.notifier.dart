  import 'package:flutter/material.dart';
  import 'package:qcamyapp/models/brands.model.dart';

  import 'brands.networking.dart';

  class BrandsNotifier extends ChangeNotifier {
    final BrandsNetworking _brandsNetworking = BrandsNetworking();

    late BrandsModel brandsModel;

    Future getBrands() async {
      try {
        brandsModel = await _brandsNetworking.getBrands();
      } catch (e) {
        // throw Exception(e);
      }
      return brandsModel;
    }
  }
