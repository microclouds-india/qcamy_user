import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/colors.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({
    Key? key,
    required this.onOkPressed,
    required this.message,
  }) : super(key: key);

  final Function() onOkPressed;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Success",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
              ),
              Text(
                message,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: MaterialButton(
                  elevation: 0,
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: onOkPressed,
                  child: Text(
                    "OK",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
