// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';
import 'package:qcamyapp/widgets/view_image.widget.dart';
import 'package:readmore/readmore.dart';

import '../../../repository/rental_booking/rental_booking.notifier.dart';
import '../../../repository/rental_equipment_detail/rental_equi_details.notifier.dart';
import '../../../widgets/quantity_field.widget.dart';
import '../homeTabViews/product_details/product_details.view.dart';

class EquipmentDetailsView extends StatelessWidget {
  const EquipmentDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _rentalEquipmentsData =
    //     Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    final ValueNotifier<int> _quantityNotifier = ValueNotifier(1);
    final _rentalEquipmentDetailsData =
        Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);
    final orderRentalItemData =
        Provider.of<RentalBookingNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Details",
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
          future: _rentalEquipmentDetailsData.getRentalEquipmentDetails(
              id: _rentalEquipmentDetailsData.rentalEquipmentId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _rentalEquipmentDetailsData
                  .selectedImage = _rentalEquipmentDetailsData
                      .rentalEquipmentDetailsModel.image.isNotEmpty
                  ? _rentalEquipmentDetailsData
                      .rentalEquipmentDetailsModel.image[0].image
                  : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";
              return ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ViewImage(
                              imageLink:
                                  _rentalEquipmentDetailsData.selectedImage),
                        ),
                      );
                    },
                    child: Consumer<RentalEquipmentDetailsNotifier>(
                        builder: (context, data, _) {
                      return Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 5,
                          top: 10,
                        ),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _rentalEquipmentDetailsData.selectedImage,
                          placeholder: (context, url) {
                            return Image.asset(
                              "assets/images/png/pholder_image.jpg",
                            );
                          },
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              "assets/images/png/pholder_image.jpg",
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      _rentalEquipmentDetailsData
                          .rentalEquipmentDetailsModel.data[0].name,
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₹${_rentalEquipmentDetailsData.rentalEquipmentDetailsModel.data[0].price}/${_rentalEquipmentDetailsData.rentalEquipmentDetailsModel.data[0].renttype}",
                              style: GoogleFonts.openSans(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              "Stock:${_rentalEquipmentDetailsData.rentalEquipmentDetailsModel.data[0].stock}",
                              style: GoogleFonts.openSans(),
                            ),
                          ],
                        ),
                        QuantityField(quantityNotifier: _quantityNotifier)
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10),
                  //   child: Text(
                  //     "Stock:${_rentalEquipmentDetailsData.rentalEquipmentDetailsModel.data[0].stock}",
                  //     style: GoogleFonts.openSans(),
                  //   ),
                  // ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: _rentalEquipmentDetailsData
                            .rentalEquipmentDetailsModel.image.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _rentalEquipmentDetailsData
                                .rentalEquipmentDetailsModel.image.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  _rentalEquipmentDetailsData
                                      .changeSelectedImage(
                                          _rentalEquipmentDetailsData
                                              .rentalEquipmentDetailsModel
                                              .image[index]
                                              .image);
                                },
                                child: EquipmentImage(
                                    image: _rentalEquipmentDetailsData
                                        .rentalEquipmentDetailsModel
                                        .image[index]
                                        .image),
                              );
                            })
                        : Center(child: Text("no images")),
                  ),
                  EquipmentDetails(
                    title: "Description",
                    details: _rentalEquipmentDetailsData
                        .rentalEquipmentDetailsModel.data[0].descri,
                    // details:
                    //     "NIKON D5600 DSLR Camera Body with Single Lens: AF-P DX Nikkor 18-55 MM F/3.5-5.6G VR  (Black),Memory card, DK-25 Rubber Eyecup, BF-1B Body Cap, EN-EL14a Rechargeable Li-ion Battery (with Terminal Cover), AN-DC3 Strap, MH-24 Battery Charger ",
                  ),
                  EquipmentDetails(
                      title: "Specifications",
                      details: _rentalEquipmentDetailsData
                          .rentalEquipmentDetailsModel.data[0].specifications
                      // details:
                      //     "NIKON D5600 DSLR Camera Body with Single Lens,\nAF-P DX Nikkor 18-55 MM F/3.5-5.6G VR  (Black),\nMemory card, DK-25 Rubber Eyecup,\nBF-1B Body Cap, EN-EL14a Rechargeable Li-ion Battery (with Terminal Cover),\nAN-DC3 Strap, MH-24 Battery Charger",
                      ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BookingButton(
            text: "Book Now",
            onTap: () {
              String availableStock = _rentalEquipmentDetailsData
                  .rentalEquipmentDetailsModel.data[0].stock;
              if (num.parse(availableStock) == 0 ||
                  _quantityNotifier.value > num.parse(availableStock)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    content: Text("No stock available"),
                  ),
                );
              } else {
                orderRentalItemData.qty = _quantityNotifier.value.toString();
                Navigator.pushNamed(context, '/bookEquipmentView');
              }
            },
          ),
        ),
      ),
    );
  }
}

class EquipmentDetails extends StatefulWidget {
  const EquipmentDetails({
    Key? key,
    required this.title,
    required this.details,
  }) : super(key: key);

  final String title;
  final String details;

  @override
  State<EquipmentDetails> createState() => _EquipmentDetailsState();
}

class _EquipmentDetailsState extends State<EquipmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            SizedBox(height: 5),
            ReadMoreText(
              widget.details,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 13,
              ),
              trimLines: 5,
              colorClickableText: primaryColor,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Show less',
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

// class EquipmentImage extends StatelessWidget {
//   const EquipmentImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.network(
//           "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZHNsciUyMGNhbWVyYXxlbnwwfHwwfHw%3D&w=1000&q=80",
//           width: 140,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
