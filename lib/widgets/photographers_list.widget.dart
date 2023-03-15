// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PhotographersList extends StatelessWidget {
  final String name;
  final Function()? onTap;
  final String? image;
  final String location;
  const PhotographersList({
    Key? key,
    required this.name,
    this.onTap,
    this.image,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.white,
              // borderRadius: const BorderRadius.all(
              //   Radius.circular(10),
              // ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withOpacity(0.1),
              //     blurRadius: 5,
              //     spreadRadius: 2,
              //   ),
              // ],
              ),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        imageUrl: image ??
                            "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg",
                        placeholder: (context, url) {
                          return Image.network(
                              "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg");
                        },
                        errorWidget: (context, url, error) {
                          return Image.network(
                              "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg");
                        },
                      )),
                  // NetworkImage(
                  //     image ??
                  //         "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg",
                  //   ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.readexPro(
                            color: Colors.black, fontSize: 15),
                      ),
                      Text(
                        location,
                        style:
                            GoogleFonts.outfit(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              // MaterialButton(
              //   elevation: 0,
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       side: const BorderSide(color: primaryColor, width: 2)),
              //   onPressed: onTap,
              //   child: const Text(
              //     "View",
              //     style: TextStyle(letterSpacing: 2),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
