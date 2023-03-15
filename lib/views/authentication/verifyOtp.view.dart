import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/core/token_storage/storage.dart';
import 'package:qcamyapp/repository/authentication/auth.notifier.dart';
import 'package:qcamyapp/repository/otp%20verification/otpVerification.notifier.dart';
import 'package:qcamyapp/widgets/booking_button.widget.dart';

class VerifyOTPView extends StatefulWidget {
  const VerifyOTPView({Key? key}) : super(key: key);

  @override
  State<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends State<VerifyOTPView> {
  @override
  Widget build(BuildContext context) {
    final _mobileAuthNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    final _otpNotifier = Provider.of<OTPNotifier>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 80, right: 80),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.black),
                onChanged: (otp) {
                  _otpNotifier.otp = otp;
                },
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                    activeColor: secondaryColor,
                    inactiveColor: Colors.black,
                    selectedColor: grey),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Consumer<OTPNotifier>(builder: (context, data, _) {
                  return data.isLoading
                      ? const CircularProgressIndicator(color: primaryColor)
                      : BookingButton(
                          text: "Verify",
                          onTap: () async {
                            try {
                              if (data.otp.length == 4) {
                                await _otpNotifier.verifyOTP(
                                  mobileNumber:
                                      _mobileAuthNotifier.mobileNumber,
                                  otp: data.otp,
                                );

                                if (data.verifyOtpModel.status == "200") {
                                  //store token in local storage
                                  LocalStorage _localStorage = LocalStorage();
                                  await _localStorage
                                      .setToken(data.verifyOtpModel.token);
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      '/mainHomeView', (route) => false);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content:
                                          Text(data.verifyOtpModel.response),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    content: Text("Please enter 4 digit OTP"),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  content: Text("Please enter 4 digit OTP"),
                                ),
                              );
                            }

                            // Navigator.pushNamed(context, '/mainHomeView');
                          });
                })),
          ],
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
