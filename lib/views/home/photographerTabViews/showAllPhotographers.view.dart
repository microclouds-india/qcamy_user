// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';

import 'package:qcamyapp/repository/search/showAll.notifier.dart';
import 'package:qcamyapp/widgets/photographers_list.widget.dart';

import '../../../repository/book_photographer/book_photographer.notifier.dart';
import '../../../repository/photographer_profile/profile.notifier.dart';

class ShowAllPhotographersView extends StatelessWidget {
  const ShowAllPhotographersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _showAllData = Provider.of<ShowAllNotifier>(context, listen: false);
    final photographerData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Photographers",
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
          future: _showAllData.showAll(keyword: "", category: "photographers"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Consumer<ShowAllNotifier>(builder: (context, data, _) {
                return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Divider(
                            height: 1,
                            thickness: 2,
                          ),
                        ),
                    itemCount: data.dataModel.data.length,
                    itemBuilder: ((context, index) {
                      return PhotographersList(
                        name: data.dataModel.data[index].name,
                        image: data.dataModel.data[index].profileImage,
                        location:
                            data.dataModel.data[index].description.isNotEmpty
                                ? data.dataModel.data[index].description
                                : data.dataModel.data[index].location,
                        onTap: () async {
                          await photographerData
                              .getPhotographerData(
                                  id: data.dataModel.data[index].id)
                              .then((value) {
                            //save photographerid in provider
                            Provider.of<BookPhotographerNotifier>(context,
                                        listen: false)
                                    .photographerId =
                                data.dataModel.data[index].id.toString();
                            Navigator.pushNamed(
                                context, "/photographerProfileView");
                          }).onError((error, stackTrace) {
                            throw error!;
                          });
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
