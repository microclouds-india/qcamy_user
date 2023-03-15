// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import '../../../../repository/my_rentals/my_rentals.notifier.dart';

class RentalDetailsView extends StatelessWidget {
  const RentalDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRentalsData =
        Provider.of<MyRentalBookingsNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Order Details",
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
            future: myRentalsData.getRentalBookingDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Order Number: ${myRentalsData.rentalBookingDetailsModel.id}",
                          style: GoogleFonts.openSans(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          "Item:",
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return OrderItems(
                              name: myRentalsData
                                  .rentalBookingDetailsModel.equipmentName,
                              qty: myRentalsData.rentalBookingDetailsModel.qty,
                              price:
                                  "${myRentalsData.rentalBookingDetailsModel.price}/${myRentalsData.rentalBookingDetailsModel.rentType}",
                              image: myRentalsData
                                  .rentalBookingDetailsModel.equipmentImage,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Quantity: ${myRentalsData.rentalBookingDetailsModel.qty}",
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Ordered From:",
                          style: GoogleFonts.openSans(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      RentalShopsList(
                        shopName:
                            myRentalsData.rentalBookingDetailsModel.shopName,
                        mobileNumber:
                            myRentalsData.rentalBookingDetailsModel.shopNumber,
                        location:
                            myRentalsData.rentalBookingDetailsModel.shopAddress,
                        image:
                            myRentalsData.rentalBookingDetailsModel.shopImage,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: OrderElement(
                          title: "Order date",
                          value:
                              "${myRentalsData.rentalBookingDetailsModel.bookingDate} - ${myRentalsData.rentalBookingDetailsModel.bookingTime}",
                          keySize: 16,
                          valueSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: OrderElement(
                          title: "Return date",
                          value:
                              "${myRentalsData.rentalBookingDetailsModel.bookingTodate} - ${myRentalsData.rentalBookingDetailsModel.bookingTotime}",
                          keySize: 16,
                          valueSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: OrderElement(
                          title: "Status",
                          value: myRentalsData
                              .rentalBookingDetailsModel.orderStatus,
                          keySize: 16,
                          valueSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }));
  }
}

class OrderElement extends StatelessWidget {
  const OrderElement({
    Key? key,
    required this.value,
    required this.title,
    required this.keySize,
    required this.valueSize,
  }) : super(key: key);

  final String title;
  final String value;
  final double keySize;
  final double valueSize;

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
                  fontSize: keySize, fontWeight: FontWeight.w600),
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
                  fontSize: valueSize, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
}

class OrderItems extends StatelessWidget {
  const OrderItems({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.qty,
  }) : super(key: key);

  final String name;
  final String price;
  final String qty;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(
            image,
            width: 100,
            height: 100,
            errorBuilder: ((context, error, stackTrace) {
              return Container(
                color: Colors.white,
                width: 80,
                height: 80,
              );
            }),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  name,
                  style: GoogleFonts.quicksand(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 5),
              Text(
                "₹$price",
                style: GoogleFonts.openSans(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RentalShopsList extends StatelessWidget {
  final String shopName;
  final String? mobileNumber;
  final String? image;
  final String? location;
  final Function()? onTap;
  const RentalShopsList({
    Key? key,
    required this.shopName,
    required this.mobileNumber,
    this.image,
    this.location,
    this.onTap,
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
        ),
        // padding:
        //     const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
              // child: Image.network(
              //   image ??
              //       "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
              //   height: 80,
              // ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          location ?? "",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        mobileNumber ?? "Contact number not available",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
