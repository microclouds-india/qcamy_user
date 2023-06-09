// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

import '../../repository/cart/cart.notifier.dart';
import '../../repository/singleAdBanner/singleAdBanner.notifier.dart';

class RentalShopsTabView extends StatelessWidget {
  const RentalShopsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final singleAdBannerData =
        Provider.of<SingleAdBannerNotifier>(context, listen: false);
    final cartData = Provider.of<CartNotifier>(context, listen: false);
    return Scaffold(
        // backgroundColor: mainBgColor,
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
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
                              return badges.Badge(
                                badgeContent: Text(
                                  cartData.cartCountModel.count.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                badgeStyle: badges.BadgeStyle(badgeColor: primaryColor,),
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
                            icon: badges.Badge(
                              badgeContent: Text(
                                '0',
                                style: TextStyle(color: Colors.white),
                              ),
                              badgeStyle: badges.BadgeStyle(badgeColor: primaryColor,),
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

            //search field
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SearchFieldWidget(
                hintText: "Search for rental shops",
                readOnly: true,
                autofocus: false,
                onTap: () {
                  Navigator.pushNamed(context, '/searchRentalShopView');
                },
              ),
            ),
            //single ad banner
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://cashbes.com/photography/${singleAdBannerData.singleAdbannerModel.image5}",
                ),
              ),
            ),
            //main text
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
              child: Text(
                "Find the best cameras and equipments for rent",
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            //sub text
            Text(
              "Best and affordable",
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            //button to show all rental shops
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/showAllRentalShopsView');
              },
              child: Container(
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "EXPLORE RENTAL SHOPS",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    Image.asset(
                      'assets/images/png/camera_icon.png',
                    ),
                  ],
                ),
              ),
            ),
            //single ad banner
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.network(
                    "https://cashbes.com/photography/${singleAdBannerData.singleAdbannerModel.image3}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
