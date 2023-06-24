import 'package:flutter/material.dart';
import 'package:law_client_app/pages/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../splashScreenPages/page1.dart';
import '../splashScreenPages/page2.dart';
import '../splashScreenPages/page3.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  bool onLastPage = false;

  PageController _controller = PageController();

  Future navigateToHomePage(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MyLogin();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //!Body
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            page1(),
            page2(),
            page3(),
          ],
        ),
        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                label: const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ), // <-- Text
                backgroundColor: Colors.yellow,
                icon: const Icon(
                  // <-- Icon
                  Icons.start,
                  color: Colors.black,
                  size: 24.0,
                ),
                onPressed: () {
                  _controller.jumpToPage(2);
                },
              ),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thinUnderground,
                ),
              ),
              onLastPage
                  ? FloatingActionButton.extended(
                      label: const Text(
                        'Justice',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ), // <-- Text
                      backgroundColor: Colors.yellow,
                      icon: const Icon(
                        // <-- Icon
                        Icons.menu_book_sharp,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      onPressed: () {
                        navigateToHomePage(context);
                      },
                    )
                  : FloatingActionButton.extended(
                      icon: const Icon(
                        // <-- Icon
                        Icons.skip_next,
                        color: Colors.black,
                        size: 24.0,
                      ),
                      label: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ), // <-- Text
                      backgroundColor: Colors.yellow,
                      onPressed: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    )
            ],
          ),
        )
      ],
    ));
  }
}
