import 'package:flutter/material.dart';
import 'package:qcamyapp/models/search.model.dart';
import 'package:qcamyapp/repository/search/search.networking.dart';

class ShowAllNotifier extends ChangeNotifier {
  final SearchNetworking _searchNetworking = SearchNetworking();

  late SearchModel dataModel;

  Future showAll({String? keyword, required String category}) async {
    try {
      dataModel = await _searchNetworking.searchData(
          keyword: keyword, category: category);
      return dataModel;
    } catch (e) {
      return e;
    }
  }
}
