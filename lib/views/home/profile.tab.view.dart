// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/views/main.view.dart';
import 'package:qcamyapp/widgets/view_image.widget.dart';

import '../../../repository/userProfile/userProfile.notifier.dart';
import '../../core/token_storage/storage.dart';
import 'photographerTabViews/photographerProfile.view.dart';

class ProfileTabView extends StatefulWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  State<ProfileTabView> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabView> {

  final ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.clear();
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);

    void selectImage() async {
      try {
        final XFile? selectedImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (selectedImage!.path.isNotEmpty) {
          imageFile = selectedImage;
          await userProfileData.uploadProfilePic(profileImg: imageFile!);
          if (userProfileData.uploadProfilePicModel.status == "200") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: primaryColor,
                content: Text("Profile image updated"),
              ),
            );
          }
        }

        setState(() {});
      } catch (e) {
        // ignore: avoid_print
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text("Something went wrong,Try again!"),
          ),
        );
        // print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: userProfileData.getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  GestureDetector(
                      onTap: () async {
                        // selectImage();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                title: Text("Select"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            selectImage();
                                            Navigator.pop(context);
                                          },
                                          child: Text("Update image")),
                                      SizedBox(height: 15),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => ViewImage(
                                                    imageLink: userProfileData
                                                            .userProfileModel
                                                            .data[0]
                                                            .profileImage
                                                            .isNotEmpty
                                                        ? userProfileData
                                                            .userProfileModel
                                                            .data[0]
                                                            .profileImage
                                                        : noImagePic),
                                              ),
                                            );
                                          },
                                          child: Text("View image")),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
                                          ],
                                          border: Border.all(color: Colors.grey.withOpacity(0.05)),
                                        ),
                                        child: TextField(
                                          controller: nameController,
                                          maxLines: 1,
                                          style: const TextStyle(color: Colors.black, fontSize: 13),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Name",
                                            counterText: "",
                                            hintStyle: const TextStyle(color: grey),
                                            contentPadding: const EdgeInsets.all(12),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
                                          ],
                                          border: Border.all(color: Colors.grey.withOpacity(0.05)),
                                        ),
                                        child: TextField(
                                          controller: phoneController,
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(color: Colors.black, fontSize: 13),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Phone",
                                            counterText: "",
                                            hintStyle: const TextStyle(color: grey),
                                            contentPadding: const EdgeInsets.all(12),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Consumer<UserProfileNotifier>(builder: (context, data, _) {
                                        return data.isLoading ? Container(
                                          width: 20,
                                          padding: const EdgeInsets.only(top: 20),
                                          child: Center(child: CircularProgressIndicator(color: primaryColor)),
                                        ) : GestureDetector(
                                          child: Container(
                                            margin: EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10))),
                                            height: 40,
                                            width: 150,
                                            child: Center(
                                              child: Text("Submit",
                                                style: GoogleFonts.openSans(
                                                    color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          onTap: () async {

                                            if(nameController.text.isNotEmpty &&
                                                phoneController.text.isNotEmpty){

                                              await userProfileData.editUserProfile(name: nameController.text,
                                                  phone: phoneController.text);

                                              if (userProfileData.editUserProfileModel.status == "200") {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    behavior: SnackBarBehavior.floating,
                                                    backgroundColor: Colors.red,
                                                    content: Text("Success"),
                                                  ),
                                                );
                                                setState(() {});
                                                nameController.clear();
                                                phoneController.clear();
                                                Navigator.pop(context);
                                                userProfileData.notifyListeners();
                                              } else {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    behavior: SnackBarBehavior.floating,
                                                    backgroundColor: Colors.red,
                                                    content: Text('Something went wrong'),
                                                  ),
                                                );
                                              }
                                            }else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  behavior: SnackBarBehavior.floating,
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      "Fill all the fields to continue."),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 75,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  "assets/images/png/nobg_pholder_image.png"),
                              foregroundImage: NetworkImage(
                                userProfileData.userProfileModel.data[0]
                                        .profileImage.isNotEmpty
                                    ? userProfileData
                                        .userProfileModel.data[0].profileImage
                                    : noImagePic,
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(50, 50),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: primaryColor),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  Consumer<UserProfileNotifier>(builder: (context, data, _) {
                    return UserInfo(
                      title: "Name",
                      text: userProfileData.userProfileModel.data[0].name,
                      icon: Icons.person,
                    );
                  }),
                  Consumer<UserProfileNotifier>(builder: (context, data, _) {
                    return UserInfo(
                      title: "Mobile",
                      text: userProfileData.userProfileModel.data[0].phone,
                      icon: Icons.call,
                    );
                  }),
                  UserInfo(
                    title: "Email",
                    text: userProfileData.userProfileModel.data[0].email,
                    icon: Icons.email,
                  ),
                  // GenderInfo(userProfileData: userProfileData),
                  UserInfo(
                    title: "Gender",
                    text: userProfileData.userProfileModel.data[0].gender,
                    icon: userProfileData.userProfileModel.data[0].gender == "MALE"
                        ? Icons.male
                        : Icons.female,
                  ),
                  if(userProfileData.userProfileModel.data[0].lat.isNotEmpty)
                  UserInfo(
                    title: "Location",
                    text: "Latitude: "+userProfileData.userProfileModel.data[0].lat+"\nLongitude: "+userProfileData.userProfileModel.data[0].long,
                    icon: Icons.location_on,
                  ),
                  SizedBox(height: 20),
                  DrawerItem(
                    title: "My Cart",
                    icon: Icons.shopping_cart,
                    onTap: () {
                      Navigator.of(context).pushNamed("/cartView");
                    },
                  ),
                  DrawerItem(
                      title: "My Orders",
                      icon: Icons.list_alt,
                      onTap: () {
                        Navigator.of(context).pushNamed("/ordersView");
                      }),

                  DrawerItem(
                      title: "My Rentals",
                      icon: Icons.timer_rounded,
                      onTap: () {
                        Navigator.of(context).pushNamed("/rentalsView");
                      }),

                  DrawerItem(
                      title: "Photographer bookings",
                      icon: Icons.camera_alt,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/photographerBookingsView");
                      }),

                  DrawerItem(
                      title: "Camera repairs",
                      icon: Icons.miscellaneous_services_rounded,
                      onTap: () {
                        Navigator.of(context).pushNamed("/myCameraRepairsView");
                      }),
                  DrawerItem(
                      title: "Wishlist",
                      icon: Icons.favorite,
                      onTap: () {
                        Navigator.of(context).pushNamed("/wishListView");
                      }),
                  DrawerItem(
                    title: "Address",
                    icon: Icons.gps_fixed,
                    onTap: () {
                      Navigator.of(context).pushNamed("/addressView");
                    },
                  ),
                  DrawerItem(
                    title: "Logout",
                    icon: Icons.logout_outlined,
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              title: Text('Logout',
                                  style: TextStyle(color: Colors.black)),
                              content: Text(
                                  'Do you want to logout from this account?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text('No'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //logout operations
                                    HomeView.pageIndexNotifier.value = 0;
                                    LocalStorage localStorage = LocalStorage();
                                    await localStorage
                                        .deleteToken()
                                        .whenComplete(() {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              "/mobileAuthView",
                                              (route) => false);
                                    });
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          }));
                    },
                  ),
                  SizedBox(height: 20),
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
      margin: EdgeInsets.only(left: 10, right: 10),
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
            size: 28,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              Text(
                text,
                style: GoogleFonts.openSans(fontSize: 15),
              ),
            ],
          )
        ],
      ),
    );
  }
}
