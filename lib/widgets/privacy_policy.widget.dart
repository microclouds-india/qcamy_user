// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qcamyapp/config/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              style: privacyPolicyTextStyle,
              text: "By logging in, you agree to our ",
            ),
            TextSpan(
              style: privacyPolicyLinkStyle,
              text: "Privacy Policy",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  Uri url = Uri.parse('https://www.google.com');
                  await _launchUrl(url);
                },
            ),
            TextSpan(
              style: privacyPolicyTextStyle,
              text: " and ",
            ),
            TextSpan(
              style: privacyPolicyLinkStyle,
              text: "Terms of use",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  Uri url = Uri.parse('https://www.google.com');
                  await _launchUrl(url);
                },
            ),
          ],
        ),
      ),
    );
  }
}

//func to launch the url
Future<void> _launchUrl(url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
