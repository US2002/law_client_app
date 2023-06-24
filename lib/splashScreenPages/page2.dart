import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1f5573),
      child: Center(
          child: Lottie.network(
              'https://assets9.lottiefiles.com/packages/lf20_zntl98s1.json')),
    );
  }
}
