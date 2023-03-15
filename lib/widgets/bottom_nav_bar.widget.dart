// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/styles.dart';

class BottomNavBar extends StatelessWidget {
  final ValueNotifier<int> pageIndexNotifier;
  const BottomNavBar({Key? key, required this.pageIndexNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageIndexNotifier,
        builder: (context, index, _) {
          return Container(
            // padding: const EdgeInsets.only(bottom: 2),
            height: kBottomNavigationBarHeight + 9,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ]),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    // IconButton(
                    //   onPressed: () {
                    //     pageIndexNotifier.value = 0;
                    //   },
                    //   icon: pageIndexNotifier.value == 0
                    //       ? const Icon(
                    //           Icons.search,
                    //           color: primaryColor,
                    //           size: 30,
                    //         )
                    //       : const Icon(
                    //           Icons.search_outlined,
                    //           color: Colors.grey,
                    //           size: 30,
                    //         ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        pageIndexNotifier.value = 0;
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: pageIndexNotifier.value == 0
                            ? Image.asset(
                                "assets/images/png/qcami_icon.png",
                                width: 45,
                                height: 47,
                              )
                            : Image.asset(
                                "assets/images/png/qcami_icon_grey.png",
                                width: 45,
                                height: 47,
                              ),
                      ),
                    ),
                    Text(
                      "Qcamy",
                      style: pageIndexNotifier.value == 0
                          ? selectedNavBarTextStyle
                          : notSelectedNavBarTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndexNotifier.value = 1;
                      },
                      icon: pageIndexNotifier.value == 1
                          ? const Icon(
                              Icons.camera_alt_rounded,
                              color: primaryColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.camera_alt_outlined,
                              color: Color.fromRGBO(158, 158, 158, 1),
                              size: 30,
                            ),
                    ),
                    Text(
                      "Photographer",
                      style: pageIndexNotifier.value == 1
                          ? selectedNavBarTextStyle
                          : notSelectedNavBarTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndexNotifier.value = 2;
                      },
                      icon: pageIndexNotifier.value == 2
                          ? const Icon(
                              Icons.miscellaneous_services_rounded,
                              color: primaryColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.miscellaneous_services_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                    ),
                    Text(
                      "Camera Repair",
                      style: pageIndexNotifier.value == 2
                          ? selectedNavBarTextStyle
                          : notSelectedNavBarTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndexNotifier.value = 3;
                      },
                      icon: pageIndexNotifier.value == 3
                          ? const Icon(
                              Icons.shopify_rounded,
                              color: primaryColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.shopify_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                    ),
                    Text(
                      "Rental Shops",
                      style: pageIndexNotifier.value == 3
                          ? selectedNavBarTextStyle
                          : notSelectedNavBarTextStyle,
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        pageIndexNotifier.value = 4;
                      },
                      icon: pageIndexNotifier.value == 4
                          ? const Icon(
                              Icons.person_rounded,
                              color: primaryColor,
                              size: 30,
                            )
                          : const Icon(
                              Icons.person_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                    ),
                    Text(
                      "Profile",
                      style: pageIndexNotifier.value == 4
                          ? selectedNavBarTextStyle
                          : notSelectedNavBarTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
