// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/address/address.notifier.dart';

import '../../../../config/colors.dart';
import '../../../../widgets/booking_form_textfield.widget.dart';

class AddAddressView extends StatelessWidget {
  AddAddressView({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _phone2Controller = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final addressData = Provider.of<AddressNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Address",
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Text(
                "Enter your shipping address",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            BookingFormTextFields(
              hint: "Name",
              maxLines: 1,
              controller: _nameController,
            ),
            BookingFormTextFields(
              hint: "Address",
              maxLines: 3,
              controller: _addressController,
            ),
            BookingFormTextFields(
              hint: "City/Town",
              maxLines: 1,
              controller: _placeController,
            ),
            BookingFormTextFields(
              hint: "Landmark",
              maxLines: 3,
              controller: _landmarkController,
            ),
            BookingFormTextFields(
              hint: "Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _phone1Controller,
            ),
            BookingFormTextFields(
              hint: "Alternate Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _phone2Controller,
            ),
            BookingFormTextFields(
              hint: "Pincode",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _pincodeController,
            ),
          ],
        ),
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
                            "Add",
                            style: GoogleFonts.openSans(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          color: primaryColor,
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (_nameController.text.isNotEmpty &&
                                _addressController.text.isNotEmpty &&
                                _phone1Controller.text.isNotEmpty &&
                                _placeController.text.isNotEmpty &&
                                _landmarkController.text.isNotEmpty &&
                                _pincodeController.text.isNotEmpty &&
                                _phone2Controller.text.isNotEmpty) {
                              await data.addAddress(
                                  name: _nameController.text,
                                  address: _addressController.text,
                                  phone1: _phone1Controller.text,
                                  phone2: _phone2Controller.text,
                                  landmark: _landmarkController.text,
                                  city: _placeController.text,
                                  pincode: _pincodeController.text);

                              if (data.addAddressModel.status == "200") {
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Something went wrong")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content:
                                          Text("Please fill all the fields")));
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
