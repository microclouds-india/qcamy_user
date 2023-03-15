// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/photographer_Bookings/photographer_bookings.notifier.dart';
import 'package:qcamyapp/views/home/photographerTabViews/photographerProfile.view.dart';

class PhotographerBookingsView extends StatelessWidget {
  const PhotographerBookingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photographerBookingsData =
        Provider.of<PhotographerBookingsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My Bookings",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: photographerBookingsData.getPhotographerBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (photographerBookingsData
                  .photographerBookingsModel.data.isEmpty) {
                return Center(
                  child: Text("No Bookings"),
                );
              }

              return ListView.builder(
                  itemCount: photographerBookingsData
                      .photographerBookingsModel.data.length,
                  itemBuilder: (context, index) {
                    return OrderItem1(
                      orderNumber: photographerBookingsData
                          .photographerBookingsModel.data[index].orderId,
                      photographerName: photographerBookingsData
                          .photographerBookingsModel
                          .data[index]
                          .photographerName,
                      image: photographerBookingsData.photographerBookingsModel
                          .data[index].photographerProfileImg,
                      category: photographerBookingsData
                          .photographerBookingsModel.data[index].category,
                      bookedOnDate: photographerBookingsData
                          .photographerBookingsModel.data[index].bookingDate,
                      date: photographerBookingsData
                          .photographerBookingsModel.data[index].date,
                      occassion: photographerBookingsData
                          .photographerBookingsModel.data[index].occassion,
                      orderStatus: photographerBookingsData
                          .photographerBookingsModel.data[index].status,
                      onTap: () {
                        // Navigator.of(context).pushNamed("/orderDetailsView");
                      },
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

//show orderd items list
class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.onTap,
    required this.photographerName,
    required this.category,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String photographerName;
  final String category;

  final String orderStatus;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ]),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OrderElement(title: "Order#", value: orderNumber),
                    SizedBox(height: 5),
                    OrderElement(
                        title: "Photographer Name", value: photographerName),
                    SizedBox(height: 5),
                    OrderElement(title: "Category", value: category),
                    SizedBox(height: 5),
                    OrderElement(title: "Date", value: date),
                    SizedBox(height: 5),
                    OrderElement(title: "Status", value: orderStatus),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          )),
    );
  }
}

class OrderItem1 extends StatelessWidget {
  const OrderItem1({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.onTap,
    required this.photographerName,
    required this.category,
    required this.bookedOnDate,
    required this.image,
    required this.occassion,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String photographerName;
  final String category;
  final String bookedOnDate;
  final String image;
  final String orderStatus;
  final String occassion;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ]),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade800,
                    backgroundImage:
                        NetworkImage(image.isNotEmpty ? image : noImagePic),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(photographerName,
                          style: GoogleFonts.quicksand(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                      Text("Booked on - $date",
                          style: GoogleFonts.quicksand(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OrderElement(title: "Order#", value: orderNumber),
                        SizedBox(height: 5),
                        OrderElement(title: "Date", value: bookedOnDate),
                        SizedBox(height: 5),
                        OrderElement(title: "Occassion", value: occassion),
                        SizedBox(height: 5),
                        // OrderElement(title: "Category", value: category),
                        // SizedBox(height: 5),
                        Divider(thickness: 2),
                        OrderElement(title: "Status", value: orderStatus),
                      ],
                    ),
                  ),
                  // Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ],
          )),
    );
  }
}

class OrderElement extends StatelessWidget {
  const OrderElement({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Text(" : "),
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              value,
              style: GoogleFonts.quicksand(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}


//  Text("Total Items: ₹$totalItems",
//                         style: GoogleFonts.openSans(
//                             fontSize: 16, fontWeight: FontWeight.w600)),
//                     Text("Total Amount: $totalAmount",
//                         style: GoogleFonts.openSans(
//                             fontSize: 16, fontWeight: FontWeight.w500)),
//                     Text("Payment Type: $paymentType",
//                         style: GoogleFonts.openSans(
//                             fontSize: 16, fontWeight: FontWeight.w600)),
//                     Text("Order Status: $orderStatus",
//                         style: GoogleFonts.openSans(
//                             fontSize: 16, fontWeight: FontWeight.w500)),