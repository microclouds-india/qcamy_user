// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/book_photographer/book_photographer.notifier.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.notifier.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';

import '../../../repository/address/address.notifier.dart';
import '../../../widgets/booking_form_textfield.widget.dart';

class BookPhotographerView extends StatelessWidget {
  BookPhotographerView({Key? key}) : super(key: key);

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _occassionTextController =
      TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  final TextEditingController _phone1TextController = TextEditingController();
  final TextEditingController _phone2TextController = TextEditingController();
  final TextEditingController _dateTextController =
      TextEditingController(text: DateTime.now().toString());

  @override
  Widget build(BuildContext context) {
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    final addressData = Provider.of<AddressNotifier>(context, listen: false);
    _nameTextController.text = userProfileData.userProfileModel.data[0].name;
    _phone1TextController.text = userProfileData.userProfileModel.data[0].phone;
    if (addressData.viewAddressModel.data.isNotEmpty) {
      _addressTextController.text =
          addressData.viewAddressModel.data[0].address;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Book Photographer",
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
          children: [
            SizedBox(height: 50),
            BookingFormTextFields(
              controller: _nameTextController,
              hint: "Enter your name",
              maxLines: 1,
            ),
            BookingFormTextFields(
              controller: _occassionTextController,
              hint: "Occassion(wedding,birthday,etc)",
              maxLines: 1,
            ),
            BookingFormTextFields(
              controller: _addressTextController,
              hint: "Address",
              maxLines: 3,
            ),
            BookingFormTextFields(
              controller: _phone1TextController,
              hint: "Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            BookingFormTextFields(
              controller: _phone2TextController,
              hint: "Alternate Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'd MMM, yyyy',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime.now().subtract(Duration(days: 0)),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month,
                      size: 30,
                      color: Colors.black,
                    ),
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: TextStyle(color: grey),
                    contentPadding: EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade800, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (val) {
                    _dateTextController.text = val;
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Consumer<BookPhotographerNotifier>(builder: (context, data, _) {
            return data.isLoading
                ? Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )),
                  )
                : BookingButton(
                    text: "Book Now",
                    onTap: () async {
                      if (_nameTextController.text.isNotEmpty &&
                          _addressTextController.text.isNotEmpty &&
                          _phone1TextController.text.isNotEmpty &&
                          _dateTextController.text.isNotEmpty &&
                          _occassionTextController.text.isNotEmpty) {
                        LocalStorage localStorage = LocalStorage();
                        final String? token = await localStorage.getToken();

                        await data.bookPhotographer(
                            token: token!,
                            photographerId: data.photographerId,
                            name: _nameTextController.text,
                            phone: _phone1TextController.text,
                            alternateNumber: _phone2TextController.text,
                            bookingDate: _dateTextController.text,
                            bookingPurpose: _occassionTextController.text,
                            bookingPlace: _addressTextController.text);
                        if (data.bookPhotographerModel.status == "200") {
                          // showDialog(
                          //     context: context,
                          //     builder: ((context) {
                          //       return SuccessDialog(
                          //         message:
                          //             "Your request has been registered successfully.\nConfirmation will be available soon.",
                          //         onOkPressed: () {
                          //           Navigator.pop(context);
                          //           FocusScope.of(context).unfocus();
                          //           Navigator.pop(context);
                          //           // Navigator.pushReplacementNamed(
                          //           //     context, '/photographerProfileView');
                          //         },
                          //       );
                          //     }));
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Success",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Your request has been registered successfully.\nConfirmation will be available soon.",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: Colors.black),
                                            textAlign: TextAlign.center,
                                          ),
                                          MaterialButton(
                                            elevation: 0,
                                            color: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "OK",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          MaterialButton(
                                            elevation: 0,
                                            color: secondaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context);
                                              Navigator.of(context).pushNamed(
                                                  "/photographerBookingsView");
                                            },
                                            child: Text(
                                              "Go to My Bookings",
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                        } else if (data.bookPhotographerModel.status == "404") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                  "Session expired. Please login again to continue"),
                            ),
                          );
                          LocalStorage localStorage = LocalStorage();
                          await localStorage.deleteToken();
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/mobileAuthView", (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                  "Something went wrong. Please try again later."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text(
                                "Fill required fields to request a booking"),
                          ),
                        );
                      }
                    },
                  );
          }),
        ),
      ),
    );
  }
}
