import 'package:flutter/material.dart';
import 'package:qcamyapp/config/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Navigator.pushNamed(context, '/mobileAuthView');
      Navigator.pushReplacementNamed(context, '/mainHomeView');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/png/qclogo.png",
          height: 100,
        ),
      ),
    );
  }
}
