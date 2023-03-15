// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.notifier.dart';

import '../../../../repository/productsDetails/product_details.notifier.dart';
import '../../../../repository/wish_list/wish_list.notifier.dart';

class AccessoriesView extends StatelessWidget {
  const AccessoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accessoriesData = Provider.of<AccessoriesNotifier>(context);

    final productData = Provider.of<ViewProductNotifier>(context, listen: false);
    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
    final removeWishListData = Provider.of<RemoveWishListNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          accessoriesData.categoryName,
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
      body: FutureBuilder(
          future: accessoriesData.getAccessories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return accessoriesData.accessoriesModel.data.isNotEmpty
                  ? GridView.builder(
                      itemCount: accessoriesData.accessoriesModel.data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250, crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        return Consumer<AccessoriesNotifier>(
                            builder: (context, data, _) {
                          return CategoryItemList(
                            // icon: wishListData.wishListedItems.contains(int.parse(accessoriesData.accessoriesModel.data[index].id))
                            icon: accessoriesData.accessoriesModel.data[index].wishlist_id != "0"
                                ? Icon(Icons.favorite, color: primaryColor)
                                : Icon(Icons.favorite_border),
                            image: accessoriesData
                                .accessoriesModel.data[index].image
                                .toString(),
                            name: accessoriesData
                                .accessoriesModel.data[index].productName,
                            price: accessoriesData
                                .accessoriesModel.data[index].price,
                            discount: accessoriesData.accessoriesModel
                                .data[index].discountPercentage,
                            onTap: () {
                              productData.productId = accessoriesData
                                  .accessoriesModel.data[index].id;
                              Navigator.of(context)
                                  .pushNamed("/offerProductDetailsView");
                            },
                            addToWishList: () async {
                              if (accessoriesData.accessoriesModel.data[index].wishlist_id == "0") {
                                wishListData.changeColors(int.parse(accessoriesData.accessoriesModel.data[index].id));
                                await wishListData.addToWishList(productId: accessoriesData.accessoriesModel.data[index].id,
                                );
                                if (wishListData.addToWishListModel.status == "200") {
                                  accessoriesData.getAccessories();
                                  Fluttertoast.showToast(
                                      msg: "Added to wishlist",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }
                              } else if (accessoriesData.accessoriesModel.data[index].wishlist_id != "0") {
                                wishListData.changeColors(int.parse(accessoriesData.accessoriesModel.data[index].id));
                                await removeWishListData.removeWishList(
                                  productId: accessoriesData.accessoriesModel.data[index].wishlist_id,
                                );
                                if (removeWishListData.removeWishlistModel.status == "200") {
                                  accessoriesData.getAccessories();
                                  Fluttertoast.showToast(
                                      msg: "Removed from wishlist",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }
                              }
                            },
                          );
                        });
                      }))
                  : Center(child: Text("No items"));
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }
            return Center(
                child: CircularProgressIndicator(color: primaryColor));
          }),
    );
  }
}

// class EquipmentsList extends StatelessWidget {
//   final String name;
//   final String price;
//   final String image;
//   final String discount;
//   final Function()? onTap;
//   const EquipmentsList({
//     Key? key,
//     required this.name,
//     required this.price,
//     this.onTap,
//     required this.image,
//     required this.discount,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(10),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             discount != ""
//                 ? Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.only(right: 80),
//                     padding:
//                         EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
//                     decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(50)),
//                     child: Text(
//                       "$discount% off",
//                       style: GoogleFonts.openSans(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   )
//                 : SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.only(left: 10, right: 10, top: 5),
//               height: 120,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 // child: Image.network(
//                 //   "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZHNsciUyMGNhbWVyYXxlbnwwfHwwfHw%3D&w=1000&q=80",
//                 //   fit: BoxFit.fill,
//                 // ),
//                 child: CachedNetworkImage(
//                   imageUrl: image.isNotEmpty
//                       ? "https://cashbes.com/photography/$image"
//                       : noImage,
//                   placeholder: (context, url) {
//                     return Image.network(imgPlaceHolder);
//                   },
//                   errorWidget: ((context, url, error) {
//                     return Image.network(imgPlaceHolder);
//                   }),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               name,
//               style: GoogleFonts.quicksand(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.grey.shade700),
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               "₹$price",
//               style: GoogleFonts.openSans(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: primaryColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CategoryItemList extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String discount;
  final Function()? addToWishList;
  final Widget icon;

  final Function()? onTap;
  const CategoryItemList({
    Key? key,
    required this.name,
    required this.price,
    this.onTap,
    required this.image,
    required this.discount,
    this.addToWishList,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
          ),
          child: GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // discount == "" || discount == "0"
                //     ? SizedBox(height: 20)
                //     : Container(
                //         alignment: Alignment.center,
                //         margin: EdgeInsets.only(right: 80, bottom: 5),
                //         padding:
                //             EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                //         decoration: BoxDecoration(
                //             color: Colors.green,
                //             borderRadius: BorderRadius.circular(50)),
                //         child: Text(
                //           "$discount% off",
                //           style: GoogleFonts.openSans(
                //               fontSize: 12,
                //               fontWeight: FontWeight.w600,
                //               color: Colors.white),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                GestureDetector(
                  onTap: addToWishList,
                  child: Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 5),
                      child: icon),
                ),

                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // child: Image.network(
                        //   "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZHNsciUyMGNhbWVyYXxlbnwwfHwwfHw%3D&w=1000&q=80",
                        //   fit: BoxFit.fill,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: image.isNotEmpty
                              ? "https://cashbes.com/photography/$image"
                              : noImage,
                          placeholder: (context, url) {
                            return Image.network(imgPlaceHolder);
                          },
                          errorWidget: ((context, url, error) {
                            return Image.network(imgPlaceHolder);
                          }),
                        ),
                      ),
                    ),
                    // discount == "" || discount == "0"
                    //     ? SizedBox()
                    //     : Transform.translate(
                    //         offset: Offset(-75, -60),
                    //         child: Container(
                    //           padding: EdgeInsets.all(10),
                    //           decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: Colors.green,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                     color: Colors.grey, blurRadius: 3.0),
                    //               ]),
                    //           child: Text(
                    //             "$discount%",
                    //             style: GoogleFonts.openSans(
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: Colors.white),
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ),
                    //       ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Column(
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.montserrat(
                          fontSize: 13, color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "₹$price ",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                  ],
                ),
                // MaterialButton(
                //   height: 30,
                //   elevation: 0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   onPressed: onTap,
                //   child: Text(
                //     "View",
                //     style: GoogleFonts.montserrat(color: Colors.white),
                //   ),
                //   color: primaryColor,
                // ),
              ],
            ),
          ),
        ),
        discount == "" || discount == "0"
            ? SizedBox()
            : Transform.translate(
                offset: Offset(-75, -105),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 3.0),
                      ]),
                  child: Text(
                    "$discount%",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ],
    );
  }
}
