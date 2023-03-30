import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:qcamyapp/models/repairCamera.model.dart';

class CameraRepairNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/camera_repair";

  final client = http.Client();

  late CameraRepairModel cameraRepairModel;

  //function to create a repair camera request
  // Future<CameraRepairModel> cameraRepair({
  //   required String token,
  //   required String name,
  //   required String mobileNumber,
  //   required String address,
  //   required String equipmentName,
  //   required String description,
  // }) async {
  //   try {
  //     final request = await client.post(Uri.parse(urlENDPOINT), body: {
  //       "token": token,
  //       "name": name,
  //       "phone": mobileNumber,
  //       "address": address,
  //       "equipment_name": equipmentName,
  //       "descri": description,
  //     }).timeout(const Duration(seconds: 10));

  //     if (request.statusCode == 200) {
  //       final response = json.decode(request.body);
  //       cameraRepairModel = CameraRepairModel.fromJson(response);
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  //   return cameraRepairModel;
  // }
  Future<CameraRepairModel> cameraRepair({
    required String token,
    required String name,
    required String mobileNumber,
    required String address,
    required String equipmentName,
    required String description,
    required String warranty,
    required List<XFile>? imageList,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(urlENDPOINT));
      request.fields['token'] = token;
      request.fields['name'] = name;
      request.fields['phone'] = mobileNumber;
      request.fields['address'] = address;
      request.fields['equipment_name'] = equipmentName;
      request.fields['warranty'] = warranty;
      request.fields['descri'] = description;

      //add multiple image to the request
      for (var i = 0; i < imageList!.length; i++) {
        request.files.add(
          http.MultipartFile("image[]", imageList[i].readAsBytes().asStream(),
              await imageList[i].length(),
              filename: imageList[i].name),
        );
      }
      var requestResponse = await request.send();

      //to get response/body from the server/ api
      requestResponse.stream.transform(utf8.decoder).listen((value) {
        var jsonResponse = jsonDecode(value) as Map<String, dynamic>;
        // print(jsonResponse);
        // cameraRepairModel = CameraRepairModel.fromJson(jsonResponse);

        if (requestResponse.statusCode == 200) {
          cameraRepairModel = CameraRepairModel.fromJson(jsonResponse);
          // print(jsonResponse);
        }
      });
      return cameraRepairModel;
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }
}
