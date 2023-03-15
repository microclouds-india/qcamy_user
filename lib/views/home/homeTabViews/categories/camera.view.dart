// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:qcamyapp/config/colors.dart';
// import 'package:qcamyapp/repository/accessories/accessories.notifier.dart';
// import 'package:qcamyapp/repository/productsDetails/product_details.notifier.dart';
// import 'package:qcamyapp/views/home/homeTabViews/categories/accessories.view.dart';

// class CameraView extends StatelessWidget {
//   const CameraView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final accessoriesData = Provider.of<AccessoriesNotifier>(context);

//     final productData =
//         Provider.of<ViewProductNotifier>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Cameras",
//           style: GoogleFonts.openSans(
//               fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: Colors.black,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: FutureBuilder(
//           future: accessoriesData.getAccessories(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return accessoriesData.accessoriesModel.data.isNotEmpty
//                   ? GridView.builder(
//                       itemCount: accessoriesData.accessoriesModel.data.length,
//                       shrinkWrap: true,
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           mainAxisExtent: 250, crossAxisCount: 2),
//                       itemBuilder: ((context, index) {
//                         return EquipmentsList(
//                           image: accessoriesData
//                               .accessoriesModel.data[index].image
//                               .toString(),
//                           name: accessoriesData
//                               .accessoriesModel.data[index].productName,
//                           price: accessoriesData
//                               .accessoriesModel.data[index].price,
//                           discount: accessoriesData
//                               .accessoriesModel.data[index].discountPercentage,
//                           onTap: () {
//                             productData.productId =
//                                 accessoriesData.accessoriesModel.data[index].id;
//                             Navigator.of(context)
//                                 .pushNamed("/offerProductDetailsView");
//                           },
//                         );
//                       }))
//                   : Center(
//                       child: Text("No items"),
//                     );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Something went wrong"),
//               );
//             }
//             return Center(
//                 child: CircularProgressIndicator(color: primaryColor));
//           }),
//     );
//   }
// }
