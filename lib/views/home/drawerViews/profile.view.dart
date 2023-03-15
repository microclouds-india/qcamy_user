// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import '../../../repository/userProfile/userProfile.notifier.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: userProfileData.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.only(bottom: 50),
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: primaryColor,
                    height: 150,
                    child: Text(
                      "My Profile",
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 2,
                          fontSize: 26),
                    ),
                  ),

                  UserInfo(
                    title: "Name",
                    text: userProfileData.userProfileModel.data[0].name,
                    icon: Icons.person,
                  ),
                  UserInfo(
                    title: "Mobile",
                    text: userProfileData.userProfileModel.data[0].phone,
                    icon: Icons.call,
                  ),
                  UserInfo(
                    title: "Email",
                    text: userProfileData.userProfileModel.data[0].email,
                    icon: Icons.email,
                  ),
                  // GenderInfo(userProfileData: userProfileData),
                  UserInfo(
                    title: "Gender",
                    text: userProfileData.userProfileModel.data[0].gender,
                    icon: userProfileData.userProfileModel.data[0].gender ==
                            "MALE"
                        ? Icons.male
                        : Icons.female,
                  ),
                  UserInfo(
                    title: "Location",
                    text: "Latitude: "+userProfileData.userProfileModel.data[0].lat+"\nLongitude: "+userProfileData.userProfileModel.data[0].long,
                    icon: Icons.location_on,
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key? key,
    required this.text,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 35,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w700, fontSize: 18),
              ),
              Text(
                text,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class GenderInfo extends StatelessWidget {
//   const GenderInfo({
//     Key? key,
//     required this.userProfileData,
//   }) : super(key: key);

//   final UserProfileNotifier userProfileData;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       margin: EdgeInsets.all(15),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Text(
//             "Gender",
//             style: GoogleFonts.quicksand(
//                 fontWeight: FontWeight.w700, fontSize: 18),
//           ),
//           SizedBox(height: 10),
//           Icon(
//             userProfileData.userProfileModel.data[0].gender == "MALE"
//                 ? Icons.male
//                 : Icons.female,
//             color: primaryColor,
//             size: 40,
//           ),
//           Text(
//             userProfileData.userProfileModel.data[0].gender,
//             style:
//                 GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 16),
//           ),
//           SizedBox(height: 10),
//         ],
//       ),
//     );
//   }
// }
