// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/wish_list/wish_list.notifier.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

import '../../../../repository/home_search/home_search.notifier.dart';
import '../../../../repository/productsDetails/product_details.notifier.dart';
import '../categories/accessories.view.dart';

class HomeSearchView extends StatefulWidget {
  const HomeSearchView({Key? key}) : super(key: key);

  @override
  State<HomeSearchView> createState() => _HomeSearchViewState();
}

class _HomeSearchViewState extends State<HomeSearchView> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    final searchData = Provider.of<HomeSearchNotifier>(context, listen: false);
    final productData = Provider.of<ViewProductNotifier>(context, listen: false);
    final wishListData = Provider.of<WishListNotifier>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        try {
          searchText = "";
          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 100,
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 5,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    try {
                      Navigator.pop(context);
                    } catch (e) {
                      Navigator.pop(context);
                    }
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: <Widget>[
                      SizedBox(height: 55.0),
                      Container(
                        margin: EdgeInsets.only(left: 55, right: 10),
                        width: double.infinity,
                        child: SearchFieldWidget(
                          // controller: _searchController,
                          readOnly: false,
                          autofocus: true,
                          hintText: "Cameras,items,and more",
                          onChanged: ((value) {
                            searchText = value;

                            setState(() {});
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder(
              future: searchData.searchData(title: searchText),
              builder: (context, snapshot) {
                if (searchText.isEmpty) {
                  return Center(
                    child: Text("Search"),
                  );
                } else {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  } else {
                    if (snapshot.hasData) {
                      if (searchData.homeSearchModel.data.isEmpty) {
                        return Center(
                          child: Text("No Data"),
                        );
                      }
                      return GridView.builder(
                          itemCount: searchData.homeSearchModel.data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Consumer<WishListNotifier>(builder: (context, data, _) {
                            return Consumer<HomeSearchNotifier>(builder: (context, data2, _) {
                              return CategoryItemList(
                                onTap: () {
                                  searchData.notifyListeners();
                                  // productData.productId = searchData.homeSearchModel.data[index].id;
                                  productData.productId = data2.homeSearchModel.data[index].id;
                                  Navigator.of(context).pushNamed("/offerProductDetailsView");
                                },
                                icon: wishListData.wishListedItems.contains(
                                        int.parse(searchData
                                            .homeSearchModel.data[index].id))
                                    ? Icon(Icons.favorite, color: primaryColor)
                                    : Icon(Icons.favorite_border),
                                image: searchData
                                    .homeSearchModel.data[index].image
                                    .toString(),
                                name: searchData
                                    .homeSearchModel.data[index].productName,
                                price: searchData
                                    .homeSearchModel.data[index].price,
                                discount: searchData
                                    .homeSearchModel.data[index].offerPer,
                                addToWishList: () async {
                                  wishListData.changeColors(int.parse(searchData
                                      .homeSearchModel.data[index].id));
                                  await wishListData.addToWishList(
                                      productId: searchData
                                          .homeSearchModel.data[index].id);
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
                            });
                          });
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No Data Found"));
                    }
                  }
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
