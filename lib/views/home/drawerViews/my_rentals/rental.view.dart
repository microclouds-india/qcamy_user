// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/my_rentals/my_rentals.notifier.dart';

class RentalsView extends StatelessWidget {
  const RentalsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRentalsData =
        Provider.of<MyRentalBookingsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My Rentals",
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
          future: myRentalsData.getMyRentalBookings(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (myRentalsData.myRentalBookingsModel.data.isEmpty) {
                return Center(
                  child: Text("No Rental Bookings"),
                );
              } else {
                return ListView.builder(
                    itemCount: myRentalsData.myRentalBookingsModel.data.length,
                    itemBuilder: (context, index) {
                      return OrderItem(
                        productName: myRentalsData
                            .myRentalBookingsModel.data[index].equipmentName,
                        image: myRentalsData
                            .myRentalBookingsModel.data[index].coverImg,
                        bookingDate: myRentalsData
                            .myRentalBookingsModel.data[index].bookingDate,
                        returnDate: myRentalsData
                            .myRentalBookingsModel.data[index].returnDate,
                        date: myRentalsData
                            .myRentalBookingsModel.data[index].date,
                        orderNumber: myRentalsData
                            .myRentalBookingsModel.data[index].orderId,
                        orderStatus: myRentalsData
                            .myRentalBookingsModel.data[index].orderStatus,
                        onTap: () {
                          myRentalsData.orderId = myRentalsData
                              .myRentalBookingsModel.data[index].orderId;
                          Navigator.of(context).pushNamed("/rentalDetailsView");
                        },
                      );
                    });
              }
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
    required this.productName,
    required this.bookingDate,
    required this.image,
    required this.returnDate,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String productName;
  final String bookingDate;
  final String returnDate;
  final String orderStatus;
  final String image;
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Image.network(
                          image.isNotEmpty ? image : noImage,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: 100,
                              child: Image.network(noImage),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                productName,
                                style: GoogleFonts.openSans(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "Booking date: $bookingDate",
                              style: GoogleFonts.quicksand(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(color: Colors.grey),
                    OrderElement(title: "Order#", value: orderNumber),
                    SizedBox(height: 5),
                    OrderElement(title: "Date", value: date),
                    SizedBox(height: 5),
                    OrderElement(title: "Return date", value: returnDate),
                    SizedBox(height: 5),
                    OrderElement(title: "Status", value: orderStatus),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios, size: 15),
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

class RentalShopsList extends StatelessWidget {
  final String shopName;
  final String? mobileNumber;
  final String? image;
  final String? location;
  final Function()? onTap;
  final String productName;
  final String bookedOnDate;
  final String orderNumber;
  final String date;
  final String orderStatus;
  const RentalShopsList({
    Key? key,
    required this.shopName,
    required this.mobileNumber,
    this.image,
    this.location,
    this.onTap,
    required this.productName,
    required this.bookedOnDate,
    required this.orderNumber,
    required this.date,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        // padding:
        //     const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: SizedBox(
                      width: 120,
                      height: 120,
                      child: CachedNetworkImage(
                        imageUrl: image ??
                            "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
                        placeholder: (context, url) {
                          return Image.network(
                              "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                        },
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) {
                          return Image.network(
                              "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                        },
                      )),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: GoogleFonts.quicksand(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Booked on - $bookedOnDate",
                      style: GoogleFonts.quicksand(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    OrderElement(value: "date", title: "date"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
