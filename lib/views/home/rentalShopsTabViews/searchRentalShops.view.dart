// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/widgets/rental_shop_list.widget.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

import '../../../config/colors.dart';
import '../../../repository/rental_equipments/rental_equipments.notifier.dart';
import '../../../repository/search/search.notifier.dart';

class SearchRentalShopsView extends StatelessWidget {
  const SearchRentalShopsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchData = Provider.of<SearchNotifier>(context, listen: true);
    final _rentalEquipmentsData =
        Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        try {
          _searchData.clearSearch();

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
                      _searchData.clearSearch();

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
                          hintText: "Search rental shop",
                          onChanged: ((value) {
                            _searchData.searchData(
                              keyword: value,
                              category: "rentalshops",
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Consumer<SearchNotifier>(
            builder: (context, data, _) {
              if (data.dataLoaded) {
                return ListView.builder(
                    itemCount: data.searchModel.data.length,
                    itemBuilder: ((context, index) {
                      return RentalShopsList(
                        shopName: data.searchModel.data[index].name,
                        mobileNumber: data.searchModel.data[index].phone,
                        image: data.searchModel.data[index].profileImage,
                        location: data.searchModel.data[index].location,
                        onTap: () {
                          //store equipment rental shop id to get rental shop/equipment details
                          _rentalEquipmentsData.rentalShopId =
                              data.searchModel.data[index].id;
                          Navigator.pushNamed(context, '/searchEquipmentsView');
                        },
                      );
                    }));
              }

              return !data.dataLoaded
                  ? SizedBox()
                  : Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
