import 'package:flutter/material.dart';
import 'package:qcamyapp/models/categories.model.dart';
import 'package:qcamyapp/repository/categories/categories.networking.dart';

class CategoryNotifier extends ChangeNotifier {
  final CategoryNetworking _categoryNetworking = CategoryNetworking();

  late CategoryModel categoryModel;

  Future getCategories() async {
    try {
      categoryModel = await _categoryNetworking.getCategories();
    } catch (e) {
      // throw Exception(e);
    }
    return categoryModel;
  }
}
