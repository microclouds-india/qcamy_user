// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/styles.dart';
import 'package:qcamyapp/core/location_service/location_services.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/notification/notification.notifier.dart';
import 'package:qcamyapp/repository/refresh/refresh.notifier.dart';
import 'package:qcamyapp/repository/userProfile/userProfile.notifier.dart';
import 'package:qcamyapp/views/authentication/mobileAuth.view.dart';
import 'package:qcamyapp/views/home/cameraRepair.tab.view.dart';
import 'package:qcamyapp/views/home/drawerViews/profile.view.dart';
import 'package:qcamyapp/views/home/home.tab.view.dart';
import 'package:qcamyapp/views/home/photographer.tab.view.dart';
import 'package:qcamyapp/views/home/rentalShops.tab.view.dart';
import 'package:qcamyapp/widgets/bottom_nav_bar.widget.dart';
import 'package:geolocator/geolocator.dart';

import '../repository/address/address.notifier.dart';
import '../repository/singleAdBanner/singleAdBanner.notifier.dart';
import 'home/profile.tab.view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  final pages = [
    const HomeTabView(),
    const PhotographerTabView(),
    const CameraRepairTabView(),
    const RentalShopsTabView(),
    const ProfileTabView()
  ];

  @override
  Widget build(BuildContext context) {
    LocalStorage _localStorage = LocalStorage();
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    final singleAdsData =
        Provider.of<SingleAdBannerNotifier>(context, listen: false);
    final addressData = Provider.of<AddressNotifier>(context, listen: false);

    return FutureBuilder(
        future: _localStorage.getToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MobileAuthView();
          }
          return FutureBuilder(
              future: Future.wait([
                userProfileData.getUserProfile(),
                singleAdsData.getSingleAdBanner(),
                addressData.getAddress(),
              ]),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }
                return Consumer<RefreshNotifier>(builder: (context, data, _) {
                  return RefreshIndicator(
                    color: primaryColor,
                    onRefresh: () async {
                      await data.refresh();
                      if (data.singleAdbannerModel.status == "200") {
                        log("refresh");
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("Refreshed"),
                        //   behavior: SnackBarBehavior.floating,
                        //   backgroundColor: Colors.transparent,
                        //   width: 150,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        // ));
                      } else {
                        log("not refreshed");
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content: Text("Something went wrong"),
                        //   behavior: SnackBarBehavior.floating,
                        //   backgroundColor: Colors.red,
                        //   width: 50,
                        // ));
                      }
                    },
                    child: WillPopScope(
                      onWillPop: (() {
                        pageIndexNotifier.value != 0 ?
                        pageIndexNotifier.value = 0 :
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text('Exit',
                                    style: TextStyle(color: Colors.black)),
                                content:
                                    Text('Do you want to exit from this app?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('No'),
                                  ),
                                  pageIndexNotifier.value != 0
                                      ? TextButton(
                                          onPressed: () {
                                            pageIndexNotifier.value = 0;
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text('Go to home'),
                                        )
                                      : SizedBox(),
                                  TextButton(
                                    onPressed: () async {
                                      SystemNavigator.pop();
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            }));
                        return Future.value(false);
                      }),
                      child: Scaffold(
                        drawer: SafeArea(
                          child: MenuDrawer(),
                        ),
                        body: SafeArea(
                          child: ValueListenableBuilder(
                              valueListenable: HomeView.pageIndexNotifier,
                              builder: (context, index, _) {
                                return IndexedStack(
                                  children: pages,
                                  index: HomeView.pageIndexNotifier.value,
                                );
                              }),
                        ),
                        bottomNavigationBar: BottomNavBar(
                            pageIndexNotifier: HomeView.pageIndexNotifier),
                      ),
                    ),
                  );
                });
              });
        });
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfileData =
        Provider.of<UserProfileNotifier>(context, listen: false);
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 170,
                color: primaryColor,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/images/png/qclogo.png",
                        height: 70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      userProfileData.userProfileModel.data[0].name,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Text(
                      "+91 ${userProfileData.userProfileModel.data[0].phone}",
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              DrawerItem(
                title: "My Cart",
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.of(context).pushNamed("/cartView");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "My Orders",
                  icon: Icons.list_alt,
                  onTap: () {
                    Navigator.of(context).pushNamed("/ordersView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "My Rentals",
                  icon: Icons.timer_rounded,
                  onTap: () {
                    Navigator.of(context).pushNamed("/rentalsView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Photographer bookings",
                  icon: Icons.camera_alt,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed("/photographerBookingsView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Camera repairs",
                  icon: Icons.miscellaneous_services_rounded,
                  onTap: () {
                    Navigator.of(context).pushNamed("/myCameraRepairsView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Wishlist",
                  icon: Icons.favorite,
                  onTap: () {
                    Navigator.of(context).pushNamed("/wishListView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Firmwares",
                  icon: Icons.download,
                  onTap: () {
                    Navigator.of(context).pushNamed("/firmwareDownloadView");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                title: "Address",
                icon: Icons.gps_fixed,
                onTap: () {
                  Navigator.of(context).pushNamed("/addressView");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                title: "Notifications",
                icon: Icons.notifications,
                onTap: () async {
                  // await notificationData.getNotifications();
                  Navigator.of(context).pushNamed("/notificationView");
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Enquire new product not listed",
                  icon: Icons.list_alt,
                  onTap: () {
                    Navigator.of(context).pushNamed("/showEnquireProduct");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Exchange your product",
                  icon: Icons.camera_alt_outlined,
                  onTap: () {
                    Navigator.of(context).pushNamed("/showExchangeProduct");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
              ),
              DrawerItem(
                  title: "Help",
                  icon: Icons.help,
                  onTap: () {
                    Navigator.of(context).pushNamed("/helpPage");
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
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
                          content:
                              Text('Do you want to logout from this account?'),
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
                                LocalStorage localStorage = LocalStorage();
                                await localStorage
                                    .deleteToken()
                                    .whenComplete(() {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      "/mobileAuthView", (route) => false);
                                });
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      }));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.openSans(
            letterSpacing: 2,
            fontSize: 13,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 15),
        leading: Icon(icon, size: 25),
        // onTap: () {
        //   Navigator.of(context).pushNamed("/ordersView");
        // },
        onTap: onTap,
      ),
    );
  }
}
