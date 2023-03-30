import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:qcamyapp/models/repairCamera.model.dart';
import 'package:qcamyapp/repository/camera_repair/cameraRepair.networking.dart';

class CameraRepairNotifier extends ChangeNotifier {
  final CameraRepairNetworking _cameraRepairNetworking = CameraRepairNetworking();

  bool isLoading = false;

  late CameraRepairModel cameraRepairModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future submitCameraRepair({
    required String token,
    required String name,
    required String mobileNumber,
    required String address,
    required String equipmentName,
    required String description,
    required String warranty,
    required List<XFile> imageList,
  }) async {
    loading(true);

    try {
      cameraRepairModel = await _cameraRepairNetworking.cameraRepair(
        token: token,
        name: name,
        mobileNumber: mobileNumber,
        address: address,
        equipmentName: equipmentName,
        description: description,
        warranty: warranty,
        imageList: imageList,
      );

      loading(false);

      return cameraRepairModel;
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
