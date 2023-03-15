// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/cart/cart.notifier.dart';
import 'package:qcamyapp/repository/productsDetails/product_details.notifier.dart';

import '../../../../repository/buy_now/buy_now.notifier.dart';
import '../../../../repository/coupon/coupon.notifier.dart';

class CartView extends StatelessWidget {
  CartView({Key? key}) : super(key: key);

  final couponTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context, listen: true);
    final productData =
        Provider.of<ViewProductNotifier>(context, listen: false);
    final orderNowData = Provider.of<OrderNotifier>(context, listen: false);
    final coupenData = Provider.of<CouponNotifier>(context, listen: true);

    return WillPopScope(
      onWillPop: () {
        coupenData.isCouponAdded = false;
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        body: FutureBuilder(
          future: cartData.getCartItems(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong!"));
            }
            if (snapshot.hasData) {
              if (cartData.viewCartModel.status == "200") {
                //have items in cart

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    elevation: 0,
                    title: Text(
                      "Cart",
                      style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    centerTitle: true,
                    leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        coupenData.isCouponAdded = false;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: ListView(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartData.viewCartModel.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                productData.productId = cartData
                                    .viewCartModel.data[index].productId;

                                Navigator.of(context)
                                    .pushNamed("/offerProductDetailsView");
                              },
                              child: CartItem(
                                name: cartData
                                    .viewCartModel.data[index].productName,
                                quantity:
                                    cartData.viewCartModel.data[index].qty,
                                price: cartData.viewCartModel.data[index].price,
                                totalPrice: cartData
                                    .viewCartModel.data[index].totalPrice,
                                cutPrice:
                                    cartData.viewCartModel.data[index].cutPrice,
                                offerPercentage:
                                    cartData.viewCartModel.data[index].offerPer,
                                image: cartData.viewCartModel.data[index].image,
                                onRemoveItem: () async {
                                  var itemId =
                                      cartData.viewCartModel.data[index].id;
                                  await cartData.removeProductFromCart(
                                      productId: itemId);
                                  if (cartData.removeFromCartModel.status ==
                                      "200") {
                                    Navigator.pop(context);
                                    await cartData.getCartCount();
                                  }
                                },
                                increaseQty: () async {
                                  int qty = int.parse(cartData
                                          .viewCartModel.data[index].qty) +
                                      1;
                                  await cartData.updateCart(
                                      cartId:
                                          cartData.viewCartModel.data[index].id,
                                      qty: qty.toString(),
                                      price: cartData
                                          .viewCartModel.data[index].price,
                                      cutPrice: cartData
                                          .viewCartModel.data[index].cutPrice);
                                },
                                decreaseQty: () async {
                                  if (int.parse(cartData
                                          .viewCartModel.data[index].qty) >
                                      1) {
                                    int qty = int.parse(cartData
                                            .viewCartModel.data[index].qty) -
                                        1;
                                    await cartData.updateCart(
                                        cartId: cartData
                                            .viewCartModel.data[index].id,
                                        qty: qty.toString(),
                                        price: cartData
                                            .viewCartModel.data[index].price,
                                        cutPrice: cartData.viewCartModel
                                            .data[index].cutPrice);
                                  }
                                },
                              ),
                            );
                          }),
                      SizedBox(height: 50),
                      Container(
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
                                  Text(
                                      "${cartData.viewCartModel.totalItems} items"),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total price",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "₹${cartData.viewCartModel.totalProductPrice}",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "-₹${cartData.viewCartModel.totalDiscount}",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: Colors.grey, thickness: 2, height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "₹${cartData.viewCartModel.subTotal}",
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
                      ),
                      FutureBuilder(
                          future: coupenData.getCoupon(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (coupenData
                                  .getCouponModel.couponCode.isEmpty) {
                                return SizedBox();
                              }
                              couponTextController.text =
                                  coupenData.getCouponModel.couponCode;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Apply Coupon",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: TextField(
                                              controller: couponTextController,
                                            ),
                                          ),
                                        ),
                                        MaterialButton(
                                          onPressed: () async {
                                            if (couponTextController
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                msg: "Please enter coupon code",
                                                toastLength: Toast.LENGTH_SHORT,
                                              );
                                            } else {
                                              await coupenData.applyCoupon(
                                                  couponCode:
                                                      couponTextController
                                                          .text);
                                              if (coupenData
                                                      .couponModel.status ==
                                                  "200") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Coupon Applied Successfully",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else if (coupenData
                                                      .couponModel.status ==
                                                  "400") {
                                                coupenData.isCouponAdded =
                                                    false;
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Coupon Code is Invalid",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            }
                                          },
                                          color: primaryColor,
                                          elevation: 0,
                                          child: Text("Apply"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            return SizedBox();
                          })
                    ],
                  ),
                  bottomNavigationBar: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 5, left: 10, right: 10, top: 10),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    coupenData.isCouponAdded
                                        ? "₹${coupenData.couponModel.subTotal}"
                                        : "₹${cartData.viewCartModel.subTotal}",
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
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
                                orderNowData.isBuyingSingleItem = false;
                                Navigator.of(context)
                                    .pushNamed("/selectAddressView");
                              },
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                //no items i cart
                return Scaffold(
                    appBar: AppBar(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      title: Text(
                        "Cart",
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
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
                    body: Center(child: Text("Empty Cart")));
              }
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
        ),
      ),
    );
  }
}

//show cart items list
class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.cutPrice,
    required this.offerPercentage,
    required this.onRemoveItem,
    required this.image,
    required this.increaseQty,
    required this.decreaseQty,
  }) : super(key: key);

  final String name;
  final String quantity;
  final String price;
  final String totalPrice;
  final String cutPrice;
  final String offerPercentage;
  final String image;
  final Function() onRemoveItem;
  final Function() increaseQty;
  final Function() decreaseQty;

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    image,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        noImage,
                        height: 100,
                        width: 100,
                      );
                    },
                    width: 90,
                    height: 90,
                    fit: BoxFit.contain,
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
                      width: 160,
                      child: Text(
                        name,
                        style: GoogleFonts.openSans(
                            fontSize: 14, fontWeight: FontWeight.w500),
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
                    // Text("Quantity: $quantity",
                    //     style: GoogleFonts.openSans(
                    //         fontSize: 14, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: decreaseQty,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            quantity,
                            style: GoogleFonts.openSans(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: increaseQty,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text('Remove item',
                                  style: TextStyle(color: Colors.black)),
                              content: Text(
                                  'Do you want to remove this item from cart?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: onRemoveItem,
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          }));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.grey,
                          size: 20,
                        ),
                        Text("Remove"),
                      ],
                    )),
              ],
            ),
          ],
        ));
  }
}
