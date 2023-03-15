import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';
import 'package:qcamyapp/repository/enquire_product/enquire_product.notifier.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.notifier.dart';
import 'package:qcamyapp/views/main.view.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';
import 'package:qcamyapp/widgets/booking_form_textfield.widget.dart';

class EnquireProduct extends StatefulWidget {
  const EnquireProduct({Key? key}) : super(key: key);

  @override
  State<EnquireProduct> createState() => _EnquireProductState();
}

class _EnquireProductState extends State<EnquireProduct> {

  var product_id = "";
  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productdescriptionController = TextEditingController();
  final TextEditingController _modelNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
    final accessoriesData = Provider.of<AccessoriesNotifier>(context, listen: false);
    _nameController.text = userProfileData.userProfileModel.data[0].name;
    _mobileNumberController.text = userProfileData.userProfileModel.data[0].phone;
    _emailController.text = userProfileData.userProfileModel.data[0].email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Enquire product",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookingFormTextFields(
              hint: "Name",
              maxLines: 1,
              controller: _nameController,
            ),
            BookingFormTextFields(
              hint: "Email",
              maxLines: 3,
              controller: _emailController,
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
              hint: "Product Name",
              maxLines: 1,
              controller: _productNameController,
            ),
            BookingFormTextFields(
              hint: "Product Description",
              maxLines: 5,
              controller: _productdescriptionController,
            ),
            BookingFormTextFields(
              hint: "Model Number",
              maxLines: 1,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: _modelNumberController,
            ),
            FutureBuilder(
              future: accessoriesData.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return accessoriesData.accessoriesModel.data.isNotEmpty ?
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade800, width: 1),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox(),
                        hint: Text(product_id == "" ? "Select product" : product_id, style: const TextStyle(color: Colors.black),),
                        items: accessoriesData.accessoriesModel.data.map((map) => DropdownMenuItem(
                          value: map.id,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 15.0,
                                  bottom: 15.0),
                              decoration:
                              Ui.getBoxDecorationProduct(
                                  color: primaryColor),
                              child: Text(map.productName, style: const TextStyle(color: Colors.black),)),
                        ),
                        ).toList(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          setState(() {
                            product_id = value.toString();
                          },
                          );
                        },
                      ),
                    ),
                  ) : const Center(child: Text("No items"));
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            //button to select images
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 10),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                color: Colors.grey,
                onPressed: () async {
                  selectImages();
                },
                child: const Text(
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: imageFileList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: const Icon(Icons.close, color: Colors.white,),
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
            Consumer<EnquireProductNotifier>(builder: (context, data, _) {
              return data.isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20),
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
                              _productdescriptionController.text.isNotEmpty &&
                              _mobileNumberController.text.isNotEmpty &&
                              _productNameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _modelNumberController.text.isNotEmpty &&
                              product_id.isNotEmpty &&
                              imageFileList!.isNotEmpty) {
                            LocalStorage localStorage = LocalStorage();
                            final String? token = await localStorage.getToken();
                            print(token.toString());
                            try {
                              await data.submitEnquireProduct(
                                token: token!,
                                product_id: product_id,
                                name: _nameController.text,
                                mobileNumber: _mobileNumberController.text,
                                email: _emailController.text,
                                productName: _productNameController.text,
                                productDescription: _productdescriptionController.text,
                                modelNumber: _modelNumberController.text,
                                imageList: imageFileList!,
                              );
                            } on Exception {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Submitted"),
                              ));
                              showSuccess(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Submitted"),
                              ));
                              showSuccess(context);
                            }

                            try {
                              if (data.enquireProductModel.status == "200") {
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
                                _productdescriptionController.clear();
                                _emailController.clear();
                                _modelNumberController.clear();
                                _productNameController.clear();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "Something went wrong. Please try again later."),
                                  ),
                                );
                              }
                            } catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "Something went wrong. Please try again later."),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                content: Text("Fill all fields to submit"),
                              ),
                            );
                          }
                        },
                      ));
            }),
          ],
        ),
      ),
    );
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
                    // MaterialButton(
                    //   elevation: 0,
                    //   color: secondaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     FocusScope.of(context).unfocus();
                    //     // Navigator.pop(context);
                    //     setState(() {
                    //       imageFileList!.clear();
                    //     });
                    //     Navigator.of(context).pushNamed("/myCameraRepairsView");
                    //   },
                    //   // child: Text(
                    //   //   "Go to My Repairs",
                    //   //   style: GoogleFonts.poppins(
                    //   //     fontSize: 16,
                    //   //     fontWeight: FontWeight.w500,
                    //   //     color: Colors.white,
                    //   //   ),
                    //   // ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
