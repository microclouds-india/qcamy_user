// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../config/colors.dart';
import '../../../../repository/adBanner/sliderAdBanner.notifier.dart';
import '../../../../repository/userProfile/userProfile.notifier.dart';
import '../../../../widgets/ad_error.widget.dart';
import '../../../../widgets/booking_form_textfield.widget.dart';
import '../../../../widgets/success_dialogBox.widget.dart';

class ApplicationView extends StatelessWidget {
  ApplicationView({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final adData = Provider.of<SliderAdBannerNotifier>(context, listen: true);
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    _nameController.text = userProfileData.userProfileModel.data[0].name;
    _emailController.text = userProfileData.userProfileModel.data[0].email;
    _phone1Controller.text = userProfileData.userProfileModel.data[0].phone;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Application",
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
          future: adData.getBottomSlidingAdDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Info:",
                              style: GoogleFonts.openSans(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              adData.bottomSlidingAdDetailsModel.data[0].info,
                              style: GoogleFonts.openSans(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.all(10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: adData.bottomSlidingAdDetailsModel.data[0]
                              .image.data[0].image,
                          fit: BoxFit.fill,
                          errorWidget: ((context, url, error) {
                            return Center(
                              child: BannerError(),
                            );
                          }),
                          progressIndicatorBuilder:
                              ((context, url, downloadProgress) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Text(
                          "Enter your details",
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
                        hint: "Email",
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
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
                        controller: _phone1Controller,
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: Consumer<SliderAdBannerNotifier>(
                    builder: (context, data, _) {
                  return data.isApplying
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            heightFactor: 1,
                            widthFactor: 1,
                            child: SizedBox(
                              height: 35,
                              width: 35,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        )
                      : Card(
                          margin: EdgeInsets.all(0),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 10, right: 10, top: 10),
                            child: MaterialButton(
                                child: Text(
                                  "Apply Now",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                                color: primaryColor,
                                onPressed: () async {
                                  if (_nameController.text.isNotEmpty ||
                                      _emailController.text.isNotEmpty ||
                                      _phone1Controller.text.isNotEmpty) {
                                    await data.applyInBottomAds(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phone1Controller.text);
                                    if (data.applyInBottomAdsModel.status ==
                                        "200") {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return SuccessDialog(
                                              message:
                                                  "Your application has been registered successfully.\nWe will contact you soon",
                                              onOkPressed: () {
                                                Navigator.pop(context);
                                                FocusScope.of(context)
                                                    .unfocus();
                                                Navigator.pop(context);
                                              },
                                            );
                                          }));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Something went wrong.Try again later!")));
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please fill all the fields")));
                                  }
                                }),
                          ),
                        );
                }),
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


// Consumer<SliderAdBannerNotifier>(
//                     builder: (context, data, _) {
//                   return data.isApplying
//                       ? Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             heightFactor: 1,
//                             widthFactor: 1,
//                             child: SizedBox(
//                               height: 35,
//                               width: 35,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 color: primaryColor,
//                               ),
//                             ),
//                           ),
//                         )
//                       : Card(
//                           margin: EdgeInsets.all(0),
//                           elevation: 0,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 5, left: 10, right: 10, top: 10),
//                             child: Expanded(
//                               child: MaterialButton(
//                                   child: Text(
//                                     "Submit",
//                                     style: GoogleFonts.openSans(
//                                         fontSize: 18,
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600),
//                                   ),
//                                   color: primaryColor,
//                                   onPressed: () async {
//                                     if (_nameController.text.isNotEmpty ||
//                                         _emailController.text.isNotEmpty ||
//                                         _phone1Controller.text.isNotEmpty) {
//                                       await data.applyInBottomAds(
//                                           name: _nameController.text,
//                                           email: _emailController.text,
//                                           phone: _phone1Controller.text);
//                                       if (data.applyInBottomAdsModel.status ==
//                                           "200") {
//                                         showDialog(
//                                             context: context,
//                                             builder: ((context) {
//                                               return SuccessDialog(
//                                                 message:
//                                                     "Your application has been registered successfully.\nWe will contact you soon",
//                                                 onOkPressed: () {
//                                                   Navigator.pop(context);
//                                                   FocusScope.of(context)
//                                                       .unfocus();
//                                                   Navigator.pop(context);
//                                                 },
//                                               );
//                                             }));
//                                       } else {
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(SnackBar(
//                                                 content: Text(
//                                                     "Something went wrong.Try again later!")));
//                                       }
//                                     } else {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(SnackBar(
//                                               content: Text(
//                                                   "Please fill all the fields")));
//                                     }
//                                   }),
//                             ),
//                           ),
//                         );
//                 }),
