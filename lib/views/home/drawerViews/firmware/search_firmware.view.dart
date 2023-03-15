// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/firmwareSearch/firmwareSearch.notifier.dart';

import '../../../../config/colors.dart';
import '../../../../widgets/searchBar.widget.dart';

class SearchFirmwareView extends StatefulWidget {
  const SearchFirmwareView({Key? key}) : super(key: key);

  @override
  State<SearchFirmwareView> createState() => _SearchFirmwareViewState();
}

class _SearchFirmwareViewState extends State<SearchFirmwareView> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final firmwareSearchData = Provider.of<FirmwareSearchNotifier>(context, listen: false);

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
                        hintText: "Search Firmwares",
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
            future: firmwareSearchData.searchData(title: searchText),
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
                    if (firmwareSearchData.firmwareSearchModel.data.isEmpty) {
                      return Center(
                        child: Text("No Data"),
                      );
                    }
                    return ListView.builder(
                        itemCount: firmwareSearchData.firmwareSearchModel.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade400),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(firmwareSearchData.firmwareSearchModel.data[index]!.brandName,
                                  style: GoogleFonts.openSans(
                                    fontSize: 16,
                                  ),
                                ),
                                Consumer<FirmwareSearchNotifier>(builder: (context, data, _) {
                                  // return data.downloading ? Center(
                                  //         child: CircularProgressIndicator(
                                  //           color: primaryColor,
                                  //         ),
                                  //       ) : IconButton(
                                  //         onPressed: () {
                                  //           firmwareData.downloadFile(pdfUrl: "https://coderzheaven.com/youtube_flutter/images.zip");
                                  //           // firmwareData.downloadFile(pdfUrl: firmwareData.firmwareModel.data[index]!.files);
                                  //           ScaffoldMessenger.of(context).showSnackBar(
                                  //             SnackBar(
                                  //               behavior: SnackBarBehavior.floating,
                                  //               backgroundColor: primaryColor,
                                  //               content: Text("File will download in your downloads folder. please check"),
                                  //             ),
                                  //           );
                                  //         },
                                  //         icon: Icon(Icons.download),
                                  //       );
                                  return IconButton(
                                    onPressed: () {
                                      firmwareSearchData.downloadFile(pdfUrl: "https://coderzheaven.com/youtube_flutter/images.zip");
                                      // firmwareData.downloadFile(pdfUrl: firmwareData.firmwareModel.data[index]!.files);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: primaryColor,
                                          content: Text("File will download in your downloads folder. please check"),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.download),
                                  );
                                }),
                              ],
                            ),
                          );
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
    );
  }
}
