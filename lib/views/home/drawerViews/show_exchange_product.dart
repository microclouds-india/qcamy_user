import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/common/ui/Ui.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/exchange_product_details/exchange_product_details.notifier.dart';
import 'package:qcamyapp/views/home/drawerViews/my_orders/orders.view.dart';

class ShowExchangeProduct extends StatelessWidget {
  const ShowExchangeProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final exchangeProductDetailsData = Provider.of<ExchangeProductDetailsNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Exchange Products",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: exchangeProductDetailsData.getExchangeProductDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: exchangeProductDetailsData.exchangeProductDetailsModel!.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      decoration: Ui.getBoxDecoration(color: Colors.grey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OrderDetails(
                              name: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].name,
                              address: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].email,
                              phone: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].phone,
                              productName: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].productName,
                              productDescription: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].productDescription,
                              modelNumber: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].modelNumber),
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            height: 100,
                            width: double.infinity,
                            child: ListView.builder(
                                itemCount: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].image.data.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 10, right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration:
                                    Ui.getBoxDecoration(color: Colors.grey),
                                    child: CachedNetworkImage(
                                      imageUrl: exchangeProductDetailsData.exchangeProductDetailsModel!.data[index].image.data[i].image,
                                      placeholder: (context, url) {
                                        return Image.asset(
                                          "assets/images/png/pholder_image.jpg",
                                        );
                                      },
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) {
                                        return Image.asset(
                                          "assets/images/png/pholder_image.jpg",
                                        );
                                      },
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}

//show orderd items list
class OrderDetails extends StatelessWidget {
  const OrderDetails({
    Key? key,
    required this.name,
    required this.address,
    required this.phone,
    required this.productName,
    required this.productDescription,
    required this.modelNumber,
  }) : super(key: key);

  final String name;
  final String address;
  final String phone;
  final String productName;
  final String productDescription;
  final String modelNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderElement(
                        title: "Name",
                        value: name,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                      OrderElement(
                        title: "Address",
                        value: address,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                      OrderElement(
                        title: "Phone Number",
                        value: phone,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                      OrderElement(
                        title: "Product Name",
                        value: productName,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                      OrderElement(
                        title: "Product Description",
                        value: productDescription,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                      OrderElement(
                        title: "Model Number",
                        value: modelNumber,
                        keySize: 16,
                        valueSize: 16,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                // Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
            const Divider(color: Colors.grey),
            const OrderElement(
              title: "Status",
              value: "Submitted",
              keySize: 18,
              valueSize: 18,
            ),
          ],
        ));
  }
}
