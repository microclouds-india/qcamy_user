// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qcamyapp/config/colors.dart';

class SearchFieldWidget extends StatelessWidget {
  final String? hintText;
  final Function()? onTap;
  final Function(String value)? onChanged;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;

  const SearchFieldWidget(
      {Key? key,
      this.hintText,
      this.onTap,
      required this.readOnly,
      required this.autofocus,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: 1,
      style: TextStyle(color: Colors.black, fontSize: 16),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.search, size: 22, color: Colors.black),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: grey, fontSize: 14),
        contentPadding: EdgeInsets.only(left: 10, right: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
