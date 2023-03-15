// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';
import 'package:qcamyapp/views/home/homeTabViews/categories/accessories.view.dart';

import '../../../../repository/productsDetails/product_details.notifier.dart';
import '../../../../repository/wish_list/wish_list.notifier.dart';

class BrandProductsView extends StatelessWidget {
  const BrandProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accessoriesData = Provider.of<AccessoriesNotifier>(context);

    final productData =
        Provider.of<ViewProductNotifier>(context, listen: false);
    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
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
          future: accessoriesData.getBrandAccessories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return accessoriesData.accessoriesModel.data.isNotEmpty
                  ? GridView.builder(
                      itemCount: accessoriesData.accessoriesModel.data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250, crossAxisCount: 2),
                      itemBuilder: ((context, index) {
                        return Consumer<WishListNotifier>(
                            builder: (context, data, _) {
                          return CategoryItemList(
                            icon: wishListData.wishListedItems.contains(
                                    int.parse(accessoriesData
                                        .accessoriesModel.data[index].id))
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
                              await wishListData.addToWishList(
                                  productId: accessoriesData
                                      .accessoriesModel.data[index].id);
                              if (wishListData.addToWishListModel.status ==
                                  "200") {
                                Fluttertoast.showToast(
                                    msg: "Added to wishlist",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    textColor: Colors.white,
                                    fontSize: 14.0);
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
