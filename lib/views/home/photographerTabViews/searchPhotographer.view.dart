// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/book_photographer/book_photographer.notifier.dart';
import 'package:qcamyapp/repository/photographer_profile/profile.notifier.dart';
import 'package:qcamyapp/repository/search/search.notifier.dart';
import 'package:qcamyapp/widgets/searchBar.widget.dart';

import '../../../widgets/photographers_list.widget.dart';

class SearchPhotographerView extends StatelessWidget {
  const SearchPhotographerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchData = Provider.of<SearchNotifier>(context);
    final photographerData =
        Provider.of<PhotographerProfileNotifier>(context, listen: false);

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
                          hintText: "Wedding Photographer",
                          onChanged: ((value) {
                            _searchData.searchData(
                              keyword: value,
                              category: "photographers",
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
                if (data.searchModel.data.isEmpty) {
                  return Center(
                    child: Text("No Data"),
                  );
                }
                return ListView.builder(
                    itemCount: data.searchModel.data.length,
                    itemBuilder: ((context, index) {
                      return PhotographersList(
                          name: data.searchModel.data[index].name,
                          image: data.searchModel.data[index].profileImage,
                          location: data.searchModel.data[index].description
                                  .isNotEmpty
                              ? data.searchModel.data[index].description
                              : data.searchModel.data[index].location,
                          onTap: () async {
                            // print("${data.searchModel.data[index].id}");

                            await photographerData
                                .getPhotographerData(
                                    id: data.searchModel.data[index].id)
                                .then((value) {
                              //save photographer id in provider

                              Provider.of<BookPhotographerNotifier>(context,
                                          listen: false)
                                      .photographerId =
                                  data.searchModel.data[index].id.toString();
                              Navigator.pushNamed(
                                  context, "/photographerProfileView");
                            }).onError((error, stackTrace) {
                              throw error!;
                            });
                          });
                    }));
              }

              return !data.dataLoaded
                  ? Center(child: Text("No Data Found"))
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
