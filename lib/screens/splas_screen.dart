import 'package:flutter/material.dart';
import 'package:radioplayer/widgets/custom_button.dart';
import 'package:radioplayer/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _navigateToHomePage,
      child: Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "It's Your",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Radio Day",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "EXPLORE NEW PODCASTS",
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.25,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/gifs/gif.gif",
                      width: 350,
                      height: 350,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 100),
                    left: widthScreen - widthScreen / 6,
                    child: RotationTransition(
                      turns: _controller,
                      child: Image.asset(
                        "assets/images/3.png",
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: MediaQuery.of(context).size.height * 0.40,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                left: 25,
                                child: Image.asset(
                                  "assets/images/1.png",
                                  width: 500,
                                  height: 500,
                                ),
                              ),
                              Positioned(
                                right: -40,
                                bottom: 20,
                                child: Image.asset(
                                  "assets/images/2.png",
                                  width: 180,
                                  height: 180,
                                ),
                              ),
                              AnimatedPositioned(
                                duration: Duration(milliseconds: 100),
                                left: 40,
                                bottom: -80,
                                child: RotationTransition(
                                  turns: _controller,
                                  child: Image.asset(
                                    "assets/images/4.png",
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                              )
                            ],
                          ))),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 150,
                      height: 90,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: CustomButton(
                              child: Icon(
                                Icons.play_arrow,
                                size: 40,
                              ),
                              color: Colors.pink),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
