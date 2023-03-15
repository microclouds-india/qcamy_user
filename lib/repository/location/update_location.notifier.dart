import 'package:flutter/material.dart';

class UpdateLocation extends ChangeNotifier {
  //just rebuild the location widget part
  updateLocation() {
    notifyListeners();
  }

  // Future getLocation(context) async {
  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(10.9513045, 75.9589525);
  //     final place = placemarks[0].locality;
  //     final state = placemarks[0].administrativeArea;
  //     final district = placemarks[0].subAdministrativeArea;
  //     print(district);
  //   } on PlatformException {
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}
