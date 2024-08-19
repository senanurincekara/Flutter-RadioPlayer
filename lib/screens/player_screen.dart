import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:radioplayer/Theme/Colors.dart';
import 'package:radioplayer/provider/playlist_provider.dart';
import 'package:radioplayer/screens/home_page.dart';

class PlayerScreen extends StatefulWidget {
  final playerItems playerItem;

  const PlayerScreen({super.key, required this.playerItem});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late PlayListProvider playListProvider;

  @override
  void initState() {
    super.initState();
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
    playListProvider.play(widget.playerItem.songPath);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<PlayListProvider>(
      builder: (context, playListProvider, child) {
        return Scaffold(
          backgroundColor: bgColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _appbar(),
                SizedBox(
                  height: 15,
                ),
                _albumPic(screenHeight, screenWidth),
                SizedBox(height: 20),
                _playerItems(playListProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _albumPic(double screenHeight, double screenWidth) {
    return Container(
      color: Colors.transparent,
      height: screenHeight / 1.6,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: screenHeight / 1.7,
              decoration: BoxDecoration(
                color: sliderButton,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 8, color: black),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight / 1.7,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  color: box,
                  border: Border.all(width: 8, color: black),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: screenHeight / 2.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 5, color: black),
                        ),
                        child: SvgPicture.asset(
                          widget.playerItem.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.playerItem.channelName,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 25,
                                fontFamily: 'Times New Roman'),
                          ),
                          Text(
                            widget.playerItem.streamName,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                fontFamily: 'Times New Roman'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            right: -15,
            child: Image.asset(
              "assets/gifs/gif2.gif",
              width: 150,
              height: 150,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_sharp,
            color: black,
          ),
        ),
        SizedBox(width: 25),
        Text(
          "R A D I O  T I M E",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ],
    );
  }

  Widget _playerItems(PlayListProvider playListProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${playListProvider.currentDuration.inMinutes}:${(playListProvider.currentDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 5)),
                    child: Slider(
                      min: 0,
                      max: playListProvider.totalDuration.inSeconds.toDouble(),
                      value:
                          playListProvider.currentDuration.inSeconds.toDouble(),
                      onChanged: (value) {
                        playListProvider.seek(Duration(seconds: value.toInt()));
                      },
                      activeColor: textColor,
                      thumbColor: textBorder,
                    ),
                  ),
                ),
                Text(
                  "${playListProvider.totalDuration.inMinutes}:${(playListProvider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: sliderButton,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(width: 2, color: black),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: black),
                      ),
                      child: Icon(
                        Icons.star,
                        color: containerColor,
                        size: 20,
                      )),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.skip_previous,
                            size: 25, color: white.withOpacity(0.6)),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: playListProvider.isPlaying
                            ? Icon(Icons.pause,
                                size: 35, color: white.withOpacity(0.6))
                            : Icon(Icons.play_arrow,
                                size: 35, color: white.withOpacity(0.6)),
                        onPressed: () {
                          playListProvider.pauseOrResume();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next,
                            size: 25, color: white.withOpacity(0.6)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: bgColor,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: black),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: containerColor,
                        size: 20,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
