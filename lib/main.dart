import 'package:flutter/material.dart';
import 'package:bestbybuddy/loginpage.dart';
import 'package:bestbybuddy/splash.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Gotham'),
    // routes: {
    //   '/': (context) => LoginApp(),
    //   '/splash': (context) => SplashScreen(), // Add the splash screen route
    // },
    home: SplashScreen(), // Set the SplashScreen as the initial route
  ));
}