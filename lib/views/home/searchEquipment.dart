// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/equipment_search/equipment_search.notifier.dart';
import 'package:qcamyapp/repository/rental_equipment_detail/rental_equi_details.notifier.dart';
import 'package:qcamyapp/repository/rental_equipments/rental_equipments.notifier.dart';
import 'package:qcamyapp/views/home/rentalShopsTabViews/searchEquipments.view.dart';

import '../../../../config/colors.dart';
import '../../../../widgets/searchBar.widget.dart';

class SearchEquipment extends StatefulWidget {
  const SearchEquipment({Key? key}) : super(key: key);

  @override
  State<SearchEquipment> createState() => _SearchEquipmentState();
}

class _SearchEquipmentState extends State<SearchEquipment> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final equipmentSearchData = Provider.of<EquipmentSearchNotifier>(context, listen: false);
    final _rentalEquipmentsData = Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    final _rentalEquipmentDetailsData = Provider.of<RentalEquipmentDetailsNotifier>(context, listen: false);

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
                        hintText: "Search Equipments",
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
            future: equipmentSearchData.searchData(title: searchText),
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
                    if (equipmentSearchData.equipmentSearchModel.data.isEmpty) {
                      return Center(
                        child: Text("No Data"),
                      );
                    }
                    return GridView.builder(
                        itemCount:
                        _rentalEquipmentsData.rentalEquipmentModel.data!.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250, crossAxisCount: 2),
                        itemBuilder: ((context, index) {
                          return EquipmentsList(
                            name: _rentalEquipmentsData
                                .rentalEquipmentModel.data![index].name,
                            rentType: _rentalEquipmentsData
                                .rentalEquipmentModel.data![index].renttype,
                            price: _rentalEquipmentsData
                                .rentalEquipmentModel.data![index].price,
                            image: _rentalEquipmentsData
                                .rentalEquipmentModel.data![index].image,
                            onTap: () {
                              _rentalEquipmentDetailsData.rentalEquipmentId =
                                  _rentalEquipmentsData
                                      .rentalEquipmentModel.data![index].id;

                              Navigator.pushNamed(context, '/equipmentDetailsView');
                            },
                          );
                        }));
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
    );
  }
}
