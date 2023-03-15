import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/models/enquire_product.model.dart';

import 'package:qcamyapp/models/repairCamera.model.dart';

class EnquireProductNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/enquire_product_not_listed";

  final client = http.Client();

  late EnquireProductModel enquireProductModel;

  Future<EnquireProductModel> enquireProduct({
    required String token,
    required String product_id,
    required String name,
    required String mobileNumber,
    required String email,
    required String productName,
    required String productDescription,
    required String modelNumber,
    required List<XFile>? imageList,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(urlENDPOINT));
      request.fields['token'] = token;
      request.fields['product_id'] = product_id;
      request.fields['name'] = name;
      request.fields['phone'] = mobileNumber;
      request.fields['email'] = email;
      request.fields['product_name'] = productName;
      request.fields['product_description'] = productDescription;
      request.fields['model_number'] = modelNumber;

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
          enquireProductModel = EnquireProductModel.fromJson(jsonResponse);
          // print(jsonResponse);
        }
      });
      return enquireProductModel;
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
  }
}
