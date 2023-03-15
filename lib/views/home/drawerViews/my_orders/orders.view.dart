// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/myOrders/my_orders.notifier.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myOrderData = Provider.of<MyOrdersNotifier>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My Orders",
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
          future: myOrderData.getMyOrder(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return myOrderData.myOrdersModel.data.isNotEmpty
                  ? ListView.builder(
                      itemCount: myOrderData.myOrdersModel.data.length,
                      itemBuilder: (context, index) {
                        return OrderItem(
                          productsList:
                              myOrderData.myOrdersModel.data[index].items,
                          orderNumber:
                              myOrderData.myOrdersModel.data[index].orderId,
                          date: myOrderData.myOrdersModel.data[index].date,
                          totalItems:
                              myOrderData.myOrdersModel.data[index].noItems,
                          totalAmount:
                              myOrderData.myOrdersModel.data[index].subTotal,
                          paymentType:
                              myOrderData.myOrdersModel.data[index].paymentType,
                          isCouponApplied: myOrderData.myOrdersModel.data[index]
                                  .couponCode.isNotEmpty
                              ? "${myOrderData.myOrdersModel.data[index].couponCode} (${myOrderData.myOrdersModel.data[index].couponOffer}%off)"
                              : "",
                          expectedDeliveryDate: myOrderData
                              .myOrdersModel.data[index].expectedDeliveryDate,
                          orderStatus:
                              myOrderData.myOrdersModel.data[index].orderStatus,
                          onTap: () {
                            myOrderData.orderId =
                                myOrderData.myOrdersModel.data[index].orderId;
                            Navigator.of(context)
                                .pushNamed("/orderDetailsView");
                          },
                        );
                      })
                  : Center(
                      child: Text("No Orders"),
                    );
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
    required this.totalItems,
    required this.totalAmount,
    required this.paymentType,
    required this.orderStatus,
    required this.date,
    required this.onTap,
    required this.isCouponApplied,
    required this.expectedDeliveryDate,
    required this.productsList,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String totalItems;
  final String totalAmount;
  final String paymentType;
  final String orderStatus;
  final Function() onTap;
  final String isCouponApplied;
  final String expectedDeliveryDate;

  final List productsList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: Ui.getBoxDecoration(color: primaryColor),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productsList.length,
                          itemBuilder: (context, index) {
                            if (productsList.isEmpty) {
                              return SizedBox();
                            }
                            return Row(
                              children: [
                                Image.network(
                                  "https://cashbes.com/photography/${productsList[index].image}",
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
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    productsList[index].name,
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        OrderElement(
                          title: "Order#",
                          value: orderNumber,
                          keySize: 16,
                          valueSize: 16,
                        ),
                        SizedBox(height: 5),
                        OrderElement(
                          title: "Date",
                          value: date,
                          keySize: 16,
                          valueSize: 16,
                        ),
                        SizedBox(height: 5),
                        OrderElement(
                          title: "Payment Type",
                          value: paymentType,
                          keySize: 16,
                          valueSize: 16,
                        ),
                        SizedBox(height: 5),
                        OrderElement(
                          title: "Expected Delivery",
                          value: expectedDeliveryDate,
                          keySize: 16,
                          valueSize: 16,
                        ),
                        SizedBox(height: 5),
                        Visibility(
                          visible: isCouponApplied.isNotEmpty ? true : false,
                          child: OrderElement(
                            title: "Coupon",
                            value: isCouponApplied,
                            keySize: 16,
                            valueSize: 16,
                          ),
                        ),
                        Visibility(
                            visible: isCouponApplied.isNotEmpty ? true : false,
                            child: SizedBox(height: 5)),
                        OrderElement(
                          title: "Order Status",
                          value: orderStatus,
                          keySize: 16,
                          valueSize: 16,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
              Divider(color: Colors.grey),
              OrderElement(
                title: "Total Amount",
                value: "₹$totalAmount",
                keySize: 18,
                valueSize: 18,
              ),
            ],
          )),
    );
  }
}

class OrderElement extends StatelessWidget {
  const OrderElement(
      {Key? key,
      required this.value,
      required this.title,
      required,
      required this.keySize,
      required this.valueSize})
      : super(key: key);

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
