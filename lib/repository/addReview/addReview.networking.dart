import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/addReview.model.dart';


class AddReviewNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/send_review";

  final client = http.Client();

  late AddReviewModel addReviewModel;

  Future<AddReviewModel> addReviewData({required String token, required String rating, required String comment}) async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT), body: {
        "token": token,
        "rating": rating,
        "comment": comment,
      });

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        addReviewModel = AddReviewModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return addReviewModel;
  }
}
