import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/models/rentalBookingResponse.model.dart';

import 'package:qcamyapp/repository/rental_booking/rental_booking.networking.dart';

class RentalBookingNotifier extends ChangeNotifier {
  final BookRentalsNetworking _bookRentalsNetworking = BookRentalsNetworking();

  bool isLoading = false;

  String qty = "1";

  late RentalProductBookingResponseModel rentalProductBookingResponseModel;

  loading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  bookRentalEquipment({
    required String token,
    required String rentalShopId,
    required String bookingDate,
    required String phone,
    required String address,
    required String equipmentId,
    required String qty,
    required String bookingTime,
    required String bookingToDate,
    required String bookingToTime,
    required List<XFile> imageList,
  }) async {
    loading(true);

    try {
      rentalProductBookingResponseModel = await _bookRentalsNetworking.bookRentalEquipment(
        token: token,
        bookingDate: bookingDate,
        phone: phone,
        address: address,
        equipmentId: equipmentId,
        qty: qty,
        rentalShopId: rentalShopId,
        bookingTime: bookingTime,
        bookingToDate: bookingToDate,
        bookingToTime: bookingToTime,
        imageList: imageList,
      );
      loading(false);
      return rentalProductBookingResponseModel;
    } catch (e) {
      loading(false);
    }
  }
}
