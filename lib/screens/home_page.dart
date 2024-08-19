import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radioplayer/Theme/Colors.dart';
import 'package:radioplayer/screens/player_screen.dart';
import 'package:radioplayer/widgets/custom_button.dart';
import 'package:radioplayer/widgets/slider_list.dart';

class playerItems {
  final String imagePath;
  final String songPath;
  final String streamName;
  final String channelName;

  playerItems(
      {required this.imagePath,
      required this.songPath,
      required this.streamName,
      required this.channelName});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<playerItems> playeritems = [
    playerItems(
        imagePath: 'assets/images/10.svg',
        songPath: 'radioPlayers/song1.mp3',
        streamName: 'cozy day with us',
        channelName: 'LOFI'),
    playerItems(
        imagePath: 'assets/images/11.svg',
        songPath: 'radioPlayers/song2.mp3',
        streamName: 'News/Talk',
        channelName: 'NPR'),
    playerItems(
        imagePath: 'assets/images/12.svg',
        songPath: 'radioPlayers/song1.mp3',
        streamName: 'Talk/music',
        channelName: 'Soho Radio'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          _headerRow(),
          CarouselSliderWidget(),
          SizedBox(
            height: 20,
          ),
          _carouselSlider()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            backgroundColor: black.withOpacity(0.8),
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            elevation: 2,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 40,
                  color: white,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search_outlined,
                  size: 40,
                  color: white,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.space_dashboard_rounded,
                  size: 40,
                  color: white,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 40,
                  color: white,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerRow() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 40, right: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/avatar.png"),
                radius: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "User Name \nSurname",
                style: TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              color: black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(width: 5, color: textBorder)),
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Text(
                "TOP CHANNELS",
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: CarouselSlider.builder(
            itemCount: playeritems.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        playerItem: playeritems[index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: 290,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(width: 4, color: black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: SvgPicture.asset(
                              playeritems[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      left: 0,
                      child: CustomButton(
                        child: Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: sliderIcon,
                        ),
                        color: sliderButton,
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 300.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
}
