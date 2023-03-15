import 'package:flutter/material.dart';
import 'package:qcamyapp/models/search.model.dart';
import 'package:qcamyapp/repository/search/search.networking.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchNetworking _searchNetworking = SearchNetworking();

  // bool isLoading = false;

  bool dataLoaded = false;

  late SearchModel searchModel;

  searchData({String? keyword, required String category}) async {
    // isLoading = true;
    // notifyListeners();
    try {
      searchModel = await _searchNetworking.searchData(
          keyword: keyword, category: category);

      if (searchModel.status == "200") {
        dataLoaded = true;
        notifyListeners();
      } else {
        dataLoaded = false;
        notifyListeners();
      }

      // dataLoaded = true;
      // // isLoading = false;
      // notifyListeners();
    } catch (e) {
      dataLoaded = false;
      // isLoading = true;
      notifyListeners();
    }
  }

  clearSearch() {
    // isLoading = false;
    dataLoaded = false;
    searchModel.data.clear();

    notifyListeners();
  }
}
