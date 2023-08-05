// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/config/providers.dart';
import 'package:qcamyapp/config/routes.dart';

import 'package:qcamyapp/views/splashscreen/splash.view.dart';

import 'views/order invoice/orderInvoice.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor)
        ),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
          // initialRoute: '/mainHomeView',
          routes: routes),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashView();
  }
}
