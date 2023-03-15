import 'package:flutter/material.dart';
import 'package:qcamyapp/models/todaysDeals.model.dart';
import 'package:qcamyapp/repository/todays_deals/todays_deals.networking.dart';

class TodaysDealsNotifier extends ChangeNotifier {
  final TodaysDealsNetworking _dealsNetworking = TodaysDealsNetworking();

  late TodaysDealsModel todaysDealsModel;

  Future getTodaysDeals() async {
    try {
      todaysDealsModel = await _dealsNetworking.getTodaysDeals();

      return todaysDealsModel;
    } catch (e) {
      return Future.error(e);
    }
  }
}
