import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/authentication/auth.notifier.dart';

class MobileAuthView extends StatefulWidget {
  const MobileAuthView({Key? key}) : super(key: key);

  @override
  State<MobileAuthView> createState() => _MobileAuthViewState();
}

class _MobileAuthViewState extends State<MobileAuthView> {
  final TextEditingController _mobileNumberController = TextEditingController();

  final ValueNotifier<bool> _numberIsFull = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/images/png/authscreen_logo.png"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                child: const Text(
                  "Enter your phone number to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: _numberIsFull,
                  builder: (context, index, _) {
                    return Container(
                      margin: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _numberIsFull.value ? primaryColor : grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "+91",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Expanded(
                            child: Consumer<AuthNotifier>(
                                builder: (context, data, _) {
                              return TextField(
                                controller: _mobileNumberController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLines: 1,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 19),
                                cursorColor: Colors.black,
                                onChanged: (text) {
                                  data.mobileNumber = text;
                                  if (data.mobileNumber.length == 10) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    _numberIsFull.value = true;
                                  } else {
                                    _numberIsFull.value = false;
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: data.isLoading
                                      ? Transform.scale(
                                          scale: 0.5,
                                          child:
                                              const CircularProgressIndicator(
                                            color: primaryColor,
                                          ),
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 22,
                                            color: _numberIsFull.value
                                                ? primaryColor
                                                : grey,
                                          ),
                                          onPressed: () async {
                                            if (_numberIsFull.value) {
                                              try {
                                                await data.loginUser(
                                                    mobileNumber:
                                                        data.mobileNumber);

                                                if (data.authModel.status ==
                                                        "200" &&
                                                    data.authModel.user ==
                                                        "exist user") {
                                                  Navigator.pushNamed(context,
                                                      "/verifyOTPView");
                                                } else if (data
                                                            .authModel.status ==
                                                        "200" &&
                                                    data.authModel.user ==
                                                        "new user") {
                                                  Navigator.pushNamed(context,
                                                      "/profileSetupView");
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(data
                                                          .authModel.response),
                                                    ),
                                                  );
                                                }
                                              } catch (e) {
                                                // print(e);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor: Colors.red,
                                                    content:
                                                        Text("Network error!"),
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                  counterText: "",
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(15),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          height: kBottomNavigationBarHeight,
          child: Center(
            child: Text(
              "Powered by microclouds",
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 2,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
