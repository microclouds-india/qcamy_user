import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/models/editUserProfileModel.dart';
import 'package:qcamyapp/models/upload_profile.model.dart';
import 'package:qcamyapp/models/userProfile.model.dart';

class UserProfileNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/user_profile";
  static const String urlENDPOINTprofile_edit_user = "https://cashbes.com/photography/apis/profile_edit_user";

  final client = http.Client();

  late UserProfileModel userProfileModel;
  late EditUserProfileModel editUserProfileModel;

  Future<UserProfileModel> getUserProfile({
    required String token,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        userProfileModel = UserProfileModel.fromJson(response);
        // print(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return userProfileModel;
  }

  Future<EditUserProfileModel> editUserProfile({
    required String token,
    required String name,
    required String phone,
    required String gender,
    required String email,
    required String dob,
  }) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINTprofile_edit_user), body: {
        "token": token,
        "name": name,
        "phone": phone,
        "gender":gender,
        "dob":dob,
        "email":email
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        editUserProfileModel = EditUserProfileModel.fromJson(response);
        // print(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return editUserProfileModel;
  }

  late UploadProfilePicModel uploadProfilePicModel;
  Future<UploadProfilePicModel> uploadProfilePic({
    required String token,
    required XFile image,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse("https://cashbes.com/photography/apis/upload_profilepic"));
      request.fields['token'] = token;
      request.files.add(
        await http.MultipartFile.fromPath("image", image.path),
      );

      var requestResponse = await request.send();

      //to get response/body from the server/ api
      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;
        // print(jsonResponse);
        if (requestResponse.statusCode == 200) {
          uploadProfilePicModel = UploadProfilePicModel.fromJson(jsonResponse);
        }
      });
      return uploadProfilePicModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
