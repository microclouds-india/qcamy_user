import 'package:flutter/material.dart';
import 'package:qcamyapp/models/bookPhotographer.model.dart';

import 'package:qcamyapp/repository/book_photographer/book_photographer.networking.dart';

class BookPhotographerNotifier extends ChangeNotifier {
  final BookPhotographerNetworking _bookPhotographerNetworking =
      BookPhotographerNetworking();

  bool isLoading = false;

  late String photographerId;

  late BookPhotographerModel bookPhotographerModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  bookPhotographer({
    required String token,
    required String photographerId,
    required String bookingDate,
    required String bookingPlace,
    required String name,
    required String phone,
    required String alternateNumber,
    required String bookingPurpose,
  }) async {
    loading(true);

    try {
      bookPhotographerModel =
          await _bookPhotographerNetworking.bookPhotographer(
              token: token,
              photographerId: photographerId,
              bookingDate: bookingDate,
              bookingPlace: bookingPlace,
              name: name,
              alternateNumber: alternateNumber,
              bookingPurpose: bookingPurpose,
              phone: phone);
      loading(false);
    } catch (e) {
      loading(false);
    }
  }
}
