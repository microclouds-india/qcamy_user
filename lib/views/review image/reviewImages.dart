import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';
import '../../repository/addReview/addReview.notifier.dart';
import '../../repository/image picker/imagePicker.dart';
import '../../repository/productsDetails/product_details.notifier.dart';
import '../home/homeTabViews/product_details/product_details.view.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _reviewController = TextEditingController();

    final productData =
        Provider.of<ViewProductNotifier>(context, listen: false);
    productData.isDataLoaded = false;
    final addReviewData =
        Provider.of<AddReviewNotifier>(context, listen: false);
    final imageProvider =
        Provider.of<ImageProviderModel>(context, listen: false);

    final productDetailsData =
        Provider.of<ViewProductNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Review Product",
          style: GoogleFonts.openSans(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/offerProductDetailsView');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 120,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: productData.selectedImage,
                      placeholder: (context, url) {
                        return Image.asset(
                          "assets/images/png/pholder_image.jpg",
                        );
                      },
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                            "assets/images/png/pholder_image.jpg");
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productData.viewProductModel.data[0].productName
                                  .toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              productData.viewProductModel.data[0].description,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 35,
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
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Review",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  TextButton.icon(
                      onPressed: () {
                        showPicImagePopup(context, () async {
                          imageProvider
                              .pickImagesFromCamera(ImageSource.camera);
                          Navigator.pop(context);
                          print(imageProvider.imagespicked);
                        }, () {
                          imageProvider
                              .pickImagesFromCamera(ImageSource.gallery);
                          Navigator.pop(context);
                          print(imageProvider.imagespicked);
                        });
                      },
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: primaryColor,
                      ),
                      label: Text(
                        'Upload Photo',
                        style: TextStyle(color: primaryColor),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
              child: TextField(
                maxLines: 4,
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText:
                      "How is the product?What do you like? What do you hate?",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: primaryColor),
                  ),
                ),
              ),
            ),
            Consumer<AddReviewNotifier>(builder: (context, data, _) {
              return data.isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(color: primaryColor),
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
                              print(
                                  'ppppppppppppppppppppppp${productData.viewProductModel.data[0].id}');
                              await data.addReviewData(
                                id: productData.viewProductModel.data[0].id,
                                images: imageProvider.imagespicked,
                                rating: addReviewData.ratingValue,
                                comment: _reviewController.text,
                              );
                            } on Exception {
                              addReviewData.loading(true);
                              _reviewController.clear();
                              setState(() {
                                imageProvider.imagespicked.clear();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "Something went wrong. Please try again later."),
                                ),
                              );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text("Submitted"),
                              // ));
                              // showSuccess(context);
                              // _reviewController.clear();
                            } catch (e) {
                              addReviewData.loading(true);
                              _reviewController.clear();
                              setState(() {
                                imageProvider.imagespicked.clear();
                              });
                              Navigator.of(context).pop(true);
                             WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => addReviewData.allReviews(
                                      productData.viewProductModel.data[0].id));
                              addReviewData.loading(false);

                              showSuccess(context);
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text("Submitted"),
                              // ));
                              // showSuccess(context);
                              // _reviewController.clear();
                              // print(e);
                            }

                            try {
                              if (data.addReviewNetworking
                                      .addReviewStatusCode ==
                                  "200") {
                                addReviewData.loading(true);
                                _reviewController.clear();
                                addReviewData.loading(false);
                                setState(() {
                                  imageProvider.imagespicked.clear();
                                }); 
                                Navigator.of(context).pop(true);
                                 WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => addReviewData.allReviews(
                                      productData.viewProductModel.data[0].id));
                                showSuccess(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "Something went wrong. Please try again later."),
                                  ),
                                );
                              }
                            } catch (_) {
                              addReviewData.loading(true);
                              _reviewController.clear();
                              addReviewData.loading(false);
                              setState(() {
                                imageProvider.imagespicked.clear();
                              });
                              
                              Navigator.of(context).pop(true);
                               WidgetsBinding.instance.addPostFrameCallback(
                                  (_) => addReviewData.allReviews(
                                      productData.viewProductModel.data[0].id));
                              showSuccess(context);
                            }
                          } else {
                            print(imageProvider.imagespicked.length);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                content: Text("Fill all fields to submit"),
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
            Consumer<ImageProviderModel>(
              builder: (context, imageProvider, child) {
                List<File> pickedImages = imageProvider.getImages();
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pickedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Image.file(
                              pickedImages[index],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    pickedImages.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
