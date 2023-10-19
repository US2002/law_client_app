import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:law_client_app/pages/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: mainPage(),
    theme: ThemeData(
      fontFamily: 'Montserrat',
    ),
    debugShowCheckedModeBanner: false,
  ));
}
