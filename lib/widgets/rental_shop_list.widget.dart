import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyapp/config/colors.dart';

class RentalShopsList extends StatelessWidget {
  final String shopName;
  final String? mobileNumber;
  final String? image;
  final String? location;
  final Function()? onTap;
  const RentalShopsList({
    Key? key,
    required this.shopName,
    required this.mobileNumber,
    this.image,
    this.location,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        // padding:
        //     const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CachedNetworkImage(
                    imageUrl: image ??
                        "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
                    placeholder: (context, url) {
                      return Image.network(
                          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                    },
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) {
                      return Image.network(
                          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg");
                    },
                  ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        location ?? "",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        mobileNumber ?? "Contact number not available",
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
