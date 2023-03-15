// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/address/address.notifier.dart';
import 'package:qcamyapp/repository/buy_now/buy_now.notifier.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../repository/cart/cart.notifier.dart';
import '../../../../repository/coupon/coupon.notifier.dart';
import '../../../../repository/userProfile/userProfile.notifier.dart';

class PaymentOptionsView extends StatefulWidget {
  const PaymentOptionsView({Key? key}) : super(key: key);

  @override
  State<PaymentOptionsView> createState() => _PaymentOptionsViewState();
}

class _PaymentOptionsViewState extends State<PaymentOptionsView> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    // print("Payment Success");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Payment Success"),
      ),
    );
    try {
      final cartData = Provider.of<CartNotifier>(context, listen: false);
      final orderNowData = Provider.of<OrderNotifier>(context, listen: true);
      final addressData = Provider.of<AddressNotifier>(context, listen: false);
      final coupenData = Provider.of<CouponNotifier>(context, listen: false);

      if (orderNowData.isBuyingSingleItem) {
        await orderNowData.buySingleItem(
          subTotal: cartData.addToCartModel.totalPrice,
          orderStatus: "ordered",
          totalDiscount: cartData.addToCartModel.cutPrice,
          totalProductPrice: cartData.addToCartModel.price,
          address: addressData.fullAddress,
          productId: cartData.addToCartModel.cartId.toString(),
        );
      } else {
        await orderNowData.buyAllCart(
            subTotal: coupenData.isCouponAdded
                ? coupenData.couponModel.subTotal.toString()
                : cartData.viewCartModel.subTotal,
            orderStatus: "ordered",
            totalDiscount: cartData.viewCartModel.totalDiscount.toString(),
            totalProductPrice: cartData.viewCartModel.totalProductPrice,
            address: addressData.fullAddress,
            coupenCode: coupenData.isCouponAdded
                ? coupenData.couponModel.data[0].couponCode
                : "");
      }

      if (orderNowData.orderSuccessModel.status == "200") {
        Navigator.of(context).pushNamed("/orderResponseView");
      }
    } catch (_) {}
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    // print("payment error");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text("Payment Failed"),
      ),
    );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    // ignore: avoid_print
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartNotifier>(context, listen: false);
    final orderNowData = Provider.of<OrderNotifier>(context, listen: false);
    final addressData = Provider.of<AddressNotifier>(context, listen: false);
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    final coupenData = Provider.of<CouponNotifier>(context, listen: false);
    final ValueNotifier<int> _paymentTypeNotifier = ValueNotifier<int>(0);

    void openCheckout({var amount}) {
      var options = {
        'key': 'rzp_test_tOuoihHsvURpVn',
        'amount': amount,
        'name': 'Qcamy',
        'description': 'Payment',
        'prefill': {
          'contact': userProfileData.userProfileModel.data[0].phone,
          'email': userProfileData.userProfileModel.data[0].email
        },
        'external': {
          'wallets': ['paytm']
        }
      };
      try {
        razorpay.open(options);
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }

    return WillPopScope(
      onWillPop: () {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title:
                    Text('Cancel order', style: TextStyle(color: Colors.black)),
                content: Text('Do you want to go back?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () async {
                      //close dialog box
                      Navigator.of(context).pop(true);
                      //exit payment screen
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/mainHomeView", (route) => false);
                    },
                    child: Text('Yes'),
                  ),
                ],
              );
            }));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "Payments",
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
              showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: Text('Cancel order',
                          style: TextStyle(color: Colors.black)),
                      content: Text('Do you want to go back?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            //close dialog box
                            Navigator.of(context).pop(true);
                            //exit payment screen
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                "/mainHomeView", (route) => false);
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    );
                  }));
            },
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: _paymentTypeNotifier,
            builder: (context, data, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 5),
                    child: Text(
                      "Payment options",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                  PaymentOptions(
                    title: "Razorpay",
                    subTitle: "UPI, Debit Card, Net Banking etc",
                    icon: Icons.payment,
                    value: _paymentTypeNotifier.value == 1 ? true : false,
                    onTap: () {
                      _paymentTypeNotifier.value = 1;
                    },
                    onChanged: (value) {
                      _paymentTypeNotifier.value = 1;
                    },
                  ),
                  PaymentOptions(
                    title: "Cash On Delivery",
                    subTitle: "Pay at your door step",
                    icon: Icons.attach_money,
                    value: _paymentTypeNotifier.value == 2 ? true : false,
                    onTap: () {
                      _paymentTypeNotifier.value = 2;
                    },
                    onChanged: (value) {
                      _paymentTypeNotifier.value = 2;
                    },
                  ),
                ],
              );
            }),
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
                          "Amount Payable",
                          style: GoogleFonts.openSans(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        coupenData.isCouponAdded
                            ? Text(
                                "₹${coupenData.couponModel.subTotal}",
                                style: GoogleFonts.openSans(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              )
                            : Text(
                                orderNowData.isBuyingSingleItem
                                    ? "₹${cartData.addToCartModel.totalPrice}"
                                    : "₹${cartData.viewCartModel.subTotal}",
                                style: GoogleFonts.openSans(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<OrderNotifier>(builder: (context, data, _) {
                    return data.loading
                        ? Center(
                            heightFactor: 1,
                            widthFactor: 1,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          )
                        : MaterialButton(
                            child: Text(
                              "Proceed",
                              style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              if (_paymentTypeNotifier.value == 1) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text("online payament")));
                                if (orderNowData.isBuyingSingleItem) {
                                  // openCheckout(
                                  //     amount: num.parse(cartData
                                  //             .addToCartModel.totalPrice) *
                                  //         100);
                                  openCheckout(amount: num.parse("500") * 100);
                                } else {
                                  // openCheckout(
                                  //     amount: num.parse(
                                  //             cartData.viewCartModel.subTotal) *
                                  //         100);
                                  openCheckout(amount: num.parse("500") * 100);
                                }
                              } else if (_paymentTypeNotifier.value == 2) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        title: Text("Confirm Order"),
                                        content: Text(
                                            "Are you sure you want to place order?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () async {
                                                if (orderNowData
                                                    .isBuyingSingleItem) {
                                                  await orderNowData
                                                      .buySingleItem(
                                                    subTotal: cartData
                                                        .addToCartModel
                                                        .totalPrice,
                                                    orderStatus: "ordered",
                                                    totalDiscount: cartData
                                                        .addToCartModel
                                                        .cutPrice,
                                                    totalProductPrice: cartData
                                                        .addToCartModel.price,
                                                    address:
                                                        addressData.fullAddress,
                                                    productId: cartData
                                                        .addToCartModel.cartId
                                                        .toString(),
                                                  );
                                                } else {
                                                  await orderNowData.buyAllCart(
                                                      subTotal:
                                                          coupenData.isCouponAdded
                                                              ? coupenData
                                                                  .couponModel
                                                                  .subTotal
                                                                  .toString()
                                                              : cartData
                                                                  .viewCartModel
                                                                  .subTotal,
                                                      orderStatus: "ordered",
                                                      totalDiscount: cartData
                                                          .viewCartModel
                                                          .totalDiscount
                                                          .toString(),
                                                      totalProductPrice: cartData
                                                          .viewCartModel
                                                          .totalProductPrice,
                                                      address: addressData
                                                          .fullAddress,
                                                      coupenCode: coupenData
                                                              .isCouponAdded
                                                          ? coupenData
                                                              .couponModel
                                                              .data[0]
                                                              .couponCode
                                                          : "");
                                                }

                                                if (data.orderSuccessModel
                                                        .status ==
                                                    "200") {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          "/orderResponseView");
                                                }
                                              },
                                              child: Text("Yes")),
                                        ],
                                      );
                                    });

                                // if (orderNowData.isBuyingSingleItem) {
                                //   await orderNowData.buySingleItem(
                                //     subTotal:
                                //         cartData.addToCartModel.totalPrice,
                                //     orderStatus: "ordered",
                                //     totalDiscount:
                                //         cartData.addToCartModel.cutPrice,
                                //     totalProductPrice:
                                //         cartData.addToCartModel.price,
                                //     address: addressData.fullAddress,
                                //     productId: cartData.addToCartModel.cartId
                                //         .toString(),
                                //   );
                                // } else {
                                //   await orderNowData.buyAllCart(
                                //       subTotal: cartData.viewCartModel.subTotal,
                                //       orderStatus: "ordered",
                                //       totalDiscount: cartData
                                //           .viewCartModel.totalDiscount
                                //           .toString(),
                                //       totalProductPrice: cartData
                                //           .viewCartModel.totalProductPrice,
                                //       address: addressData.fullAddress);
                                // }

                                // if (data.orderSuccessModel.status == "200") {
                                //   Navigator.of(context)
                                //       .pushNamed("/orderResponseView");
                                // }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Select a payment method to continue")));
                              }
                            },
                            color: primaryColor,
                          );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PaymentOptions extends StatelessWidget {
  const PaymentOptions({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.icon,
    this.onTap,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final bool value;
  final IconData icon;
  final Function()? onTap;
  final Function(bool? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: onChanged,
                  shape: CircleBorder(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Text(subTitle),
                  ],
                ),
              ],
            ),
            Icon(
              icon,
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
