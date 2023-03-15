import 'package:flutter/material.dart';
import 'package:qcamyapp/config/colors.dart';

class BookingButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? color;
  final Color? textColor;
  const BookingButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(10),
      minWidth: double.infinity,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: onTap,
      color: color ?? primaryColor,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, letterSpacing: 2, color: Colors.white),
      ),
    );
  }
}
