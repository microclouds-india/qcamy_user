import 'package:flutter/material.dart';
import 'package:qcamyapp/models/address/addAddress.model.dart';
import 'package:qcamyapp/models/address/viewAddress.model.dart';
import 'package:qcamyapp/repository/address/address.networking.dart';

import '../../core/token_storage/storage.dart';

class AddressNotifier extends ChangeNotifier {
  final AddressNetworking _addressNetworking = AddressNetworking();
  LocalStorage localStorage = LocalStorage();

  late ViewAddressModel viewAddressModel;

  Future getAddress() async {
    final String? token = await localStorage.getToken();

    try {
      viewAddressModel = await _addressNetworking.getAddress(
        token: token!,
      );
    } catch (e) {
      return Future.error(e);
    }

    return viewAddressModel;
  }

  late AddAddressModel addAddressModel;
  bool isLoading = false;
  loading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future addAddress(
      {required String name,
      required String address,
      required String city,
      required String landmark,
      required String phone1,
      required String phone2,
      required String pincode}) async {
    loading(true);
    final String? token = await localStorage.getToken();
    try {
      addAddressModel = await _addressNetworking.addAddress(
        token: token!,
        name: name,
        address: address,
        city: city,
        landmark: landmark,
        phone1: phone1,
        phone2: phone2,
        pincode: pincode,
      );
    } catch (e) {
      loading(false);
      notifyListeners();
      return Future.error(e);
    }
    loading(false);
    return addAddressModel;
  }

  bool isAddressSelected = false;
  late int selectedIndex = 0;
  String fullAddress = "";
  void toggleSelected(int index) {
    selectedIndex = index;
    isAddressSelected = true;
    String name = viewAddressModel.data[index].name;
    String address = viewAddressModel.data[index].address;
    String city = viewAddressModel.data[index].city;
    String landmark = viewAddressModel.data[index].landmark;
    String phone1 = viewAddressModel.data[index].phone;
    String phone2 = viewAddressModel.data[index].alternateNumber;
    String pincode = viewAddressModel.data[index].pincode;
    fullAddress =
        "$name\n$address, $city, $landmark, $pincode\n$phone1\n$phone2";

    notifyListeners(); // To rebuild the Widget
  }
}
