import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFdee9f3),
      child: Center(
        child: Lottie.network(
            'https://assets4.lottiefiles.com/packages/lf20_bmqwuqs8.json'),
      ),
    );
  }
}
