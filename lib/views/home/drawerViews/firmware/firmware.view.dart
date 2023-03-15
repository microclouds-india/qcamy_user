// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/repository/firmware/firmware.notifier.dart';
import 'package:qcamyapp/views/zip/zipDownload.dart';

import '../../../../config/colors.dart';

class FirmwareDownloadView extends StatefulWidget {
  const FirmwareDownloadView({Key? key}) : super(key: key);

  @override
  State<FirmwareDownloadView> createState() => _FirmwareDownloadViewState();
}

class _FirmwareDownloadViewState extends State<FirmwareDownloadView> {
  @override
  Widget build(BuildContext context) {
    final firmwareData = Provider.of<FirmwareNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Firmwares",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/searchFirmwareView');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: FutureBuilder(
            future: firmwareData.searchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (firmwareData.firmwareModel.status == "200") {
                  return ListView.builder(
                      itemCount: firmwareData.firmwareModel.data.length,
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
                              Text(
                                firmwareData
                                    .firmwareModel.data[index]!.brandName,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                ),
                              ),
                              Consumer<FirmwareNotifier>(builder: (context, data, _) {
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
                                    firmwareData.downloadFile(pdfUrl: "https://coderzheaven.com/youtube_flutter/images.zip");
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
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content:
                          Text("Something went wrong. Please try again later."),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }),
      ),
    );
  }
}
