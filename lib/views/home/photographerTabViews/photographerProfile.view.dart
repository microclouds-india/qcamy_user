// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/widgets/view_image.widget.dart';
import 'package:simple_url_preview_v2/simple_url_preview.dart';
// import 'package:simple_url_preview/simple_url_preview.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../../../repository/book_photographer/book_photographer.notifier.dart';
import '../../../repository/photographer_profile/profile.notifier.dart';

class PhotographerProfileView extends StatefulWidget {
  const PhotographerProfileView({Key? key}) : super(key: key);

  @override
  State<PhotographerProfileView> createState() =>
      _PhotographerProfileViewState();
}

String noImagePic =
    "https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg";

class _PhotographerProfileViewState extends State<PhotographerProfileView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const double coverImgSize = 200;
    const double profileImgSize = 80;
    const profileImgPos = coverImgSize - profileImgSize;

    TabController _tabController = TabController(length: 2, vsync: this);
    final ValueNotifier<int> _tabIndexNotifier = ValueNotifier(0);

    //update the colors of icon and text in tab bar
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            _tabIndexNotifier.value = 0;

            break;
          case 1:
            _tabIndexNotifier.value = 1;
            break;
        }
      }
    });
    final photographerData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);

    return FutureBuilder(
        future: photographerData.getPhotographerData(
            id: Provider.of<BookPhotographerNotifier>(context, listen: false)
                .photographerId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                photographerData.photographerProfileModel.data[0].name,
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
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
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Container(
                    margin: EdgeInsets.only(bottom: profileImgSize * 1.3),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: Image.network(
                            photographerData.photographerProfileModel.data[0]
                                    .coverImage.isNotEmpty
                                ? photographerData
                                    .photographerProfileModel.data[0].coverImage
                                : "https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img/https://www.stefanrinck.de/wp-content/themes/miyazaki/assets/images/default-fallback-image.png",
                            width: double.infinity,
                            height: coverImgSize,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: profileImgPos,
                          child: CircleAvatar(
                            radius: profileImgSize,
                            backgroundColor: Colors.grey.shade800,
                            backgroundImage: photographerData
                                    .photographerProfileModel
                                    .data[0]
                                    .profileImage
                                    .isNotEmpty
                                ? NetworkImage(
                                    photographerData.photographerProfileModel
                                        .data[0].profileImage,
                                  )
                                : NetworkImage(noImagePic),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        photographerData
                            .photographerProfileModel.data[0].category,
                        style: GoogleFonts.robotoMono(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      // SizedBox(height: 5),
                      // Text(
                      //   "₹${photographerData.photographerProfileModel.data[0].fee}/${photographerData.photographerProfileModel.data[0].feeType}",
                      //   style: GoogleFonts.robotoMono(
                      //       fontSize: 18, fontWeight: FontWeight.w500),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: 10),
                      Text(
                        "About",
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        photographerData.photographerProfileModel.data[0]
                                .description.isNotEmpty
                            ? photographerData
                                .photographerProfileModel.data[0].description
                            : "",
                        style: GoogleFonts.openSans(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: grey, width: 2)),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/bookPhotographerView');
                          },
                          elevation: 0,
                          child: Text(
                            "BOOK NOW",
                            style: TextStyle(letterSpacing: 2),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {
                            url_launcher.launchUrl(Uri.parse(
                                "tel:+91${photographerData.photographerProfileModel.data[0].phone}"));
                          },
                          color: primaryColor,
                          elevation: 0,
                          child: Text(
                            "CONTACT",
                            style: TextStyle(
                                letterSpacing: 2, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ValueListenableBuilder(
                    valueListenable: _tabIndexNotifier,
                    builder: (context, index, _) {
                      return TabBar(
                        indicatorColor: primaryColor,
                        controller: _tabController,
                        indicatorWeight: 4,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.photo_outlined,
                                  color: index == 0
                                      ? primaryColor
                                      : Colors.grey.shade800,
                                  size: 28,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Photos",
                                  style: TextStyle(
                                      color: index == 0
                                          ? primaryColor
                                          : Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.link,
                                  color: index == 1
                                      ? primaryColor
                                      : Colors.grey.shade800,
                                  size: 28,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Links",
                                  style: TextStyle(
                                      color: index == 1
                                          ? primaryColor
                                          : Colors.grey.shade800,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                ValueListenableBuilder(
                    valueListenable: _tabIndexNotifier,
                    builder: (context, index, _) {
                      return IndexedStack(
                        index: _tabIndexNotifier.value,
                        children: [
                          Column(
                            children: [
                              photographerData
                                      .photographerProfileModel.image.isNotEmpty
                                  ? TabViews(
                                      imageList: photographerData
                                          .photographerProfileModel.image,
                                    )
                                  : Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text("No Images"),
                                    ),
                            ],
                          ),
                          Column(
                            children: [
                              photographerData
                                      .photographerProfileModel.links.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: photographerData
                                          .photographerProfileModel
                                          .links
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) {
                                        return SimpleUrlPreview(
                                          url: photographerData
                                              .photographerProfileModel
                                              .links[index]
                                              .link,
                                          previewHeight: 150,
                                          titleStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          descriptionStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                          siteNameStyle: TextStyle(
                                            fontSize: 14,
                                            color: primaryColor,
                                          ),
                                          bgColor: Colors.white,
                                        );

//

                                        // Text(photographerData
                                        //     .photographerProfileModel
                                        //     .links[index]
                                        //     .link);
                                      }))
                                  : Container(
                                      height: 100,
                                      alignment: Alignment.center,
                                      child: Text("No Links"),
                                    ),
                            ],
                          ),
                        ],
                      );
                    })
              ],
            ),
          );
        });
  }
}

class TabViews extends StatelessWidget {
  final List imageList;
  const TabViews({Key? key, required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      mainAxisSpacing: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: imageList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            child: GestureDetector(
              onTap: () {
                //show image in full screen
                if (imageList[index].image.isNotEmpty) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return ViewImage(imageLink: imageList[index].image);
                  })));
                }
              },
              child: Image.network(
                imageList[index].image,
                fit: BoxFit.cover,
                errorBuilder: ((context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                  );
                }),
              ),
            ),
          ),
        );
      },
      staggeredTileBuilder: (int index) {
        return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
      },
    );
  }
}
