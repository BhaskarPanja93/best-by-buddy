import 'package:flutter/material.dart';
import 'package:bestbybuddy/loginpage.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Gotham'),
    routes: {
      '/': (context) => LoginApp(),
    },
    //theme: ThemeData(fontFamily: 'GothamBook'),

  ));
}

