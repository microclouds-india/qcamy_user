import 'package:flutter/material.dart';

import '../../views/language/languageselectScreen.dart';



class LanguageProvider with ChangeNotifier {
  Language? _selectedLanguage;

  Language? get selectedLanguage => _selectedLanguage;

  set selectedLanguage(Language? language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}