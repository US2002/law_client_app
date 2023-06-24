import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE8DACC),
      child: Lottie.network(
          'https://assets7.lottiefiles.com/packages/lf20_b5pIHpdvW9.json'),
    );
  }
}
