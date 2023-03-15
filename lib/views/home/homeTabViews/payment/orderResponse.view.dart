// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';

import '../../../main.view.dart';

class OrderResponseView extends StatelessWidget {
  const OrderResponseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        HomeView.pageIndexNotifier.value = 0;
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/mainHomeView", (route) => false);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Order Status",
            style: GoogleFonts.openSans(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 100),
                  SizedBox(height: 10),
                  Text(
                    "Order Placed",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  MaterialButton(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed("/ordersView");
                    },
                    elevation: 0,
                    child: Text(
                      "My Orders",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: BookingButton(
              text: "Go to Home",
              onTap: () {
                HomeView.pageIndexNotifier.value = 0;
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/mainHomeView", (route) => false);
              }),
        ),
      ),
    );
  }
}
