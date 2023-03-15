import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/my_repairs.model.dart';
import 'package:qcamyapp/models/repair_details.model.dart';

class MyRepairsNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/";

  final client = http.Client();

  late MyRepairsModel myRepairsModel;

  Future<MyRepairsModel> getMyRentals({required dynamic token}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "my_repairs"), body: {
        "token": token,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        myRepairsModel = MyRepairsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return myRepairsModel;
  }

  late RepairDetailsModel repairDetailsModel;
  Future<RepairDetailsModel> getRepairDetails({required String id}) async {
    try {
      final request =
          await client.post(Uri.parse(urlENDPOINT + "repair_details"), body: {
        "id": id,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        repairDetailsModel = RepairDetailsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return repairDetailsModel;
  }
}
