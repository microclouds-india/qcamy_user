import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/photographerProfile.model.dart';
import 'package:qcamyapp/models/viewURL.model.dart';

class PhotographerProfileNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late PhotographerProfileModel photographerProfileModel;

  //get single photographer profile data
  Future<PhotographerProfileModel> getPhotgrapherProfile(
      {required dynamic id}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "profile_photographer"), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        photographerProfileModel = PhotographerProfileModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return photographerProfileModel;
  }

  late ViewUrlModel viewUrlModel;

  Future<ViewUrlModel> getPhotgrapherURLs({required String token}) async {
    try {
      final request = await client
          .post(Uri.parse(urlENDPOINT + "profile_photographer"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        viewUrlModel = ViewUrlModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return viewUrlModel;
  }
}
