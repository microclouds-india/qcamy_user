import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatelessWidget {
  final String imageLink;

  const ViewImage({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(imageLink),
    );
  }
}
