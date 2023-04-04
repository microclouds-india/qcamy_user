import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/help/help.notifier.dart';
import 'package:qcamyapp/repository/supportQuestions/supportQuestions.notifier.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  HelpPage({Key? key}) : super(key: key);

  List<String> _locations = ['A', 'B', 'C', 'D'];

  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final supportQuestionsData = Provider.of<SupportQuestionsNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Help",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () {
            try {
              Navigator.pop(context);
            } catch (e) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "How can we help you?",
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: _questionController,
                        decoration: const InputDecoration(
                          hintText: "Have a question? Ask or enter a search term here..",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor)),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    Consumer<HelpNotifier>(builder: (context, data, _) {
                      return data.isLoading ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                      ) : Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () async {
                            if (_questionController.text.isNotEmpty) {

                              try {
                                await data.addHelpData(
                                  question: _questionController.text,
                                );
                              } on Exception {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Submitted"),
                                ));
                                showSuccess(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Submitted"),
                                ));
                                showSuccess(context);
                              }

                              try {
                                if (data.helpModel.status == "200") {
                                  showSuccess(context);
                                  _questionController.clear();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          "Something went wrong. Please try again later."),
                                    ),
                                  );
                                }
                              } catch (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        "Something went wrong. Please try again later."),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      "Fill all fields to submit"),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.openSans(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   margin: const EdgeInsets.all(8),
            //   padding: const EdgeInsets.only(left: 8, right: 8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     border: Border.all(color: Colors.grey.shade800, width: 1),
            //   ),
            //   child: DropdownButton(
            //     isExpanded: true,
            //     underline: const SizedBox(),
            //     hint: Text("Select product"),
            //     items: _locations.map((map) => DropdownMenuItem(
            //       value: map,
            //       child: Container(
            //           width: MediaQuery.of(context).size.width,
            //           padding: const EdgeInsets.only(
            //               left: 10.0,
            //               right: 10.0,
            //               top: 15.0,
            //               bottom: 15.0),
            //           decoration:
            //           Ui.getBoxDecorationProduct(
            //               color: primaryColor),
            //           child: Text(map, style: const TextStyle(color: Colors.black),)),
            //     ),
            //     ).toList(),
            //     style: const TextStyle(
            //       color: Colors.black,
            //     ),
            //     onChanged: (value) {
            //
            //     },
            //   ),
            // ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getHelpItems(
                      textHeading: "OUR MAIN OFFICE",
                      textTitle: "Address",
                      icon: Icons.location_on,
                      onTap: () {}),
                  getHelpItems(
                      textHeading: "Email",
                      textTitle: "abc@gmail.com",
                      icon: Icons.email,
                      onTap: () {}),
                ],
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getHelpItems(
                      textHeading: "Call",
                      textTitle: "Address",
                      icon: Icons.call,
                      onTap: () {
                        _makePhoneCall("tel:9999999999");
                      }),
                  getHelpItems(
                      textHeading: "Whatsapp",
                      textTitle: "+919999999999",
                      icon: Icons.whatsapp,
                      onTap: () {
                        openWhatsapp(context: context);
                      }),
                ],
              ),
            ),
            FutureBuilder(
                future: supportQuestionsData.allSupportQuestions(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (supportQuestionsData.supportQuestionsModel.data.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "All Questions and Answers",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: supportQuestionsData.supportQuestionsModel.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            "Q: ${supportQuestionsData.supportQuestionsModel.data[index].question}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            "A: ${supportQuestionsData.supportQuestionsModel.data[index].answer}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey),
                                          ),
                                          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                                        child: Text(
                                          supportQuestionsData.supportQuestionsModel.data[index].name,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  } else if (snapshot.hasError) {
                    return SizedBox();
                  }
                  return Center(
                    child: CircularProgressIndicator(
                        color: primaryColor),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> openWhatsapp({required BuildContext context}) async {
    String whatsapp = '+919999999999';
    String whatsappURlAndroid = "whatsapp://send?phone=$whatsapp&text=hello";
    String whatsappURLIos =
        "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(whatsappURLIos));
      } else {
        // _showToast(text: "whatsapp no installed");
      }
    } else {
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        // _showToast(text: "whatsapp no installed");
      }
    }
  }

  Widget getHelpItems(
      {required String textHeading,
      required String textTitle,
      required IconData icon,
      required Function() onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.grey.shade200,
              ),
            ],
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: Icon(
                  icon,
                  color: primaryColor,
                  size: 30,
                )),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Text(
                    textHeading,
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Text(
                    textTitle,
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showSuccess(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Success",
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Success.\nOur expert will contact you soon",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "OK",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
