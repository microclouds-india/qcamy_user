// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.notifier.dart';
import 'package:qcamyapp/repository/wish_list/wish_list.notifier.dart';

import '../../../config/colors.dart';
import '../../../config/image_links.dart';
import '../../../repository/productsDetails/product_details.notifier.dart';

class WishListView extends StatelessWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
    final removeWishListData = Provider.of<RemoveWishListNotifier>(context, listen: false);
    final productData = Provider.of<ViewProductNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Wishlist",
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
          future: wishListData.getWishList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (wishListData.wishListModel.data.isEmpty) {
                return Center(
                  child: Text("No items"),
                );
              } else {
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: wishListData.wishListModel.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Consumer<WishListNotifier>(builder: (context, data, _) {
                            return WishListProductsList(
                                name: wishListData.wishListModel.data[index].productName,
                                price: wishListData.wishListModel.data[index].price,
                                image: wishListData.wishListModel.data[index].image,
                                onTap: () {
                                  productData.productId = wishListData.wishListModel.data[index].productId;
                                  Navigator.of(context).pushNamed("/offerProductDetailsView");
                                },
                                icon: wishListData.wishListedItems.contains(int.parse(wishListData.wishListModel.data[index].id)) ?
                                Icon(Icons.favorite_border) : Icon(Icons.favorite,
                                    color: primaryColor),
                                removeFromWishList: () async {
                                  if(!wishListData.wishListedItems.contains(int.parse(wishListData.wishListModel.data[index].id))){
                                    wishListData.changeColors(int.parse(wishListData.wishListModel.data[index].id));
                                    await removeWishListData.removeWishList(
                                      productId: wishListData.wishListModel.data[index].id,
                                    );
                                    if (removeWishListData.removeWishlistModel.status == "200") {
                                      Fluttertoast.showToast(
                                          msg: "Removed from wishlist",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }
                                  }else if(wishListData.wishListedItems.contains(int.parse(wishListData.wishListModel.data[index].id))) {
                                    wishListData.changeColors(int.parse(wishListData.wishListModel.data[index].id));
                                    await wishListData.addToWishList(
                                      productId: wishListData.wishListModel.data[index].id,
                                    );
                                    if (wishListData.addToWishListModel.status == "200") {
                                      Fluttertoast.showToast(
                                          msg: "Added to wishlist",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }
                                  }

                                });
                          });
                    });
              }
            }
            return Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }),
    );
  }
}

class WishListProductsList extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  final Function()? onTap;
  final Function()? removeFromWishList;
  final Widget icon;

  const WishListProductsList({
    Key? key,
    required this.name,
    required this.price,
    this.onTap,
    required this.image,
    required this.icon,
    required this.removeFromWishList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: removeFromWishList,
              child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 5),
                  child: icon),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: image.isNotEmpty ? image : noImage,
                  placeholder: (context, url) {
                    return Image.asset("assets/images/png/pholder_image.jpg");
                  },
                  errorWidget: ((context, url, error) {
                    return Image.asset("assets/images/png/pholder_image.jpg");
                  }),
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
