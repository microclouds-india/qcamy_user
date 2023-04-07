// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';
import 'package:qcamyapp/repository/addReview/addReview.notifier.dart';
import 'package:qcamyapp/repository/buy_now/buy_now.notifier.dart';
import 'package:qcamyapp/repository/cart/cart.notifier.dart';
import 'package:qcamyapp/repository/hot_products/hot_products.notifier.dart';
import 'package:qcamyapp/repository/productsDetails/product_details.notifier.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.notifier.dart';
import 'package:qcamyapp/repository/specifications/specifications.notifier.dart';
import 'package:qcamyapp/repository/together_product/together_product.notifier.dart';
import 'package:qcamyapp/repository/together_product/together_products.networking.dart';
import 'package:qcamyapp/repository/wish_list/wish_list.notifier.dart';
import 'package:qcamyapp/repository/wishlist_items_showing/wishlist_item_showing.notifier.dart';
import 'package:qcamyapp/widgets/quantity_field.widget.dart';
import 'package:qcamyapp/widgets/view_image.widget.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import '../../../../repository/related_products/related_products.notifier.dart';

class OfferProductDetailsView extends StatelessWidget {
  OfferProductDetailsView({Key? key}) : super(key: key);

  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> _quantityNotifier = ValueNotifier(1);
    final productData = Provider.of<ViewProductNotifier>(context, listen: false);
    productData.isDataLoaded =
        false; //set product data loaded to false to show/hide bottom appbar
    final cartData = Provider.of<CartNotifier>(context, listen: false);
    final orderNowData = Provider.of<OrderNotifier>(context, listen: false);
    final productCategoryData =
        Provider.of<AccessoriesNotifier>(context, listen: false);
    final relatedProductsData =
        Provider.of<RelatedProductsNotifier>(context, listen: false);
    final togetherProductsData =
        Provider.of<TogetherProductsNotifier>(context, listen: false);
    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
    final removeWishListData =
        Provider.of<RemoveWishListNotifier>(context, listen: false);
    final specificationsData =
        Provider.of<SpecificationsNotifier>(context, listen: false);
    final addReviewData = Provider.of<AddReviewNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Details",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
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
      body: Stack(
        children: [
          FutureBuilder(
              future: productData.getProductDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  productData.selectedImage = productData
                          .viewProductModel.image.isNotEmpty
                      ? productData.viewProductModel.image[0].image
                      : "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";
                  return ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ViewImage(
                                  imageLink: productData.selectedImage),
                            ),
                          );
                        },
                        child: Consumer<ViewProductNotifier>(
                            builder: (context, data, _) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 2.5,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: productData.selectedImage,
                                  placeholder: (context, url) {
                                    return Image.asset(
                                      "assets/images/png/pholder_image.jpg",
                                    );
                                  },
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) {
                                    return Image.asset(
                                        "assets/images/png/pholder_image.jpg");
                                  },
                                ),
                                Consumer<WishListNotifier>(
                                    builder: (context, data, _) {
                                  return GestureDetector(
                                    onTap: () async {
                                      print(productData
                                          .viewProductModel.data[0].wishlist_id
                                          .toString());
                                      if (productData.viewProductModel.data[0]
                                              .wishlist_id ==
                                          "0") {
                                        wishListData.changeColors(int.parse(
                                            productData
                                                .viewProductModel.data[0].id));
                                        await wishListData.addToWishList(
                                          productId: productData
                                              .viewProductModel.data[0].id,
                                        );
                                        if (wishListData
                                                .addToWishListModel.status ==
                                            "200") {
                                          productData.getProductDetails();
                                          Fluttertoast.showToast(
                                              msg: "Added to wishlist",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        }
                                      } else if (productData.viewProductModel
                                              .data[0].wishlist_id !=
                                          "0") {
                                        wishListData.changeColors(int.parse(
                                            productData
                                                .viewProductModel.data[0].id));
                                        await removeWishListData.removeWishList(
                                          productId: productData
                                              .viewProductModel
                                              .data[0]
                                              .wishlist_id,
                                        );
                                        if (removeWishListData
                                                .removeWishlistModel.status ==
                                            "200") {
                                          productData.getProductDetails();
                                          Fluttertoast.showToast(
                                              msg: "Removed from wishlist",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              textColor: Colors.white,
                                              fontSize: 14.0);
                                        }
                                      }
                                      // if(!wishListData.wishListedItems.contains(int.parse(productData.productId))){
                                      //   wishListData.changeColors(int.parse(productData.productId));
                                      //   await wishListData.addToWishList(productId: productData.productId,);
                                      //   if (wishListData.addToWishListModel.status == "200") {
                                      //     Fluttertoast.showToast(
                                      //         msg: "Added to wishlist",
                                      //         toastLength: Toast.LENGTH_SHORT,
                                      //         gravity: ToastGravity.BOTTOM,
                                      //         timeInSecForIosWeb: 1,
                                      //         textColor: Colors.white,
                                      //         fontSize: 14.0);
                                      //   }
                                      // }else if(wishListData.wishListedItems.contains(int.parse(productData.productId))){
                                      //   wishListData.changeColors(int.parse(productData.productId));
                                      //   await removeWishListData.removeWishList(
                                      //     productId: productData.viewProductModel.data[0].wishlist_id,
                                      //   );
                                      //   if (removeWishListData.removeWishlistModel.status == "200") {
                                      //     Fluttertoast.showToast(
                                      //         msg: "Removed from wishlist",
                                      //         toastLength: Toast.LENGTH_SHORT,
                                      //         gravity: ToastGravity.BOTTOM,
                                      //         timeInSecForIosWeb: 1,
                                      //         textColor: Colors.white,
                                      //         fontSize: 14.0);
                                      //   }
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      padding: EdgeInsets.only(right: 5),
                                      child: productData.viewProductModel
                                                  .data[0].wishlist_id !=
                                              "0"
                                          ? Icon(Icons.favorite,
                                              color: primaryColor)
                                          : Icon(Icons.favorite_border),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        }),
                      ),
                      // SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          productData.viewProductModel.data[0].productName
                              .toString(),
                          style: GoogleFonts.montserrat(fontSize: 16),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: productData.viewProductModel.data[0]
                                              .offerPer ==
                                          ""
                                      ? false
                                      : true,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 5,
                                            top: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          "Special offer",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 5,
                                            top: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          "${productData.viewProductModel.data[0].offerPer}% off",
                                          style: GoogleFonts.openSans(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Inclusive of all taxes (${productData.viewProductModel.data[0].taxPer}%)",
                                  style: GoogleFonts.openSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      productData.viewProductModel.data[0]
                                                  .offerPer ==
                                              ""
                                          ? "₹${productData.viewProductModel.data[0].price}"
                                          : "₹${productData.viewProductModel.data[0].price}",
                                      style: GoogleFonts.openSans(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    Visibility(
                                      visible: productData.viewProductModel
                                                  .data[0].offerPer ==
                                              ""
                                          ? false
                                          : true,
                                      child: Row(
                                        children: [
                                          Text(
                                            "MRP:",
                                            style: GoogleFonts.openSans(
                                              decorationColor: Colors.black,
                                              decorationThickness: 2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            "₹${productData.viewProductModel.data[0].cutPrice}",
                                            style: GoogleFonts.openSans(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                              decorationColor: Colors.black,
                                              decorationThickness: 2,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   "${productData.viewProductModel.data[0].taxPer}% Tax",
                                    //   style: GoogleFonts.openSans(
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   "SGST-${productData.viewProductModel.data[0].sgst}",
                                    //   style: GoogleFonts.openSans(
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                    // Text(
                                    //   "CGST-${productData.viewProductModel.data[0].cgst}",
                                    //   style: GoogleFonts.openSans(
                                    //     fontSize: 16,
                                    //     fontWeight: FontWeight.w600,
                                    //     color: Colors.grey,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Text(
                                  productData.viewProductModel.data[0].stock ==
                                          ""
                                      ? "Out of stock"
                                      : "In stock",
                                  style: GoogleFonts.openSans(),
                                ),
                              ],
                            ),
                          ),
                          QuantityField(quantityNotifier: _quantityNotifier)
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: productData.viewProductModel.image.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    productData.viewProductModel.image.length,
                                itemBuilder: (context, index) {
                                  if (productData.viewProductModel.image[index]
                                          .format ==
                                      "image") {
                                    return GestureDetector(
                                      onTap: () {
                                        productData.changeSelectedImage(
                                            productData.viewProductModel
                                                .image[index].image);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: EquipmentImage(
                                            image: productData.viewProductModel
                                                .image[index].image),
                                      ),
                                    );
                                  }
                                  //to show video
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => VideoPlayerScreen(
                                          videoLink: productData
                                              .viewProductModel
                                              .image[index]
                                              .image,
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      width: 150,
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                      ),
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            productData.viewProductModel
                                                .image[0].image,
                                            fit: BoxFit.cover,
                                            width: 150,
                                            height: 150,
                                          ),
                                          Center(
                                            child: Icon(
                                              Icons.play_circle,
                                              size: 50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : SizedBox(),
                      ),
                      EquipmentDetails(
                        title: "Description",
                        details: productData
                            .viewProductModel.data[0].description
                            .toString(),
                        // details:
                        //     "NIKON D5600 DSLR Camera Body with Single Lens: AF-P DX Nikkor 18-55 MM F/3.5-5.6G VR  (Black),Memory card, DK-25 Rubber Eyecup, BF-1B Body Cap, EN-EL14a Rechargeable Li-ion Battery (with Terminal Cover), AN-DC3 Strap, MH-24 Battery Charger ",
                      ),
                      if (productData.viewProductModel.data[0].traderName != "")
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            children: [
                              Text(
                                "Sold by ",
                                style: TextStyle(),
                              ),
                              Text(
                                "${productData.viewProductModel.data[0].traderName.toString()}",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                " and fullfilled by",
                                style: TextStyle(),
                              ),
                              Text(
                                " Qcamy",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      FutureBuilder(
                        future: specificationsData
                            .getSpecifications(productData.productId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return specificationsData
                                    .specificationsModel.data.isNotEmpty
                                ? Card(
                                    margin: EdgeInsets.all(10),
                                    elevation: 0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "specifications",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          SizedBox(height: 5),
                                          ListView.builder(
                                            itemCount: specificationsData
                                                .specificationsModel
                                                .data
                                                .length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        specificationsData
                                                            .specificationsModel
                                                            .data[index]
                                                            .specCat),
                                                  ),
                                                  Expanded(
                                                    child: Text(specificationsData
                                                            .specificationsModel
                                                            .data[index]
                                                            .catValue +
                                                        " " +
                                                        specificationsData
                                                            .specificationsModel
                                                            .data[index]
                                                            .measure),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(child: Text("No items"));
                          } else {
                            return Center(
                              child: SizedBox(
                                width: 40,
                                child: const CircularProgressIndicator(
                                    color: primaryColor),
                              ),
                            );
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Add Review",
                          style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          addReviewData.ratingValue = rating.toString();
                          print(rating);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _reviewController,
                          decoration: const InputDecoration(
                            hintText: "Add Review...",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Consumer<AddReviewNotifier>(builder: (context, data, _) {
                        return data.isLoading
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: CircularProgressIndicator(
                                      color: primaryColor),
                                ),
                              )
                            : Center(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: primaryColor),
                                  onPressed: () async {
                                    if (_reviewController.text.isNotEmpty &&
                                        addReviewData.ratingValue != "") {
                                      try {
                                        await data.addReviewData(
                                          rating: addReviewData.ratingValue,
                                          comment: _reviewController.text,
                                        );
                                      } on Exception {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Submitted"),
                                        ));
                                        showSuccess(context);
                                        _reviewController.clear();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Submitted"),
                                        ));
                                        showSuccess(context);
                                        _reviewController.clear();
                                      }

                                      try {
                                        if (data.addReviewModel.status ==
                                            "200") {
                                          showSuccess(context);
                                          _reviewController.clear();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Something went wrong. Please try again later."),
                                            ),
                                          );
                                        }
                                      } catch (_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "Something went wrong. Please try again later."),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.red,
                                          content:
                                              Text("Fill all fields to submit"),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Submit",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              );
                      }),
                      FutureBuilder(
                          future: addReviewData.allReviews(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (addReviewData
                                  .allReviewsModel.data.isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "All Reviews",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: addReviewData
                                              .allReviewsModel.data.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets.only(left: 10.0),
                                                        child: Text(
                                                          "Rating ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                blurRadius: 10,
                                                                offset:
                                                                    const Offset(
                                                                        0, 5)),
                                                          ],
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.star, size: 10, color: Colors.white),
                                                            Text(
                                                              " ${addReviewData.allReviewsModel.data[index].rating} ",
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                      fontSize: 13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                                  child: Text(
                                                    addReviewData.allReviewsModel.data[index].comment,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                                                  child: Text(
                                                    addReviewData.allReviewsModel.data[index].name,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            } else if (snapshot.hasError) {
                              return SizedBox();
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          }),
                      FutureBuilder(
                          future: relatedProductsData.getRelatedProducts(
                              categoryId: productCategoryData.categoryId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (relatedProductsData
                                  .relatedProductsModel.data.isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Similar Products",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: relatedProductsData
                                              .relatedProductsModel.data.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                productData.productId =
                                                    relatedProductsData
                                                        .relatedProductsModel
                                                        .data[index]
                                                        .id;
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        "/offerProductDetailsView");
                                              },
                                              child: SimilarProducts(
                                                image: relatedProductsData
                                                    .relatedProductsModel
                                                    .data[index]
                                                    .image,
                                                name: relatedProductsData
                                                    .relatedProductsModel
                                                    .data[index]
                                                    .productName,
                                                price: relatedProductsData
                                                    .relatedProductsModel
                                                    .data[index]
                                                    .price,
                                                cutPrice: relatedProductsData
                                                    .relatedProductsModel
                                                    .data[index]
                                                    .cutPrice,
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            } else if (snapshot.hasError) {
                              return SizedBox();
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          }),
                      FutureBuilder(
                          future: togetherProductsData.getTogetherProducts(
                              product_id:
                                  productData.viewProductModel.data[0].id,
                              together: productData
                                  .viewProductModel.data[0].together),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (togetherProductsData
                                  .togetherProductsModel.data.isNotEmpty) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Bought Together",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: togetherProductsData
                                              .togetherProductsModel
                                              .data
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    productData.productId =
                                                        togetherProductsData
                                                            .togetherProductsModel
                                                            .data[index]
                                                            .id;
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            "/offerProductDetailsView");
                                                  },
                                                  child: SimilarProducts(
                                                    image: togetherProductsData
                                                        .togetherProductsModel
                                                        .data[index]
                                                        .image,
                                                    name: togetherProductsData
                                                        .togetherProductsModel
                                                        .data[index]
                                                        .productName,
                                                    price: togetherProductsData
                                                        .togetherProductsModel
                                                        .data[index]
                                                        .price,
                                                    cutPrice: togetherProductsData
                                                        .togetherProductsModel
                                                        .data[index]
                                                        .cutPrice,
                                                  ),
                                                ),
                                                // relatedProductsData.relatedProductsModel.data.length-1 == index ?
                                                // Container() :
                                                Center(
                                                  child: Icon(Icons.add,
                                                      color: Colors.black),
                                                ),
                                                togetherProductsData
                                                                .togetherProductsModel
                                                                .data
                                                                .length -
                                                            1 ==
                                                        index
                                                    ? Container(
                                                        child: MaterialButton(
                                                          height:
                                                              kBottomNavigationBarHeight -
                                                                  5,
                                                          child: Text(
                                                            "Buy now",
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                          ),
                                                          onPressed: () async {
                                                            await cartData
                                                                .addToCartWithTogether(
                                                              productId: productData
                                                                  .viewProductModel
                                                                  .data[0]
                                                                  .id,
                                                              together: togetherProductsData
                                                                  .togetherProductsModel
                                                                  .together
                                                                  .toString(),
                                                            );
                                                            if (cartData
                                                                    .addToCartModel
                                                                    .status ==
                                                                "200") {
                                                              await cartData
                                                                  .getCartCount();
                                                              // ScaffoldMessenger.of(context).showSnackBar(
                                                              //     SnackBar(content: Text("Added to cart")));
                                                              // Navigator.of(context).pushNamed("/cartView");
                                                              orderNowData
                                                                      .isBuyingSingleItem =
                                                                  false;
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      "/cartView");
                                                            } else if (cartData
                                                                    .addToCartModel
                                                                    .status ==
                                                                "400") {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  content: Text(cartData
                                                                      .addToCartModel
                                                                      .response),
                                                                ),
                                                              );
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(
                                                                          context)
                                                                  .showSnackBar(SnackBar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      content: Text(
                                                                          "Something went wrong")));
                                                            }
                                                          },
                                                          color: Colors.black,
                                                        ),
                                                        margin: EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                      )
                                                    : Container(),
                                              ],
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox();
                              }
                            } else if (snapshot.hasError) {
                              return SizedBox();
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                  color: primaryColor),
                            );
                          }),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }),
          Center(
            child: Consumer<CartNotifier>(builder: (context, data, _) {
              return Visibility(
                visible: data.isAddingToCart,
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }),
          )
        ],
      ),
      bottomNavigationBar:
          Consumer<ViewProductNotifier>(builder: (context, data, _) {
        if (!data.isDataLoaded) {
          return SizedBox();
        }
        return Visibility(
          //if out of stock,hide add to cart and buy now option
          visible:
              productData.viewProductModel.data[0].stock == "" ? false : true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: MaterialButton(
                  height: kBottomNavigationBarHeight - 5,
                  child: Text(
                    "Add to cart",
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    await cartData.addToCart(
                      productId: productData.viewProductModel.data[0].id,
                      qty: _quantityNotifier.value.toString(),
                      // price: productData.viewProductModel.data[0].offerPer == ""
                      //     ? productData.viewProductModel.data[0].price
                      //         .toString()
                      //     : productData.viewProductModel.data[0].cutPrice
                      //         .toString(),
                      price: productData.viewProductModel.data[0].price,
                      // cutPrice:
                      //     productData.viewProductModel.data[0].offerPer == ""
                      //         ? ""
                      //         : productData.viewProductModel.data[0].price
                      //             .toString(),
                      cutPrice: productData.viewProductModel.data[0].cutPrice,
                      // offerPercentage:
                      //     productData.viewProductModel.data[0].offerPer == ""
                      //         ? ""
                      //         : productData.viewProductModel.data[0].offerPer
                      //             .toString(),
                      offerPercentage:
                          productData.viewProductModel.data[0].offerPer,
                    );
                    if (cartData.addToCartModel.status == "200") {
                      HapticFeedback.vibrate();

                      await cartData.getCartCount();
                      orderNowData.isBuyingSingleItem = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to cart")));
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return Dialog(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Success",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          // fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Item successfuly added to cart",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      MaterialButton(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ),
                                      MaterialButton(
                                        elevation: 0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          FocusScope.of(context).unfocus();
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .pushNamed("/cartView");
                                        },
                                        child: Text(
                                          "Go to My Cart",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: secondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                    } else if (cartData.addToCartModel.status == "400") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(cartData.addToCartModel.response),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Something went wrong")));
                    }
                  },
                ),
              ),
              Expanded(
                child: MaterialButton(
                  height: kBottomNavigationBarHeight - 5,
                  child: Text(
                    "Buy now",
                    style: GoogleFonts.openSans(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    await cartData.addToCart(
                      productId: productData.viewProductModel.data[0].id,
                      qty: _quantityNotifier.value.toString(),
                      // price: productData.viewProductModel.data[0].offerPer == ""
                      //     ? productData.viewProductModel.data[0].price
                      //         .toString()
                      //     : productData.viewProductModel.data[0].cutPrice
                      //         .toString(),
                      price: productData.viewProductModel.data[0].price,
                      // cutPrice:
                      //     productData.viewProductModel.data[0].offerPer == ""
                      //         ? ""
                      //         : productData.viewProductModel.data[0].price
                      //             .toString(),
                      cutPrice: productData.viewProductModel.data[0].cutPrice,
                      // offerPercentage:
                      //     productData.viewProductModel.data[0].offerPer == ""
                      //         ? ""
                      //         : productData.viewProductModel.data[0].offerPer
                      //             .toString(),
                      offerPercentage:
                          productData.viewProductModel.data[0].offerPer,
                    );
                    if (cartData.addToCartModel.status == "200") {
                      await cartData.getCartCount();
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text("Added to cart")));
                      // Navigator.of(context).pushNamed("/cartView");
                      orderNowData.isBuyingSingleItem = true;
                      Navigator.of(context)
                          .pushNamed("/singleItemPurchaseDetailsView");
                    } else if (cartData.addToCartModel.status == "400") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(cartData.addToCartModel.response),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("Something went wrong")));
                    }
                  },
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<dynamic> showSuccess(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Success",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({
    Key? key,
    required this.image,
    required this.price,
    required this.cutPrice,
    required this.name,
  }) : super(key: key);

  final String image;
  final String name;
  final String price;
  final String cutPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                image.isNotEmpty
                    ? "https://cashbes.com/photography/$image"
                    : noImage,
                height: 80,
                width: 80,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    noImage,
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
          Column(
            children: [
              Text(
                "₹$price",
                style: GoogleFonts.openSans(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "₹$cutPrice",
                style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
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
                color: Colors.grey.shade800,
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

class EquipmentImage extends StatelessWidget {
  const EquipmentImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: ((context) => ViewImage(imageLink: image))));
      // },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(10),
        // margin: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.fill,
            width: 120,
            placeholder: (context, url) {
              return Image.asset(
                "assets/images/png/pholder_image.jpg",
                fit: BoxFit.fill,
                width: 120,
              );
            },
          ),
        ),
      ),
    );
  }
}

//to play product video
class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key, required this.videoLink})
      : super(key: key);

  final String videoLink;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initVideoPlayerFuture;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoLink);
    _initVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1);
    _videoPlayerController.play();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox.expand(
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController))));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        });
  }
}
