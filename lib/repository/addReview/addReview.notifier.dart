import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/addReview.model.dart';
import 'package:qcamyapp/models/allReview.model.dart';
import 'package:qcamyapp/models/help.model.dart';
import 'package:qcamyapp/repository/addReview/addReview.networking.dart';
import 'package:qcamyapp/repository/help/help.networking.dart';


class AddReviewNotifier extends ChangeNotifier {
  final AddReviewNetworking addReviewNetworking = AddReviewNetworking();


  late AddReviewModel addReviewModel;
  late AllReviewsModel allReviewsModel;
  LocalStorage localStorage = LocalStorage();
  bool isLoading = false;
    bool get isFoundM=> isLoading;

  String ratingValue = "5.0";

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future addReviewData({required String rating, required String comment,required List<File> images,required String id}) async {
    loading(true);
    try {
      final String? token = await localStorage.getToken();
      addReviewModel = await addReviewNetworking.addReviewData(token: token!, rating: rating, comment: comment,images: images,id: id);
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return addReviewModel;
  }

  Future allReviews(String id) async {
    loading(true);
    try {
      allReviewsModel = await addReviewNetworking.allReviews(id: id);
      loading(false);
    } catch (e) {
      loading(false);
      // throw Exception(e);

    }
    loading(false);
    return allReviewsModel;
  }
}
