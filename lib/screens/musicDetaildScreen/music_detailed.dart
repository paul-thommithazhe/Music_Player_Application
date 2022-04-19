import 'package:flutter/material.dart';
import 'package:music_player/images.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:music_player/screens/addPlaylistScreen/add_playlist.dart';
import 'package:provider/provider.dart';

class MusicDetailedPage extends StatelessWidget {
  MusicDetailedPage({Key? key}) : super(key: key);
  
  bool currentPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 40,
            top: 30.0,
            right: 40,
            bottom: 10,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.expand_more_outlined),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayListScreen()));
                    },
                    icon: const Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 30,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                height: 250,
                width: 250,
                child: Image.asset(
                  image2,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 30),
              const Text(
                "Baby Boo...",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 30),
              const ProgressBar(
                timeLabelPadding: 10,
                timeLabelTextStyle: TextStyle(color: Colors.white),
                total: Duration(milliseconds: 5000),
                progress: Duration(milliseconds: 1000),
                baseBarColor: Colors.grey,
                thumbGlowColor: Color.fromARGB(255, 183, 232, 186),
                thumbGlowRadius: 17.0,
                progressBarColor: Colors.green,
                thumbColor: Colors.green,
              ),
              SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ),
                  iconSize: 48,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    iconSize: 48,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ),
                  iconSize: 48,
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shuffle,
                      // color: Colors.white,
                    ),
                    iconSize: 28,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline,
                     
                    ),
                    iconSize: 28,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
