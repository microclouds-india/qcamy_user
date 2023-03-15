import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/photographerProfile.model.dart';
import 'package:qcamyapp/models/viewURL.model.dart';
import 'package:qcamyapp/repository/photographer_profile/profile.networking.dart';

class PhotographerProfileNotifier extends ChangeNotifier {
  final PhotographerProfileNetworking _photographerProfileNetworking =
      PhotographerProfileNetworking();

  // bool isLoading = false;

  late PhotographerProfileModel photographerProfileModel;
  Future getPhotographerData({required dynamic id}) async {
    // isLoading = true;
    // notifyListeners();
    try {
      photographerProfileModel =
          await _photographerProfileNetworking.getPhotgrapherProfile(id: id);

      // isLoading = false;
      // notifyListeners();
      return photographerProfileModel;
    } catch (e) {
      // isLoading = true;
      notifyListeners();
    }
  }

  late ViewUrlModel viewUrlModel;
  Future getPhotographerURLs() async {
    try {
      LocalStorage localStorage = LocalStorage();
      final token = await localStorage.getToken();
      viewUrlModel = await _photographerProfileNetworking.getPhotgrapherURLs(
          token: token!);

      return viewUrlModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
