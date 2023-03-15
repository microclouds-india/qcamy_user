import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/trackingStatus.model.dart';

class TrackingStatusNetworking {
  static const String urlENDPOINT =
      "https://cashbes.com/photography/apis/order_status";

  final client = http.Client();

  late TrackingStatusModel trackingStatusModel;

  Future<TrackingStatusModel> getTrackingStatus({required String order_id}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT),
          body: {"order_id": order_id}).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        trackingStatusModel = TrackingStatusModel.fromJson(response);
      }
    } catch (e) {
      throw Exception(e);
    }
    return trackingStatusModel;
  }
}
