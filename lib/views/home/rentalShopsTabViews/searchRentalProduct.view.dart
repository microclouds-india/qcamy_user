import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/rentalShopSearch/rentalShopSearch.notifier.dart';
import 'package:qcamyapp/repository/rental_equipments/rental_equipments.notifier.dart';
import 'package:qcamyapp/views/home/drawerViews/my_rentals/rental_details.view.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

class SearchRentalProductView extends StatefulWidget {
  const SearchRentalProductView({Key? key}) : super(key: key);

  @override
  State<SearchRentalProductView> createState() => _SearchRentalProductViewState();
}

class _SearchRentalProductViewState extends State<SearchRentalProductView> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final rentalShopSearchData = Provider.of<RentalShopSearchNotifier>(context, listen: false);
    final _rentalEquipmentsData = Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    // final _rentalEquipmentDetailsData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);

    return Scaffold(
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
                icon: const Icon(
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
                    const SizedBox(height: 55.0),
                    Container(
                      margin: const EdgeInsets.only(left: 55, right: 10),
                      width: double.infinity,
                      child: SearchFieldWidget(
                        // controller: _searchController,
                        readOnly: false,
                        autofocus: true,
                        hintText: "Search Rental Shops",
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
            future: rentalShopSearchData.searchData(title: searchText),
            builder: (context, snapshot) {
              if (searchText.isEmpty) {
                return const Center(
                  child: Text("Search"),
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                } else {
                  if (snapshot.hasData) {
                    if (rentalShopSearchData.rentalShopSearchModel.data.isEmpty) {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }
                    return ListView.builder(
                        itemCount: rentalShopSearchData.rentalShopSearchModel.data.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: primaryColor,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: RentalShopsList(
                              shopName: rentalShopSearchData.rentalShopSearchModel.data[index].name,
                              mobileNumber: rentalShopSearchData.rentalShopSearchModel.data[index].phone,
                              image: rentalShopSearchData.rentalShopSearchModel.data[index].profileImage,
                              location: rentalShopSearchData.rentalShopSearchModel.data[index].location,
                              onTap: () async {
                                //store equipment rental shop id to get rental shop/equipment details
                                _rentalEquipmentsData.rentalShopId = rentalShopSearchData.rentalShopSearchModel.data[index].id;
                                Navigator.pushNamed(context, '/searchEquipmentsView');
                              },
                            ),
                          );
                        }));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("No Data Found"));
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }),
      ),
    );
  }
}
