import 'package:flutter/material.dart';
import 'package:law_client_app/pages/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    home: splashScreen(),
    theme: ThemeData(
      fontFamily: 'Montserrat',
    ),
    debugShowCheckedModeBanner: false,
  ));
}
