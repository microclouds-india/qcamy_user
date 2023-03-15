import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:qcamyapp/repository/rental_equipments/rentalEquipments.networking.dart';

import '../../models/rentaEquipments.model.dart';

class RentalEquipmentsNotifier extends ChangeNotifier {
  final RentalEquipmentsNetworking _rentalEquipmentsNetworking = RentalEquipmentsNetworking();

  bool isLoading = false;

  List<XFile>? imageFileList = [];

  late String rentalShopId;

  late RentalEquipmentModel rentalEquipmentModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future getRentalEquipments({
    required String id,
  }) async {
    try {
      rentalEquipmentModel =
          await _rentalEquipmentsNetworking.getRentalEquipments(id: id);
    } catch (e) {
      return Future.error(e.toString());
    }
    return rentalEquipmentModel;
  }
}
