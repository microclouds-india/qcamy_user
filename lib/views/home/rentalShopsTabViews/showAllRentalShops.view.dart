// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/rental_equipments/rental_equipments.notifier.dart';
import 'package:qcamyapp/repository/search/showAll.notifier.dart';

import '../../../config/colors.dart';
import '../../../widgets/rental_shop_list.widget.dart';

class ShowAllRentalShopsView extends StatelessWidget {
  const ShowAllRentalShopsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showAllData = Provider.of<ShowAllNotifier>(context, listen: false);
    final _rentalEquipmentsData =
        Provider.of<RentalEquipmentsNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Rental Shops",
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
            try {
              _showAllData.dataModel.data.clear();
              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/searchRentalProductView');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _showAllData.showAll(keyword: "", category: "rentalshops"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<ShowAllNotifier>(builder: (context, data, _) {
                return ListView.builder(
                    itemCount: data.dataModel.data.length,
                    itemBuilder: ((context, index) {
                      return RentalShopsList(
                        shopName: data.dataModel.data[index].name,
                        mobileNumber: data.dataModel.data[index].phone,
                        image: data.dataModel.data[index].profileImage,
                        location: data.dataModel.data[index].location,
                        onTap: () async {
                          //store equipment rental shop id to get rental shop/equipment details

                          _rentalEquipmentsData.rentalShopId =
                              data.dataModel.data[index].id;
                          Navigator.pushNamed(context, '/searchEquipmentsView');
                        },
                      );
                    }));
              });
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}
