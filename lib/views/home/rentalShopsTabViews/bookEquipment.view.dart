// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/rental_booking/rental_booking.notifier.dart';
import 'package:qcamyapp/repository/rental_equipment_detail/rental_equi_details.notifier.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.notifier.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../../../repository/address/address.notifier.dart';
import '../../../repository/rental_equipments/rental_equipments.notifier.dart';
import '../../../widgets/booking_form_textfield.widget.dart';

class BookEquipmentView extends StatefulWidget {
  BookEquipmentView({Key? key}) : super(key: key);

  @override
  State<BookEquipmentView> createState() => _BookEquipmentViewState();
}

class _BookEquipmentViewState extends State<BookEquipmentView> {
  final nameTextController = TextEditingController();

  final addressTextController = TextEditingController();

  final phoneTextController = TextEditingController();

  final bookingDateTextController =
      TextEditingController(text: DateTime.now().toString());

  final returnDateTextController =
      TextEditingController(text: DateTime.now().toString());

  @override
  Widget build(BuildContext context) {
    final rentalShopData =
        Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    final rentalEquipmentData =
        Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    final orderRentalItemData =
        Provider.of<RentalBookingNotifier>(context, listen: false);

    final userData = Provider.of<UserProfileNotifier>(context, listen: false);

    TimeOfDay selectedTime = TimeOfDay.now();
    String bookingTime = "${selectedTime.hour}:${selectedTime.minute}";
    String returnTime = "${selectedTime.hour}:${selectedTime.minute}";

    final bookingDateValues = bookingDateTextController.text.split(" ");
    final returnDateValues = returnDateTextController.text.split(" ");

    String bookingDate = bookingDateValues[0];
    String returnDate = returnDateValues[0];

    nameTextController.text = userData.userProfileModel.data[0].name;
    phoneTextController.text = userData.userProfileModel.data[0].phone;
    final addressData = Provider.of<AddressNotifier>(context, listen: false);
    if (addressData.viewAddressModel.data.isNotEmpty) {
      addressTextController.text = addressData.viewAddressModel.data[0].address;
    }

    final ImagePicker imagePicker = ImagePicker();

    void selectImages() async {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          rentalShopData.imageFileList!.addAll(selectedImages);
        }
        print("Image List Length:" + rentalShopData.imageFileList!.length.toString());
        rentalShopData.notifyListeners();
        // setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Book Equipment",
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
            SizedBox(height: 50),
            BookingFormTextFields(
              controller: nameTextController,
              hint: "Enter your name",
              maxLines: 1,
            ),
            BookingFormTextFields(
              controller: addressTextController,
              hint: "Address",
              maxLines: 3,
            ),
            BookingFormTextFields(
              controller: phoneTextController,
              hint: "Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
              child: Text("Booking Date"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
              child: DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMM, yyyy - hh:mm a',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime.now().subtract(Duration(days: 0)),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  calendarTitle: "Booking Date",
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
                    final values = val.split(" ");

                    bookingTime = values[1];
                    bookingDate = values[0];
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
              child: Text("Return Date"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, right: 10),
              child: DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMM, yyyy - hh:mm a',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime.now().subtract(Duration(days: 0)),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  calendarTitle: "Return Date",
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
                    final values = val.split(" ");

                    returnTime = values[1];
                    returnDate = values[0];
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10, top: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                color: primaryColor,
                onPressed: () async {
                  selectImages();
                  // print(allProductsData.togetherproductsItems.toString());
                },
                child: Text(
                  "Add adhar Image",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Consumer<RentalEquipmentsNotifier>(builder: (context, data, _) {
              return ReorderableGridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10, crossAxisCount: 3),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  onReorder: ((oldIndex, newIndex) {
                    XFile path = rentalShopData.imageFileList!.removeAt(oldIndex);
                    rentalShopData.imageFileList!.insert(newIndex, path);
                    setState(() {});
                  }),
                  itemCount: rentalShopData.imageFileList!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      key: ValueKey(index),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Stack(
                        children: [
                          Image.file(
                            File(rentalShopData.imageFileList![index].path),
                            fit: BoxFit.cover,
                          ),
                          // Visibility(
                          //   visible: index == 0,
                          //   child: Container(
                          //     decoration: BoxDecoration(color: primaryColor),
                          //     child: Text(
                          //       " Main Image ",
                          //       style: TextStyle(
                          //           color: Colors.white, fontSize: 10),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  });
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<RentalBookingNotifier>(builder: (context, data, _) {
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
                      if (nameTextController.text.isNotEmpty &&
                          addressTextController.text.isNotEmpty &&
                          rentalShopData.imageFileList!.isNotEmpty &&
                          phoneTextController.text.isNotEmpty) {
                        if (bookingTime == returnTime &&
                            bookingDate == returnDate) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Booking date and return date can't be same"),
                          ));
                        } else {
                          LocalStorage localStorage = LocalStorage();
                          final String? token = await localStorage.getToken();
                          print(token.toString());
                          try {
                            await data.bookRentalEquipment(
                              rentalShopId: rentalShopData.rentalShopId,
                              token: token!,
                              bookingDate: bookingDate,
                              phone: phoneTextController.text,
                              address: addressTextController.text,
                              equipmentId: rentalEquipmentData.rentalEquipmentId,
                              qty: orderRentalItemData.qty,
                              bookingTime: bookingTime,
                              bookingToDate: returnDate,
                              bookingToTime: returnTime,
                              imageList: rentalShopData.imageFileList!,
                            );
                          } on Exception {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Submitted"),
                            ));
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    child: SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height *
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
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Your request has been registered successfully.\nConfirmation will be available soon.",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                                setState(() {
                                                  rentalShopData.imageFileList!.clear();
                                                });
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                                setState(() {
                                                  rentalShopData.imageFileList!.clear();
                                                });
                                                Navigator.pop(context);
                                                Navigator.of(context)
                                                    .pushNamed("/rentalsView");
                                              },
                                              child: Text(
                                                "Go to My Rentals",
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
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Submitted"),
                            ));
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Dialog(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0)),
                                    child: SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height *
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
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Your request has been registered successfully.\nConfirmation will be available soon.",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                                setState(() {
                                                  rentalShopData.imageFileList!.clear();
                                                });
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                                setState(() {
                                                  rentalShopData.imageFileList!.clear();
                                                });
                                                Navigator.pop(context);
                                                Navigator.of(context)
                                                    .pushNamed("/rentalsView");
                                              },
                                              child: Text(
                                                "Go to My Rentals",
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
                          }

                          if (data.rentalProductBookingResponseModel.status == "200") {
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "Your request has been registered successfully.\nConfirmation will be available soon.",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
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
                                                FocusScope.of(context)
                                                    .unfocus();
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
                                                FocusScope.of(context)
                                                    .unfocus();
                                                setState(() {
                                                  rentalShopData.imageFileList!.clear();
                                                });
                                                Navigator.pop(context);
                                                Navigator.of(context)
                                                    .pushNamed("/rentalsView");
                                              },
                                              child: Text(
                                                "Go to My Rentals",
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
                        }
                        //
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
