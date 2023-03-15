// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/myOrders/my_orders.notifier.dart';
import 'package:qcamyapp/repository/trackingStatus/trackingStatus.notifier.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderDetailsView extends StatelessWidget {
   const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget _buildIndicator() {
      return Container(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      );
    }

    final orderDetailsData =
        Provider.of<MyOrdersNotifier>(context, listen: false);
    final trackingStatusData =
        Provider.of<TrackingStatusNotifier>(context, listen: false);

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
          future: orderDetailsData.getOrderDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Order Number: ${orderDetailsData.orderDetailsModel.id}",
                        style: GoogleFonts.openSans(fontSize: 16),
                      ),
                    ),
                    Visibility(
                      visible:
                          orderDetailsData.orderDetailsModel.data.isNotEmpty
                              ? true
                              : false,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              orderDetailsData.orderDetailsModel.data.length,
                          itemBuilder: (context, index) {
                            return OrderItems(
                              name: orderDetailsData
                                  .orderDetailsModel.data[index].productName,
                              quantity: orderDetailsData
                                  .orderDetailsModel.data[index].qty,
                              price: orderDetailsData
                                  .orderDetailsModel.data[index].price,
                              image: orderDetailsData
                                  .orderDetailsModel.data[index].image,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PriceDetails(
                      numberOfItems: orderDetailsData
                          .orderDetailsModel.noProducts
                          .toString(),
                      totalPrice:
                          orderDetailsData.orderDetailsModel.totalProductPrice,
                      discount: orderDetailsData.orderDetailsModel.totalDisc,
                      totalAmount: orderDetailsData.orderDetailsModel.subTotal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShippingDetails(
                      address: orderDetailsData.orderDetailsModel.address,
                      expectedDeliveryDate: orderDetailsData.orderDetailsModel.expectedDeliveryDate,
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    FutureBuilder(
                        future: trackingStatusData.getTrackingStatus(order_id: orderDetailsData.orderDetailsModel.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return trackingStatusData.trackingStatusModel.data.isNotEmpty ?
                            ListView.builder(
                                itemCount: trackingStatusData.trackingStatusModel.data.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TimelineTile(
                                    alignment: TimelineAlign.manual,
                                    lineXY: 0.1,
                                    isFirst: true,
                                    indicatorStyle: IndicatorStyle(
                                      width: 20,
                                      height: 20,
                                      indicator: _buildIndicator(),
                                      indicatorXY: 0,
                                    ),
                                    endChild:  _RightChild(
                                      title: 'Order ${trackingStatusData.trackingStatusModel.data[index].cstatus}',
                                      message: trackingStatusData.trackingStatusModel.data[index].ttime+" "+trackingStatusData.trackingStatusModel.data[index].tdate,
                                    ),
                                    beforeLineStyle: const LineStyle(
                                      color: primaryColor,
                                    ),
                                  );
                                }) : Center(child: Text("No Orders"),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(color: primaryColor),
                          );
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    orderDetailsData.orderDetailsModel.orderStatus !=
                            "cancelled"
                        ? Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Cancel Order?",
                                    style: GoogleFonts.openSans(fontSize: 16)),
                                Consumer<MyOrdersNotifier>(
                                    builder: (context, data, _) {
                                  return data.isCancelingOrder
                                      ? CircularProgressIndicator(
                                          color: primaryColor)
                                      : MaterialButton(
                                          child: Text("Cancel",
                                              style: GoogleFonts.openSans(
                                                  fontSize: 16,
                                                  color: Colors.white)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    title: Text('Cancel Order',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    content: Text(
                                                        'Do you want to cancel this order?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                        child: Text('No'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await data
                                                              .cancelOrder(
                                                                  orderId: data
                                                                      .orderId);
                                                          Navigator.pop(
                                                              context);
                                                          if (data.cancelOrderModel
                                                                  .status ==
                                                              "200") {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text("Order cancelled")));
                                                          }
                                                        },
                                                        child: Text('Yes'),
                                                      ),
                                                    ],
                                                  );
                                                }));
                                          },
                                          elevation: 0,
                                          color: primaryColor,
                                        );
                                }),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              );
            }
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          }),
    );
  }
}

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({
    Key? key,
    required this.address,
    required this.expectedDeliveryDate,
  }) : super(key: key);

  final String address;
  final String expectedDeliveryDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Details",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              address,
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            Divider(thickness: 2),
            Row(
              children: [
                Text(
                  "Expected Delivery : ",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  expectedDeliveryDate,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PriceDetails extends StatelessWidget {
  const PriceDetails({
    Key? key,
    required this.numberOfItems,
    required this.totalPrice,
    required this.discount,
    required this.totalAmount,
  }) : super(key: key);

  final String numberOfItems;
  final String totalPrice;
  final String discount;
  final String totalAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text("$numberOfItems items"),
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
                  "₹$totalPrice",
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
                  "-₹$discount",
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
                  "₹$totalAmount",
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
    );
  }
}

class OrderItems extends StatelessWidget {
  const OrderItems({
    Key? key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  }) : super(key: key);

  final String name;
  final String price;
  final String quantity;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            image,
            width: 60,
            height: 60,
            errorBuilder: ((context, error, stackTrace) {
              return Container(
                color: Colors.white,
                width: 60,
                height: 60,
              );
            }),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  name,
                  style: GoogleFonts.openSans(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "Qty: $quantity",
                style: GoogleFonts.openSans(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                "₹$price",
                style: GoogleFonts.openSans(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.title,
    required this.message,
    this.disabled = false,
  }) : super(key: key);

  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
