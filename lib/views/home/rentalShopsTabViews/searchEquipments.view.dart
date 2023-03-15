// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';

import '../../../repository/rental_equipment_detail/rental_equi_details.notifier.dart';
import '../../../repository/rental_equipments/rental_equipments.notifier.dart';

class SearchEquipmentsView extends StatelessWidget {
  const SearchEquipmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _rentalEquipmentsData = Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    final _rentalEquipmentDetailsData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Equipments",
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/searchEquipment');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _rentalEquipmentsData.getRentalEquipments(id: _rentalEquipmentsData.rentalShopId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }
            if (snapshot.hasData) {
              if (_rentalEquipmentsData.rentalEquipmentModel.status == "200") {
                return GridView.builder(
                    itemCount:
                        _rentalEquipmentsData.rentalEquipmentModel.data!.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250, crossAxisCount: 2),
                    itemBuilder: ((context, index) {
                      return EquipmentsList(
                        name: _rentalEquipmentsData
                            .rentalEquipmentModel.data![index].name,
                        rentType: _rentalEquipmentsData
                            .rentalEquipmentModel.data![index].renttype,
                        price: _rentalEquipmentsData
                            .rentalEquipmentModel.data![index].price,
                        image: _rentalEquipmentsData
                            .rentalEquipmentModel.data![index].image,
                        onTap: () {
                          _rentalEquipmentDetailsData.rentalEquipmentId =
                              _rentalEquipmentsData
                                  .rentalEquipmentModel.data![index].id;

                          Navigator.pushNamed(context, '/equipmentDetailsView');
                        },
                      );
                    }));
              } else {
                return Center(
                  child: Text("No Equipments"),
                );
              }
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

class EquipmentsList extends StatelessWidget {
  const EquipmentsList({
    Key? key,
    required this.name,
    required this.price,
    required this.rentType,
    this.onTap,
    required this.image,
  }) : super(key: key);

  final String name;
  final String price;
  final String rentType;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: image.isNotEmpty
                //     ? Image.network(
                //         "https://cashbes.com/photography/$image",
                //         fit: BoxFit.fill,
                //         errorBuilder: ((context, error, stackTrace) {
                //           return Image.asset(
                //               "assets/images/png/pholder_image.jpg");
                //         }),
                //       )
                //     : Image.asset("assets/images/png/pholder_image.jpg"),
                child: CachedNetworkImage(
                  imageUrl: image.isNotEmpty
                      ? "https://cashbes.com/photography/$image"
                      : noImage,
                  fit: BoxFit.fill,
                  errorWidget: ((context, url, error) {
                    return Image.asset(
                      "assets/images/png/pholder_image.jpg",
                      fit: BoxFit.fill,
                    );
                  }),
                  placeholder: (context, url) {
                    return Image.asset(
                      "assets/images/png/pholder_image.jpg",
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              name,
              style: GoogleFonts.montserrat(
                  fontSize: 16, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            Text(
              "₹$price/$rentType",
              style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
