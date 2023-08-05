import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';
import '../../repository/addReview/addReview.notifier.dart';
import '../../repository/productsDetails/product_details.notifier.dart';
import '../../widgets/view_image.widget.dart';

class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addReviewData =
        Provider.of<AddReviewNotifier>(context, listen: false);
final productData =
        Provider.of<ViewProductNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "All Reviews",
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
      body: Consumer<AddReviewNotifier>(builder: (_, a, child) {
                    return FutureBuilder(
                        future: addReviewData.allReviews(productData.viewProductModel.data[0].id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (addReviewData
                                .allReviewsModel.data.isNotEmpty) {
                              return SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                   
                                   ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: addReviewData
                                                        .allReviewsModel
                                                        .data
                                                        .length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey,
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.person,
                                                        color: Colors.white,
                                                      )),
                                                    ),
                                                    subtitle: Container(
                                                      // margin:
                                                      //     EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // margin:
                                                            //     const EdgeInsets
                                                            //             .only(
                                                            //         left: 10.0),
                                                            child: Text(
                                                              "Rating ",
                                                              style: GoogleFonts.montserrat(
                                                                  fontSize: 14,
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
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  blurRadius:
                                                                      10,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 5),
                                                                ),
                                                              ],
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            // padding:
                                                            //     EdgeInsets.only(
                                                            //         left: 5.0,
                                                            //         right: 5.0),
                                                            // margin:
                                                            //     EdgeInsets.only(
                                                            //         left: 5.0,
                                                            //         right: 5.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.star,
                                                                    size: 10,
                                                                    color: Colors
                                                                        .white),
                                                                Text(
                                                                  " ${addReviewData.allReviewsModel.data[index].rating} ",
                                                                  style: GoogleFonts.montserrat(
                                                                      fontSize:
                                                                          13,
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
                                                    title: Container(
                                                      // margin: EdgeInsets.only(
                                                      //     left: 20.0,
                                                      //     right: 20.0),
                                                      child: Text(
                                                        addReviewData
                                                            .allReviewsModel
                                                            .data[index]
                                                            .name,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    margin: EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0,
                                                        bottom: 5.0),
                                                    child: Text(
                                                      addReviewData
                                                          .allReviewsModel
                                                          .data[index]
                                                          .comment,
                                                      maxLines: 10,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Visibility(
                                                      visible: addReviewData
                                                          .allReviewsModel
                                                          .data[index]
                                                          .images
                                                          .isNotEmpty,
                                                      child: SizedBox(
                                                          height: 150,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: addReviewData
                                                                .allReviewsModel
                                                                .data[index]
                                                                .images
                                                                .length,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    imageIndex) {
                                                              return Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10.0,
                                                                        right:
                                                                            10.0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: addReviewData
                                                                          .allReviewsModel
                                                                          .data[
                                                                              index]
                                                                          .images[
                                                                              imageIndex]
                                                                          .image
                                                                          .toString() ??
                                                                      'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image.png',
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(MaterialPageRoute(builder:
                                                                              ((context) {
                                                                        return ViewImage(
                                                                            imageLink:
                                                                                addReviewData.allReviewsModel.data[index].images[imageIndex].image);
                                                                      })));
                                                                    },
                                                                    child:
                                                                        ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                                                          child: Image(
                                                                                                                                              height:
                                                                            100,
                                                                                                                                              width:
                                                                            100,
                                                                                                                                              fit: BoxFit
                                                                            .cover,
                                                                                                                                              image:
                                                                            imageProvider,
                                                                                                                                            ),
                                                                        ),
                                                                  ),
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Image(
                                                                    height: 100,
                                                                    width: 100,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        'assets/images/png/pholder_image.jpg'),
                                                                  ),
                                                                  errorWidget:
                                                                      (context,
                                                                              url,
                                                                              error) =>
                                                                          Image(
                                                                    height: 100,
                                                                    width: 100,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: AssetImage(
                                                                        'assets/images/png/pholder_image.jpg'),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ))),
                                                  Divider(
                                                    color: Colors.grey,
                                                    thickness: 0.1,
                                                  ),
                                                ],
                                              );
                                            }),
                                  ],
                                ),
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
                        });
                  }),
    );
  }
}