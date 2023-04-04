import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qcamyapp/models/addReview.model.dart';
import 'package:qcamyapp/models/allReview.model.dart';


class AddReviewNetworking {
  static const String urlENDPOINT = "https://cashbes.com/photography/apis/send_review";
  static const String urlENDPOINT2 = "https://cashbes.com/photography/apis/reviews_all";

  final client = http.Client();

  late AddReviewModel addReviewModel;
  late AllReviewsModel allReviewsModel;

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

  Future<AllReviewsModel> allReviews() async {
    try {
      final request = await client.post(Uri.parse(urlENDPOINT2));

      if (request.statusCode == 200) {
        final response = json.decode(request.body);
        allReviewsModel = AllReviewsModel.fromJson(response);
      }
    } catch (e) {
      return Future.error(e);
    }
    return allReviewsModel;
  }
}
