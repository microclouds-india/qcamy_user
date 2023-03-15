// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import '../../../../repository/my_repairs/my_repairs.notifier.dart';
import 'my_repairs.view.dart';

class MyCameraRepairDetailsView extends StatelessWidget {
  const MyCameraRepairDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRepairsData =
        Provider.of<MyRepairsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Details",
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
          future: myRepairsData.getRepairDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderDetails(
                      orderNumber: myRepairsData.repairDetailsModel.data[0].id,
                      orderStatus: "Submitted",
                      date: myRepairsData.repairDetailsModel.data[0].date,
                      equipmentName: myRepairsData
                          .repairDetailsModel.data[0].equipmentName,
                      address: myRepairsData.repairDetailsModel.data[0].address,
                      userName: myRepairsData.repairDetailsModel.data[0].name,
                      complaintDescription:
                          myRepairsData.repairDetailsModel.data[0].descri,
                      phone: myRepairsData.repairDetailsModel.data[0].phone),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 5),
                    child: Text(
                      "Note: Our expert will contact you soon",
                      style: GoogleFonts.openSans(fontSize: 16),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}

//show orderd items list
class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.orderNumber,
    required this.orderStatus,
    required this.date,
    required this.equipmentName,
    required this.address,
    required this.userName,
    required this.complaintDescription,
    required this.phone,
  }) : super(key: key);

  final String orderNumber;
  final String date;
  final String equipmentName;
  final String address;
  final String userName;
  final String phone;
  final String complaintDescription;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
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
                        title: "Name",
                        value: userName,
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
                        title: "Complaint",
                        value: complaintDescription,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      SizedBox(height: 5),
                      OrderElement(
                        title: "Address",
                        value: address,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      SizedBox(height: 5),
                      OrderElement(
                        title: "Phone",
                        value: phone,
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
                // Icon(Icons.arrow_forward_ios, size: 15),
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
        ));
  }
}
