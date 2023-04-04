import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/addReview.model.dart';
import 'package:qcamyapp/models/allReview.model.dart';
import 'package:qcamyapp/models/help.model.dart';
import 'package:qcamyapp/repository/addReview/addReview.networking.dart';
import 'package:qcamyapp/repository/help/help.networking.dart';


class AddReviewNotifier extends ChangeNotifier {
  final AddReviewNetworking _addReviewNetworking = AddReviewNetworking();

  late AddReviewModel addReviewModel;
  late AllReviewsModel allReviewsModel;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;
  String ratingValue = "5.0";

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future addReviewData({required String rating, required String comment}) async {
    loading(true);
    try {
      final String? token = await localStorage.getToken();
      addReviewModel = await _addReviewNetworking.addReviewData(token: token!, rating: rating, comment: comment);
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return addReviewModel;
  }

  Future allReviews() async {
    loading(true);
    try {
      allReviewsModel = await _addReviewNetworking.allReviews();
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return allReviewsModel;
  }
}
