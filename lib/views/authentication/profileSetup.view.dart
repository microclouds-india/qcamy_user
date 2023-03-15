// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/authentication/auth.notifier.dart';
import 'package:qcamyapp/repository/otp%20verification/otpVerification.notifier.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameTextController = TextEditingController();
    final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _otpTextController = TextEditingController();
    final ValueNotifier<int> _genderNotifier = ValueNotifier<int>(0);

    final _mobileAuthNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final _otpNotifier = Provider.of<OTPNotifier>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Verify the OTP sent to\n",
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: "+91${_mobileAuthNotifier.mobileNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Text("Complete your profile",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            SizedBox(height: 25),
            UserInfoTextField(
              title: "Enter your name",
              controller: _nameTextController,
            ),
            SizedBox(height: 10),
            UserInfoTextField(
              title: "Enter your email",
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            Text(
              "Select your gender",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            ValueListenableBuilder(
                valueListenable: _genderNotifier,
                builder: (context, data, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _genderNotifier.value = 1;
                            },
                            icon: Icon(Icons.male, size: 32),
                            color: _genderNotifier.value == 1
                                ? primaryColor
                                : Colors.grey,
                          ),
                          Text("MALE",
                              style: GoogleFonts.openSans(
                                color: _genderNotifier.value == 1
                                    ? primaryColor
                                    : Colors.grey,
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _genderNotifier.value = 2;
                            },
                            icon: Icon(Icons.female, size: 32),
                            color: _genderNotifier.value == 2
                                ? primaryColor
                                : Colors.grey,
                          ),
                          Text("FEMALE",
                              style: GoogleFonts.openSans(
                                color: _genderNotifier.value == 2
                                    ? primaryColor
                                    : Colors.grey,
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              _genderNotifier.value = 3;
                            },
                            icon: Icon(Icons.transgender, size: 32),
                            color: _genderNotifier.value == 3
                                ? primaryColor
                                : Colors.grey,
                          ),
                          Text("OTHER",
                              style: GoogleFonts.openSans(
                                color: _genderNotifier.value == 3
                                    ? primaryColor
                                    : Colors.grey,
                              )),
                        ],
                      ),
                    ],
                  );
                }),
            SizedBox(height: 20),
            UserInfoTextField(
              title: "Enter OTP",
              controller: _otpTextController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 4,
              onChanged: (otp) {
                _otpNotifier.otp = otp;
              },
            ),
            SizedBox(height: 50),
            Consumer<OTPNotifier>(builder: (context, data, _) {
              return data.isLoading
                  ? Center(
                      heightFactor: 1,
                      widthFactor: 1,
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    )
                  : BookingButton(
                      text: "Continue",
                      onTap: () async {
                        try {
                          if (data.otp.length == 4 &&
                              _otpTextController.text.length == 4 &&
                              _nameTextController.text.isNotEmpty &&
                              _emailTextController.text.isNotEmpty &&
                              _genderNotifier.value != 0) {
                            await _otpNotifier.verifyOTPForNewUser(
                              mobileNumber: _mobileAuthNotifier.mobileNumber,
                              otp: data.otp,
                              name: _nameTextController.text,
                              email: _emailTextController.text,
                              gender: _genderNotifier.value == 1
                                  ? "MALE"
                                  : "FEMALE",
                            );

                            if (data.verifyOtpModel.status == "200") {
                              //store token in local storage
                              LocalStorage _localStorage = LocalStorage();
                              await _localStorage
                                  .setToken(data.verifyOtpModel.token);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/mainHomeView', (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text(data.verifyOtpModel.response),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                content:
                                    Text("Fill all the fields to continue"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text("Something went wrong"),
                            ),
                          );
                        }

                        // Navigator.pushNamed(context, '/mainHomeView');
                      });
            }),
          ],
        ),
      ),
    );
  }
}

class UserInfoTextField extends StatelessWidget {
  const UserInfoTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title*",
          style: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 5),
        TextField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          controller: controller,
          maxLength: maxLength,
          onChanged: onChanged,
          style: GoogleFonts.inder(
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            counterText: "",
            hintText: "Type here",
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
