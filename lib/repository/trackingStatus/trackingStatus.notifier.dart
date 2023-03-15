import 'package:flutter/material.dart';
import 'package:qcamyapp/models/trackingStatus.model.dart';
import 'package:qcamyapp/repository/trackingStatus/trackingStatus.networking.dart';


class TrackingStatusNotifier extends ChangeNotifier {
  final TrackingStatusNetworking _trackingStatusNetworking = TrackingStatusNetworking();

  late TrackingStatusModel trackingStatusModel;

  Future getTrackingStatus({required String order_id}) async {
    try {
      trackingStatusModel = await _trackingStatusNetworking.getTrackingStatus(order_id: order_id);
    } catch (e) {
      // throw Exception(e);
    }
    return trackingStatusModel;
  }
}
