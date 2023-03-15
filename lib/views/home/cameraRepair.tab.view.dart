// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/camera_repair/cameraRepair.notifier.dart';
import 'package:qcamyapp/views/main.view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';

import '../../repository/address/address.notifier.dart';
import '../../repository/cart/cart.notifier.dart';
import '../../repository/userProfile/userProfile.notifier.dart';
import '../../widgets/booking_form_textfield.widget.dart';

class CameraRepairTabView extends StatefulWidget {
  const CameraRepairTabView({Key? key}) : super(key: key);

  @override
  State<CameraRepairTabView> createState() => _CameraRepairTabViewState();
}

class _CameraRepairTabViewState extends State<CameraRepairTabView> {
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _equipmentNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //func to select image from gallery
    void selectImages() async {
      try {
        final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
        if (selectedImages!.isNotEmpty) {
          imageFileList!.addAll(selectedImages);
        }
        // print("Image List Length:" + imageFileList!.length.toString());
        setState(() {});
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }

    final userProfileData = Provider.of<UserProfileNotifier>(context, listen: false);
    final addressData = Provider.of<AddressNotifier>(context, listen: false);
    _nameController.text = userProfileData.userProfileModel.data[0].name;
    _mobileNumberController.text = userProfileData.userProfileModel.data[0].phone;
    if (addressData.viewAddressModel.data.isNotEmpty) {
      _addressController.text = addressData.viewAddressModel.data[0].address;
    }
    final cartData = Provider.of<CartNotifier>(context, listen: false);

    return Scaffold(
        // backgroundColor: mainBgColor,
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/notificationView");
                  },
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.grey.shade700,
                  ),
                ),
                FutureBuilder(
                    future: cartData.getCartCount(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (cartData.cartCountModel.status == "200") {
                          return IconButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamed("/cartView");
                            },
                            icon: Consumer<CartNotifier>(
                                builder: (context, data, _) {
                              return Badge(
                                badgeContent: Text(
                                  cartData.cartCountModel.count.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                badgeColor: primaryColor,
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.grey.shade700,
                                ),
                              );
                            }),
                          );
                        } else {
                          return IconButton(
                            onPressed: () async {
                              Navigator.of(context).pushNamed("/cartView");
                            },
                            icon: Badge(
                              badgeContent: Text(
                                '0',
                                style: TextStyle(color: Colors.white),
                              ),
                              badgeColor: primaryColor,
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          );
                        }
                      }
                      return SizedBox();
                    }),
              ],
            ),
            //title text
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "Repair your camera",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            //repair form textfields
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
              hint: "Phone Number",
              maxLength: 12,
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _mobileNumberController,
            ),
            BookingFormTextFields(
              hint: "Equipment Name",
              maxLines: 1,
              controller: _equipmentNameController,
            ),
            BookingFormTextFields(
              hint: "Complaint Description",
              maxLines: 5,
              controller: _descriptionController,
            ),
            //button to select images
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                color: Colors.grey,
                onPressed: () async {
                  selectImages();
                },
                child: Text(
                  "Add Images",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            //image showing part
            Visibility(
              visible: imageFileList!.isNotEmpty ? true : false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: imageFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5, crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: Ui.getSquareBoxDecoration(color: primaryColor),
                        child: Stack(
                          children: [
                            Image.file(
                              File(imageFileList![index].path),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                                child: GestureDetector(
                                  onTap: () {
                                    imageFileList?.remove(imageFileList![index]);
                                    setState(() {});
                                  },
                                  child: Container(
                                    child: Icon(Icons.close, color: Colors.white,),
                                    color: Colors.black,
                                  ),
                                ),
                              right: 0,
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            //submit button
            Consumer<CameraRepairNotifier>(builder: (context, data, _) {
              return data.isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 10, right: 10, bottom: 20),
                      child: BookingButton(
                        text: "Submit",
                        // onTap: () async {
                        //   print(imageFileList!.length);
                        // },
                        onTap: () async {
                          if (_nameController.text.isNotEmpty &&
                              _descriptionController.text.isNotEmpty &&
                              _mobileNumberController.text.isNotEmpty &&
                              _equipmentNameController.text.isNotEmpty &&
                              _addressController.text.isNotEmpty &&
                              imageFileList!.isNotEmpty) {
                            LocalStorage localStorage = LocalStorage();
                            final String? token = await localStorage.getToken();

                            try {
                              await data.submitCameraRepair(
                                token: token!,
                                name: _nameController.text,
                                mobileNumber: _mobileNumberController.text,
                                address: _addressController.text,
                                equipmentName: _equipmentNameController.text,
                                description: _descriptionController.text,
                                imageList: imageFileList!,
                              );
                            } on Exception {
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(SnackBar(
                              //   content: Text("Submitted"),
                              // ));
                              showSuccess(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Submitted"),
                              ));
                              showSuccess(context);
                            }

                            try {
                              if (data.cameraRepairModel.status == "200") {
                                // showDialog(
                                //     context: context,
                                //     builder: ((context) {
                                //       return SuccessDialog(
                                //         message:
                                //             "Your complaint has been registered successfully.\nOur expert will contact you soon",
                                //         onOkPressed: () {
                                //           Navigator.pop(context);
                                //           FocusScope.of(context).unfocus();
                                //           setState(() {
                                //             imageFileList!.clear();
                                //           });

                                //           HomeView.pageIndexNotifier.value = 0;
                                //         },
                                //       );
                                //     }));

                                showSuccess(context);
                                _nameController.clear();
                                _mobileNumberController.clear();
                                _descriptionController.clear();
                                _addressController.clear();
                                _equipmentNameController.clear();
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
                            } catch (_) {
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
                                    "Fill all fields to submit repair request"),
                              ),
                            );
                          }
                        },
                      ));
            }),
          ],
        ),
      ),
    ));
  }

  Future<dynamic> showSuccess(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      "Your complaint has been registered successfully.\nOur expert will contact you soon",
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        setState(() {
                          imageFileList!.clear();
                        });

                        HomeView.pageIndexNotifier.value = 0;
                      },
                      child: Text(
                        "OK",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).unfocus();
                        // Navigator.pop(context);
                        setState(() {
                          imageFileList!.clear();
                        });
                        Navigator.of(context).pushNamed("/myCameraRepairsView");
                      },
                      child: Text(
                        "Go to My Repairs",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
}
