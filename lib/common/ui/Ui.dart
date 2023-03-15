import 'package:flutter/material.dart';

class Ui {

  static BoxDecoration getBoxDecoration({required Color color}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.grey),
    );
  }

  static BoxDecoration getBoxDecorationProfile({required Color color}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
    );
  }


  static BoxDecoration getBoxDecorationProduct({required Color color}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
    );
  }

  static BoxDecoration getSquareBoxDecoration({required Color color}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(0)),
      boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
      ],
      border: Border.all(color: Colors.grey),
    );
  }

}