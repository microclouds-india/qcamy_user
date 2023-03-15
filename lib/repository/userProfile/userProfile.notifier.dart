import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/editUserProfileModel.dart';
import 'package:qcamyapp/models/upload_profile.model.dart';
import 'package:qcamyapp/models/userProfile.model.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.networking.dart';

class UserProfileNotifier extends ChangeNotifier {
  final UserProfileNetworking _userProfileNetworking = UserProfileNetworking();
  LocalStorage localStorage = LocalStorage();

  late UserProfileModel userProfileModel;
  late EditUserProfileModel editUserProfileModel;
  bool isLoading = false;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future getUserProfile() async {
    final String? token = await localStorage.getToken();

    try {
      userProfileModel =
      await _userProfileNetworking.getUserProfile(token: token!);
    } catch (e) {
      return Future.error(e.toString());
    }
    return userProfileModel;
  }

  Future editUserProfile({
    required String name,
    required String phone,
  }) async {
    loading(true);
    final String? token = await localStorage.getToken();

    try {
      editUserProfileModel = await _userProfileNetworking.editUserProfile(token: token!, name: name, phone: phone);
    } catch (e) {
      return Future.error(e.toString());
    }
    loading(false);
    return editUserProfileModel;
  }

  late UploadProfilePicModel uploadProfilePicModel;
  Future uploadProfilePic({required XFile profileImg}) async {
    final String? token = await localStorage.getToken();
    try {
      uploadProfilePicModel = await _userProfileNetworking.uploadProfilePic(
          token: token!, image: profileImg);
    } catch (e) {
      return Future.error(e);
    }
  }

}
