import 'package:flutter/material.dart';
import 'package:bestbybuddy/view_menu.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Gotham'),
    routes: {
      '/': (context) => ViewMenu(),
    },
    //theme: ThemeData(fontFamily: 'GothamBook'),

  ));
}

