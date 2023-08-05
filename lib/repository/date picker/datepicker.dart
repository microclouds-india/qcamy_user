import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }
}