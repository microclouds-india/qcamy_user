import 'package:flutter/material.dart';
import 'package:qcamyapp/repository/rental_equipment_detail/rental_equi_details.networking.dart';

import '../../models/rentalEquipmentDetails.model.dart';

class RentalEquipmentDetailsNotifier extends ChangeNotifier {
  final RentalEquipmentDetailsNetworking _rentalEquipmentDetailsNetworking =
      RentalEquipmentDetailsNetworking();

  bool isLoading = false;

  late String rentalEquipmentId;

  late RentalEquipmentDetailsModel rentalEquipmentDetailsModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future getRentalEquipmentDetails({
    required String id,
  }) async {
    try {
      rentalEquipmentDetailsModel = await _rentalEquipmentDetailsNetworking
          .getRentalEquipmentDetails(id: id);
    } catch (e) {
      throw Exception(e);
    }
    return rentalEquipmentDetailsModel;
  }

  String selectedImage = "";
  changeSelectedImage(var image) {
    selectedImage = image;
    notifyListeners();
  }
}
