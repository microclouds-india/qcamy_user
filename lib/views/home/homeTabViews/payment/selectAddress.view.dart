// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import '../../../../repository/address/address.notifier.dart';

class SelectAddressView extends StatelessWidget {
  const SelectAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressData = Provider.of<AddressNotifier>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "My Address",
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
          future: addressData.getAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return addressData.viewAddressModel.data.isNotEmpty
                  ? ListView.builder(
                      itemCount: addressData.viewAddressModel.data.length,
                      itemBuilder: (context, index) {
                        return AddressCard(
                          id: addressData.viewAddressModel.data[index].id,
                          name: addressData.viewAddressModel.data[index].name,
                          address:
                              addressData.viewAddressModel.data[index].address,
                          city: addressData.viewAddressModel.data[index].city,
                          landmark:
                              addressData.viewAddressModel.data[index].landmark,
                          phone: addressData.viewAddressModel.data[index].phone,
                          phone2: addressData
                              .viewAddressModel.data[index].alternateNumber,
                          pincode:
                              addressData.viewAddressModel.data[index].pincode,
                          isSelected: addressData.selectedIndex == index &&
                                  addressData.isAddressSelected
                              ? true
                              : false,
                          onTap: () {
                            addressData.toggleSelected(index);
                          },
                        );
                      })
                  : Center(
                      child: Text("No Address Found"),
                    );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/addAddressView");
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
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
              Spacer(),
              Expanded(
                child: Consumer<AddressNotifier>(builder: (context, data, _) {
                  return data.isLoading
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
                            "Continue",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          color: primaryColor,
                          onPressed: () async {
                            if (addressData.fullAddress.isNotEmpty &&
                                addressData.isAddressSelected) {
                              Navigator.of(context)
                                  .pushNamed("/paymentOptionsView");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please Select Address")));
                            }
                          });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//show orderd items list
class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.name,
    required this.address,
    required this.city,
    required this.landmark,
    required this.phone,
    required this.phone2,
    required this.pincode,
    required this.id,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  final String id;
  final String name;
  final String address;
  final String city;
  final String landmark;
  final String phone;
  final String phone2;
  final String pincode;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primaryColor : Colors.white),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Address $id",
            //   style: GoogleFonts.openSans(
            //       fontWeight: FontWeight.w600, fontSize: 16),
            // ),
            Text(
              name,
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w500, fontSize: 15),
            ),
            Text(
              "$address, $city, $landmark, $pincode",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Text(
              "$phone, $phone2",
              style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
