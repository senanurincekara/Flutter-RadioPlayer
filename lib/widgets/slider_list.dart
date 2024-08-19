import 'dart:async'; // Timer için gerekli import

import 'package:flutter/material.dart';
import 'package:radioplayer/Theme/Colors.dart';

class CarouselItem {
  final String imagePath;
  final Alignment alignment;
  final double width;
  final double height;
  final BoxFit fit;
  final double bottom;
  final Alignment textalignment;
  final Text text;
  final EdgeInsets textPadding;

  CarouselItem({
    required this.imagePath,
    required this.alignment,
    required this.width,
    required this.height,
    required this.bottom,
    required this.fit,
    required this.textalignment,
    required this.text,
    this.textPadding = EdgeInsets.zero,
  });
}

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  _CarouselSliderWidgetState createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _selectedIndex = 0;
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // Her 1 saniyede bir geçiş yapmak için bir timer ayarlıyoruz
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_selectedIndex < 3) {
        _selectedIndex++;
      } else {
        _selectedIndex = 0;
      }

      _pageController.animateToPage(
        _selectedIndex,
        duration: Duration(milliseconds: 400), // Geçiş hızı
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        _carouselSliderList(),
        _buildIndicatorDots(),
      ],
    );
  }

  Widget _carouselSliderList() {
    final List<CarouselItem> carouselItems = [
      CarouselItem(
        imagePath: 'assets/images/6.png',
        alignment: Alignment.bottomLeft,
        width: 210,
        height: 150,
        fit: BoxFit.fill,
        bottom: 15.0,
        text: Text(
          "With\nAmanda Keller\n🕒 1:25 PM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        textalignment: Alignment.centerRight,
        textPadding: EdgeInsets.all(25.0),
      ),
      CarouselItem(
        imagePath: 'assets/images/7.png',
        alignment: Alignment.bottomRight,
        width: 190,
        height: 200,
        fit: BoxFit.fill,
        bottom: 5.0,
        text: Text(
          "Fun hours with\nTom Joyner\n🕒 3:45 PM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        textalignment: Alignment.centerLeft,
        textPadding: EdgeInsets.only(left: 30),
      ),
      CarouselItem(
        imagePath: 'assets/images/8.png',
        alignment: Alignment.bottomLeft,
        width: 180,
        height: 180,
        fit: BoxFit.fill,
        bottom: 0.0,
        text: Text(
          "Now Streaming\nKen Bruce\n🕒 3:45 PM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        textalignment: Alignment.centerRight,
        textPadding: EdgeInsets.all(25.0),
      ),
      CarouselItem(
        imagePath: 'assets/images/9.png',
        alignment: Alignment.bottomRight,
        width: 180,
        height: 160,
        fit: BoxFit.fill,
        bottom: 5.0,
        text: Text(
          "Sing with\nDelilah\nTomorrow\n🕒1:45 PM",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        textalignment: Alignment.centerLeft,
        textPadding: EdgeInsets.only(left: 30),
      ),
    ];

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            color: Colors.transparent,
            height: 180,
            child: PageView.builder(
              controller: _pageController,
              itemCount: carouselItems.length,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final item = carouselItems[index];
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 8),
                        width: MediaQuery.of(context).size.width * 0.74,
                        height: 150,
                        decoration: BoxDecoration(
                          color: containerbgColor,
                          border: Border.all(width: 1, color: black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: containerColor,
                        border: Border.all(width: 1, color: black),
                      ),
                      child: Padding(
                        padding: item.textPadding,
                        child: Align(
                          alignment: item.textalignment,
                          child: item.text,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: item.bottom),
                      child: Align(
                        alignment: item.alignment,
                        child: Image.asset(
                          item.imagePath,
                          fit: item.fit,
                          width: item.width,
                          height: item.height,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorDots() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4, // The number of dots should match the number of carousel items
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            width: _selectedIndex == index ? 22.0 : 10.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: _selectedIndex == index ? dotColor : blue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: black),
            ),
          ),
        ),
      ),
    );
  }
}
