import 'package:flutter/material.dart';

class BannerError extends StatelessWidget {
  const BannerError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 231, 231),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 230,
      child: const Center(
          child: Icon(
        Icons.error,
        color: Colors.red,
        size: 40,
      )),
    );
  }
}
