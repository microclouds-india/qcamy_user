import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderModel extends ChangeNotifier {
  List<File> imagespicked = [];

  List<File> get images => imagespicked;

  Future<void> pickImagesFromCamera(ImageSource imageSource) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        imagespicked.add(File(image.path));
        notifyListeners();
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }

  // Corrected method name
  List<File> getImages() {
    return imagespicked;
  }
}
