import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/my_repairs.model.dart';

import '../../models/repair_details.model.dart';
import 'my_repairs.networking.dart';

class MyRepairsNotifier extends ChangeNotifier {
  final MyRepairsNetworking _myRepairsNetworking = MyRepairsNetworking();

  late String repairBookingId;

  late MyRepairsModel myRepairsModel;
  Future getMyRepairs() async {
    LocalStorage localStorage = LocalStorage();
    final String? token = await localStorage.getToken();

    try {
      myRepairsModel = await _myRepairsNetworking.getMyRentals(token: token);
    } catch (e) {
      return Future.error(e);
    }
    return myRepairsModel;
  }

  late RepairDetailsModel repairDetailsModel;
  Future getRepairDetails() async {
    try {
      repairDetailsModel =
          await _myRepairsNetworking.getRepairDetails(id: repairBookingId);
    } catch (e) {
      return Future.error(e);
    }
    return repairDetailsModel;
  }
}
