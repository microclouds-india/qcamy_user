// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:android_intent_plus/android_intent.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/image_links.dart';
import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';

import 'package:qcamyapp/repository/adBanner/sliderAdBanner.notifier.dart';
import 'package:qcamyapp/repository/categories/categories.notifier.dart';
import 'package:qcamyapp/repository/location/update_location.notifier.dart';
import 'package:qcamyapp/repository/refresh/refresh.notifier.dart';
import 'package:qcamyapp/repository/remove_wishlist/remove_wishlist.notifier.dart';

import 'package:qcamyapp/repository/todays_deals/todays_deals.notifier.dart';
import 'package:qcamyapp/repository/wishlist_items_showing/wishlist_item_showing.notifier.dart';
import 'package:qcamyapp/views/main.view.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

import '../../core/location_service/location_services.dart';
import '../../repository/book_photographer/book_photographer.notifier.dart';
import '../../repository/brands/brands.notifier.dart';
import '../../repository/cart/cart.notifier.dart';
import '../../repository/hot_products/hot_products.notifier.dart';
import '../../repository/new_products/new_products.notifier.dart';
import '../../repository/productsDetails/product_details.notifier.dart';
import '../../repository/rental_equipments/rental_equipments.notifier.dart';
import '../../repository/wish_list/wish_list.notifier.dart';
import '../../widgets/ad_error.widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final singleAdBannerData =
    //     Provider.of<SingleAdBannerNotifier>(context, listen: false);
    LocationServices locationServices = LocationServices();
    final cartData = Provider.of<CartNotifier>(context, listen: false);
    final categoryData = Provider.of<CategoryNotifier>(context, listen: false);
    final brandsData = Provider.of<BrandsNotifier>(context, listen: false);
    final productsData = Provider.of<AccessoriesNotifier>(context, listen: false);
    final todaysDealsData =
        Provider.of<TodaysDealsNotifier>(context, listen: false);
    final productDetailsData =
        Provider.of<ViewProductNotifier>(context, listen: false);
    final hotProductsData =
        Provider.of<HotProductsNotifier>(context, listen: false);
    final newProductsData =
        Provider.of<NewProductsNotifier>(context, listen: false);
    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
    final removeWishListData =
        Provider.of<RemoveWishListNotifier>(context, listen: false);

    //this consumer is used to refresh the page when the user is in the home tab
    return Consumer<RefreshNotifier>(builder: (context, data, _) {
      return SingleChildScrollView(
        child: Column(
          children: [
            //location
            Container(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Column(
                children: [
                  // MenuAppBar(),
                  Consumer<UpdateLocation>(builder: (context, data, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Builder(builder: (context) {
                              return IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                              );
                            }),
                            IconButton(
                              onPressed: () async {
                                if (!(await Geolocator
                                    .isLocationServiceEnabled())) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("Location services disabled"),
                                      content: Text(
                                          "Please enable location services"),
                                      actions: [
                                        MaterialButton(
                                          child: Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        MaterialButton(
                                          child: Text("Turn on"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            const AndroidIntent intent =
                                                AndroidIntent(
                                                    action:
                                                        'android.settings.LOCATION_SOURCE_SETTINGS');

                                            intent.launch();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  await locationServices.getLocation();
                                  data.updateLocation();
                                }
                              },
                              icon: Icon(
                                Icons.location_on,
                                size: 28,
                                color: primaryColor,
                              ),
                            ),
                            FutureBuilder(
                                future: locationServices.getLocationAddress(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text(
                                      "loading...",
                                      style: GoogleFonts.roboto(fontSize: 15),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Text(
                                      "Select your location",
                                      style: GoogleFonts.roboto(fontSize: 15),
                                    );
                                  }
                                  return Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       "Current location",
                                        //       style: GoogleFonts.openSans(
                                        //           color: Colors.black,
                                        //           fontWeight: FontWeight.bold,
                                        //           fontSize: 16),
                                        //     ),
                                        //   ],
                                        // ),
                                        Text(
                                          snapshot.data.toString(),
                                          style: GoogleFonts.roboto(fontSize: 14),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("/notificationView");
                                },
                                icon: Icon(
                                  Icons.notifications,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              FutureBuilder(
                                  future: cartData.getCartCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (cartData.cartCountModel.status ==
                                          "200") {
                                        return IconButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushNamed("/cartView");
                                          },
                                          icon: Consumer<CartNotifier>(
                                              builder: (context, data, _) {
                                            return Badge(
                                              badgeContent: Text(
                                                cartData.cartCountModel.count
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              badgeColor: primaryColor,
                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.grey.shade700,
                                              ),
                                            );
                                          }),
                                        );
                                      } else {
                                        return IconButton(
                                          onPressed: () async {
                                            Navigator.of(context)
                                                .pushNamed("/cartView");
                                          },
                                          icon: Badge(
                                            badgeContent: Text(
                                              '0',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            badgeColor: primaryColor,
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    return SizedBox();
                                  }),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            //search field
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SearchFieldWidget(
                hintText: "Search for cameras,items and more",
                readOnly: true,
                autofocus: false,
                onTap: () {
                  Navigator.pushNamed(context, '/homeSearchView');
                },
              ),
            ),
            SizedBox(height: 20),
            // SizedBox(
            //   width: double.infinity,
            //   child: FutureBuilder(
            //       future: categoryData.getCategories(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return GridView.builder(
            //               shrinkWrap: true,
            //               gridDelegate:
            //                   SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 3,
            //               ),
            //               scrollDirection: Axis.vertical,
            //               itemCount: categoryData.categoryModel.data.length,
            //               itemBuilder: ((context, index) {
            //                 return SingleChildScrollView(
            //                   child: CategoryWidget(
            //                       text: categoryData
            //                           .categoryModel.data[index].categoryname,
            //                       networkImage:
            //                           "https://cashbes.com/photography/${categoryData.categoryModel.data[index].image}",
            //                       ontap: () {
            //                         if (categoryData.categoryModel.data[index]
            //                                 .categoryname
            //                                 .toLowerCase() ==
            //                             "rentals") {
            //                           HomeView.pageIndexNotifier.value = 3;
            //                         } else if (categoryData.categoryModel
            //                                 .data[index].categoryname
            //                                 .toLowerCase() ==
            //                             "repair") {
            //                           HomeView.pageIndexNotifier.value = 2;
            //                         } else {
            //                           productsData.categoryName = categoryData
            //                               .categoryModel
            //                               .data[index]
            //                               .categoryname;
            //                           productsData.categoryId = categoryData
            //                               .categoryModel.data[index].id;
            //                           Navigator.pushNamed(
            //                               context, "/accessoriesView");
            //                         }
            //                       }),
            //                 );
            //               }));
            //         }
            //         return Center(
            //           child: CircularProgressIndicator(color: primaryColor),
            //         );
            //       }),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          productsData.categoryName = "Camera";
                          productsData.categoryId = "3";
                          Navigator.pushNamed(context, "/accessoriesView");
                        },
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(40),
                            child: Image.asset("assets/images/cameraa.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Camera",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          productsData.categoryName = "Accessories";
                          productsData.categoryId = "2";
                          Navigator.pushNamed(context, "/accessoriesView");
                        },
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(40),
                            child:
                                Image.asset("assets/images/accessoriess.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Accessories",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          productsData.categoryName = "Used";
                          productsData.categoryId = "5";
                          Navigator.pushNamed(context, "/accessoriesView");
                        },
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(40),
                            child: Image.asset("assets/images/used.jpg"),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Used",
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            //categories
            SizedBox(
              width: double.infinity,
              height: 125,
              child: FutureBuilder(
                  future: categoryData.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryData.categoryModel.data.length,
                              itemBuilder: ((context, index) {
                                return CategoryWidget(
                                    text: categoryData.categoryModel.data[index].categoryname,
                                    networkImage:
                                        "https://cashbes.com/photography/${categoryData.categoryModel.data[index].image}",
                                    ontap: () {
                                      if (categoryData.categoryModel.data[index]
                                              .categoryname
                                              .toLowerCase() ==
                                          "rentals") {
                                        HomeView.pageIndexNotifier.value = 3;
                                      } else if (categoryData.categoryModel
                                              .data[index].categoryname
                                              .toLowerCase() ==
                                          "repair") {
                                        HomeView.pageIndexNotifier.value = 2;
                                      } else {
                                        productsData.categoryName = categoryData.categoryModel.data[index].categoryname;
                                        productsData.categoryId = categoryData.categoryModel.data[index].id;
                                        Navigator.pushNamed(context, "/accessoriesView");
                                      }
                                    });
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed("/exchangeProduct");
                                    },
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(40),
                                        child: Image.asset(
                                            "assets/images/accessoriess.jpg"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Exchange product",
                                    style: GoogleFonts.montserrat(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed("/enquireProduct");
                                    },
                                    child: ClipOval(
                                      child: SizedBox.fromSize(
                                        size: Size.fromRadius(40),
                                        child: Image.asset(
                                            "assets/images/cameraa.jpg"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Enquire product",
                                    style: GoogleFonts.montserrat(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 42,
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
            //sliding ads
            AdBanners(),
            //todays deals
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                "Todays Deals",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: FutureBuilder(
                  future: todaysDealsData.getTodaysDeals(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (todaysDealsData.todaysDealsModel.data.isNotEmpty) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                todaysDealsData.todaysDealsModel.data.length,
                            itemBuilder: (context, index) {
                              if (todaysDealsData.todaysDealsModel.data[index]
                                  .offerPer.isNotEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    productDetailsData.productId = todaysDealsData.todaysDealsModel.data[index].id;
                                    Navigator.of(context).pushNamed("/offerProductDetailsView");
                                  },
                                  child: TodaysDeal(
                                    image: todaysDealsData
                                        .todaysDealsModel.data[index].image,
                                    name: todaysDealsData.todaysDealsModel
                                        .data[index].productName,
                                    price: todaysDealsData
                                        .todaysDealsModel.data[index].price,
                                    cutPrice: todaysDealsData
                                        .todaysDealsModel.data[index].cutPrice,
                                    offerPerc: todaysDealsData
                                        .todaysDealsModel.data[index].offerPer,
                                  ),
                                );
                              }
                              return SizedBox();
                            });
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
              alignment: Alignment.topLeft,
              child: Text(
                "Brands",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            FutureBuilder(
                future: brandsData.getBrands(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      // margin: EdgeInsets.only(right: 10, left: 10),
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        // borderRadius: BorderRadius.circular(15),
                      ),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 10,
                                  mainAxisExtent: 115,
                                  crossAxisCount: 3),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: brandsData.brandsModel.data.length,
                          itemBuilder: ((context, index) {
                            return BrandsWidget(
                                networkImage:
                                    brandsData.brandsModel.data[index].image,
                                ontap: () {
                                  productsData.categoryName = brandsData.brandsModel.data[index].brandName;
                                  productsData.brandId = brandsData.brandsModel.data[index].id;
                                  Navigator.pushNamed(
                                      context, "/brandProductsView");
                                });
                          })),
                    );
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 150, crossAxisCount: 3),
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 42,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                }),

            BottomAdBanners(),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                "New Arrivals",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: FutureBuilder(
                  future: newProductsData.getHotProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount:
                              todaysDealsData.todaysDealsModel.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                productDetailsData.productId = newProductsData
                                    .newArrivalsModel.data[index].id;

                                Navigator.of(context)
                                    .pushNamed("/offerProductDetailsView");
                              },
                              child: TodaysDeal(
                                image: newProductsData.newArrivalsModel
                                        .data[index].image.isNotEmpty
                                    ? "https://cashbes.com/photography/${newProductsData.newArrivalsModel.data[index].image}"
                                    : noImage,
                                name: newProductsData
                                    .newArrivalsModel.data[index].productName,
                                price: newProductsData
                                    .newArrivalsModel.data[index].price,
                                cutPrice: newProductsData
                                    .newArrivalsModel.data[index].cutPrice,
                                offerPerc: newProductsData
                                    .newArrivalsModel.data[index].offerPer,
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                "Hot Products",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
            FutureBuilder(
              future: hotProductsData.getHotProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (hotProductsData.hotProductsModel.data.isEmpty) {
                    return SizedBox();
                  } else {
                    return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: hotProductsData.hotProductsModel.data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Consumer<HotProductsNotifier>(
                            builder: (context, datas, _) {
                          return HotProductsList(
                              onTap: () {
                                productDetailsData.productId = hotProductsData.hotProductsModel.data[index].id;
                                Navigator.of(context).pushNamed("/offerProductDetailsView");
                              },
                              icon: hotProductsData.hotProductsModel.data[index].wishlist_id != "0"
                                  ? Icon(Icons.favorite, color: primaryColor)
                                  : Icon(Icons.favorite_border),
                              image: hotProductsData.hotProductsModel.data[index].image,
                              name: hotProductsData.hotProductsModel.data[index].productName,
                              price: hotProductsData.hotProductsModel.data[index].price,
                              cutPrice: hotProductsData.hotProductsModel.data[index].cutPrice,
                              discount: hotProductsData.hotProductsModel.data[index].offerPer,
                              addToWishList: () async {
                                if (hotProductsData.hotProductsModel.data[index]
                                        .wishlist_id ==
                                    "0") {
                                  wishListData.changeColors(int.parse(
                                      hotProductsData
                                          .hotProductsModel.data[index].id));
                                  await wishListData.addToWishList(
                                    productId: hotProductsData
                                        .hotProductsModel.data[index].id,
                                  );
                                  if (wishListData.addToWishListModel.status ==
                                      "200") {
                                    hotProductsData.getHotProducts();
                                    Fluttertoast.showToast(
                                        msg: "Added to wishlist",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                  }
                                } else if (hotProductsData.hotProductsModel
                                        .data[index].wishlist_id !=
                                    "0") {
                                  wishListData.changeColors(int.parse(
                                      hotProductsData
                                          .hotProductsModel.data[index].id));
                                  await removeWishListData.removeWishList(
                                    productId: hotProductsData.hotProductsModel
                                        .data[index].wishlist_id,
                                  );
                                  if (removeWishListData
                                          .removeWishlistModel.status ==
                                      "200") {
                                    hotProductsData.getHotProducts();
                                    Fluttertoast.showToast(
                                        msg: "Removed from wishlist",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
                                  }
                                }
                              });
                        });
                      },
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

//hot products
class HotProductsList extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final String discount;
  final String cutPrice;
  final Function()? onTap;
  final Function() addToWishList;
  final Widget icon;

  const HotProductsList({
    Key? key,
    required this.name,
    required this.price,
    this.onTap,
    required this.image,
    required this.discount,
    required this.cutPrice,
    required this.addToWishList,
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
          decoration: Ui.getBoxDecoration(color: Colors.grey),
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
                      padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        // child: Image.network(
                        //   "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZHNsciUyMGNhbWVyYXxlbnwwfHwwfHw%3D&w=1000&q=80",
                        //   fit: BoxFit.fill,
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: image.isNotEmpty ? image : noImage,
                          placeholder: (context, url) {
                            return Image.asset(
                                "assets/images/png/pholder_image.jpg");
                          },
                          errorWidget: ((context, url, error) {
                            return Image.asset(
                                "assets/images/png/pholder_image.jpg");
                          }),
                        ),
                      ),
                    ),
                    // discount == "" || discount == "0"
                    //     ? SizedBox()
                    //     : Transform.translate(
                    //         offset: Offset(-75, -50),
                    //         child: Container(
                    //           padding: EdgeInsets.all(10),
                    //           decoration: BoxDecoration(
                    //               shape: BoxShape.circle,
                    //               color: Colors.green,
                    //               boxShadow: [
                    //                 BoxShadow(color: Colors.grey, blurRadius: 3.0),
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
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                      fontSize: 13, color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "₹$price ",
                      style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryColor),
                    ),
                    discount == "" || discount == "0"
                        ? SizedBox()
                        : Text(
                            "₹$cutPrice",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough),
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

//today deal widget
class TodaysDeal extends StatelessWidget {
  const TodaysDeal({
    Key? key,
    required this.image,
    required this.price,
    required this.cutPrice,
    required this.name,
    required this.offerPerc,
  }) : super(key: key);

  final String image;
  final String name;
  final String price;
  final String cutPrice;
  final String offerPerc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 3,
                offset: Offset(5, 2))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          offerPerc.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(right: 70, left: 5, bottom: 5, top: 5),
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "$offerPerc% off",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // child: Image.network(
              //   "https://images.unsplash.com/photo-1616423640778-28d1b53229bd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZHNsciUyMGNhbWVyYXxlbnwwfHwwfHw%3D&w=1000&q=80",
              //   fit: BoxFit.fill,
              // ),
              child: CachedNetworkImage(
                imageUrl: image.isNotEmpty ? image : noImage,
                height: 80,
                width: 80,
                placeholder: (context, url) {
                  return Image.asset(
                    "assets/images/png/pholder_image.jpg",
                    height: 80,
                    width: 80,
                  );
                },
                errorWidget: ((context, url, error) {
                  return Image.asset(
                    "assets/images/png/pholder_image.jpg",
                    height: 80,
                    width: 80,
                  );
                }),
              ),
            ),
          ),
          Flexible(
            child: Text(
              name,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 13,
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
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "₹$cutPrice",
                style: TextStyle(
                    fontSize: 14, decoration: TextDecoration.lineThrough),
              ),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

//sliding ad banner widget
class AdBanners extends StatelessWidget {
  const AdBanners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SliderAdBannerNotifier>(context);
    final productsData =
        Provider.of<AccessoriesNotifier>(context, listen: false);
    data.haveError = false;
    return data.haveError
        ? BannerError()
        : FutureBuilder(
            future: data.getSliderAdBanners(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (data.adBannerModel.data.isEmpty) {
                  return SizedBox();
                }
                return CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      height: 225,
                      viewportFraction: 0.80,
                      enlargeCenterPage: true),
                  items: data.adBannerModel.data.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        final accessoriesData =
                            Provider.of<ViewProductNotifier>(context,
                                listen: false);
                        return GestureDetector(
                          onTap: () {
                            if (i.linkType == "product_details_page") {
                              accessoriesData.productId = i.link;

                              Navigator.of(context)
                                  .pushNamed("/offerProductDetailsView");
                            } else if (i.linkType == "categories_page") {
                              productsData.categoryName = "";
                              productsData.categoryId = i.link;
                              Navigator.pushNamed(context, "/accessoriesView");
                            } else if (i.linkType ==
                                "photographer_profile_page") {
                              Provider.of<BookPhotographerNotifier>(context,
                                      listen: false)
                                  .photographerId = i.link;
                              Navigator.pushNamed(
                                  context, "/photographerProfileView");
                            } else if (i.linkType ==
                                "rentalshop_profile_page") {
                              Provider.of<RentalEquipmentsNotifier>(context,
                                      listen: false)
                                  .rentalShopId = i.link;
                              Navigator.pushNamed(
                                  context, '/searchEquipmentsView');
                            } else if (i.linkType == "pages") {
                              if (i.link == "repair_page") {
                                HomeView.pageIndexNotifier.value = 2;
                              } else if (i.link == "photographer_page") {
                                HomeView.pageIndexNotifier.value = 1;
                              } else if (i.link == "rentalshop_page") {
                                HomeView.pageIndexNotifier.value = 3;
                              }
                            }
                          },
                          child: Container(
                            height: 450,
                            width: 450,
                            margin: const EdgeInsets.only(bottom: 5),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            // child: Image.network(
                            //   i.image.data[0].image,
                            //   fit: BoxFit.fill,
                            //   errorBuilder: ((context, error, stackTrace) {
                            //     return Center(
                            //       child: Text("Error loading Ad"),
                            //     );
                            //   }),
                            //   loadingBuilder:
                            //       ((context, child, loadingProgress) {
                            //     if (loadingProgress == null) {
                            //       return child;
                            //     }
                            //     return Center(
                            //       child: CircularProgressIndicator(
                            //         color: primaryColor,
                            //       ),
                            //     );
                            //   }),
                            // ),
                            child: CachedNetworkImage(
                              imageUrl: i.image.data[0].image,
                              fit: BoxFit.fill,
                              height: 450,
                              width: 450,
                              errorWidget: ((context, url, error) {
                                return Center(
                                  child: Text("Error loading Ad"),
                                );
                              }),
                              progressIndicatorBuilder:
                                  ((context, url, downloadProgress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return BannerError();
              }

              return SizedBox(
                height: 230,
                child: Center(
                    child: CircularProgressIndicator(color: primaryColor)),
              );
            });
  }
}

//category widget
// class CategoryWidget extends StatelessWidget {
//   final String text;
//   final Function()? ontap;
//   final String? networkImage;
//   const CategoryWidget(
//       {Key? key, required this.text, this.ontap, this.networkImage})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: ontap,
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               radius: 42,
//               backgroundImage: NetworkImage(
//                 networkImage!,
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             text,
//             style: GoogleFonts.montserrat(fontSize: 13),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CategoryWidget extends StatelessWidget {
  final String text;
  final Function()? ontap;
  final String? networkImage;

  const CategoryWidget(
      {Key? key, required this.text, this.ontap, this.networkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          GestureDetector(
            onTap: ontap,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(40),
                child: CachedNetworkImage(
                  imageUrl: networkImage!,
                  fit: BoxFit.fill,
                  placeholder: ((context, url) {
                    return Container(
                      color: Colors.white,
                    );
                  }),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                        "assets/images/png/nobg_pholder_image.png");
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: GoogleFonts.montserrat(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class BrandsWidget extends StatelessWidget {
  final Function()? ontap;
  final String? networkImage;

  const BrandsWidget({Key? key, this.ontap, this.networkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: const Offset(0, 5)),
            ],
            border: Border.all(color: Colors.grey),
          ),
          child: ClipOval(
            child: SizedBox.fromSize(
              size: Size.fromRadius(50),
              child: CachedNetworkImage(
                imageUrl: networkImage!,
                fit: BoxFit.fill,
                placeholder: ((context, url) {
                  return Image.asset(
                      "assets/images/png/nobg_pholder_image.png");
                }),
              ),
            ),
          ),
        ));
  }
}

// class BottomAdBanners extends StatelessWidget {
//   const BottomAdBanners({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<SliderAdBannerNotifier>(context, listen: false);

//     return FutureBuilder(
//         future: data.getBottomSlidingAds(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return SizedBox(
//               height: 230,
//               width: double.infinity,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: data.bottomSlidingAdsModel.data.length,
//                   itemBuilder: ((context, index) {
//                     return GestureDetector(
//                       onTap: () {
//                         data.bannedId =
//                             data.bottomSlidingAdsModel.data[index].id;
//                         Navigator.of(context).pushNamed("/applicationView");
//                       },
//                       child: Container(
//                         width: 300,
//                         margin: const EdgeInsets.all(10),
//                         clipBehavior: Clip.hardEdge,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: CachedNetworkImage(
//                           imageUrl: data.bottomSlidingAdsModel.data[index].image
//                               .data[0].image,
//                           fit: BoxFit.fill,
//                           errorWidget: ((context, url, error) {
//                             return Center(
//                               child: BannerError(),
//                             );
//                           }),
//                           progressIndicatorBuilder:
//                               ((context, url, downloadProgress) {
//                             return Center(
//                               child: CircularProgressIndicator(
//                                 color: primaryColor,
//                               ),
//                             );
//                           }),
//                         ),
//                       ),
//                     );
//                   })),
//             );
//           }

//           return SizedBox(
//             height: 230,
//             child:
//                 Center(child: CircularProgressIndicator(color: primaryColor)),
//           );
//         });
//   }
// }

class BottomAdBanners extends StatelessWidget {
  const BottomAdBanners({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SliderAdBannerNotifier>(context, listen: false);

    return FutureBuilder(
        future: data.getBottomSlidingAds(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                height: 230,
                viewportFraction: 1,
              ),
              items: data.bottomSlidingAdsModel.data.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        data.bannedId = i.id;
                        Navigator.of(context).pushNamed("/applicationView");
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: i.image.data[0].image,
                          fit: BoxFit.fill,
                          errorWidget: ((context, url, error) {
                            return BannerError();
                          }),
                          progressIndicatorBuilder:
                              ((context, url, downloadProgress) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            );
          }

          return SizedBox(
            height: 230,
            child:
                Center(child: CircularProgressIndicator(color: primaryColor)),
          );
        });
  }
}
