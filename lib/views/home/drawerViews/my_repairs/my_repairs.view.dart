// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import '../../../../repository/my_repairs/my_repairs.notifier.dart';

class MyCameraRepairsView extends StatelessWidget {
  const MyCameraRepairsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRepairsData = Provider.of<MyRepairsNotifier>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            "My Repairs",
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
            future: myRepairsData.getMyRepairs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (myRepairsData.myRepairsModel.data.isEmpty) {
                  return Center(
                    child: Text("No Repairs"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: myRepairsData.myRepairsModel.data.length,
                      itemBuilder: (context, index) {
                        return OrderItem(
                          orderNumber:
                              myRepairsData.myRepairsModel.data[index].id,
                          date: myRepairsData.myRepairsModel.data[index].date,
                          equipmentName: myRepairsData
                              .myRepairsModel.data[index].equipmentName,
                          orderStatus: "Submitted",
                          onTap: () {
                            myRepairsData.repairBookingId =
                                myRepairsData.myRepairsModel.data[index].id;
                            Navigator.of(context)
                                .pushNamed("/myCameraRepairDetailsView");
                          },
                        );
                      });
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }));
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
    required this.equipmentName,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String equipmentName;
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OrderElement(
                          title: "Order#",
                          value: orderNumber,
                          keySize: 16,
                          valueSize: 16,
                        ),
                        SizedBox(height: 5),
                        OrderElement(
                          title: "Equipment",
                          value: equipmentName,
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
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
              Divider(color: Colors.grey),
              OrderElement(
                title: "Status",
                value: orderStatus,
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
