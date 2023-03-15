// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/cart/cart.notifier.dart';

class SingleItemPurchaseDetailsView extends StatelessWidget {
  const SingleItemPurchaseDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Purchase Details",
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
      body: Column(
        children: [
          CartItem(
              name: cartData.addToCartModel.productName,
              quantity: cartData.addToCartModel.qty,
              price: cartData.addToCartModel.price,
              totalPrice: cartData.addToCartModel.totalPrice,
              cutPrice: cartData.addToCartModel.cutPrice,
              offerPercentage: cartData.addToCartModel.offerPer,
              image: cartData.addToCartModel.image),
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Price Details",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text("${cartData.addToCartModel.qty} items"),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total price",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "₹${cartData.addToCartModel.cutPrice}",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "-₹${cartData.addToCartModel.discountPrice.toStringAsFixed(1)}",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey, thickness: 2, height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "₹${cartData.addToCartModel.totalPrice}",
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.all(0),
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subtotal",
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "₹${cartData.addToCartModel.totalPrice}",
                        style: GoogleFonts.openSans(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  child: Text(
                    "Place Order",
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/selectAddressView");
                  },
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.cutPrice,
    required this.offerPercentage,
    required this.image,
  }) : super(key: key);

  final String name;
  final String quantity;
  final String price;
  final String totalPrice;
  final String cutPrice;
  final String offerPercentage;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  //             width: 150,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      image,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          noImage,
                          height: 80,
                          width: 80,
                        );
                      },
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        name,
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          // offerPrice == ""
                          //     ? "Price: ₹$price"
                          //     : "Price: ₹$offerPrice",
                          "₹$price",
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        offerPercentage != ""
                            ? Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 2, top: 2),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  offerPercentage == ""
                                      ? ""
                                      : "$offerPercentage%",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    Text("Quantity: $quantity",
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹$totalPrice",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                offerPercentage == ""
                    ? SizedBox(height: 10)
                    : Text("₹$cutPrice",
                        style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough)),
                SizedBox(height: 15),
              ],
            ),
          ],
        ));
  }
}
