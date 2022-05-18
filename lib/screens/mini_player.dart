import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with SingleTickerProviderStateMixin {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('music');
  late AnimationController iconController;
  List<Audio> audio = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
  }

  String? swipeDirection;
  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderRealtimePlayingInfos(
      builder: (context, realtime) {
        int currentIndex = songs.indexWhere((element) =>
            element.id.toString() ==
            realtime.current!.audio.audio.metas.id.toString());

        realtime.isPlaying
            ? iconController.forward()
            : iconController.reverse();

        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: GestureDetector(
            onPanUpdate: (details) {
              swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
            },
            onTap: () async {
              for (var item in songs) {
                audio.add(
                  Audio.file(
                    item.uri!,
                    metas: Metas(
                      title: item.title,
                      id: item.id.toString(),
                    ),
                  ),
                );
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicDetailedPage(
                    audio: audio,
                    index: currentIndex,
                    songs: songs,
                  ),
                ),
              );
            },
            onPanEnd: (details) {
              if (swipeDirection == null) {
                return;
              }

              if (swipeDirection == 'left') {
                audioPlayer.next();
              }
              if (swipeDirection == 'right') {
                audioPlayer.previous();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 118, 113, 163),
                  Colors.black,
                ]),
                borderRadius: BorderRadius.circular(20),
              ),
              // color: Colors.green,
              width: double.infinity,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Lottie.asset('assets/lottie/voice.json',
                      width: 32, repeat: realtime.isPlaying ? true : false),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextScroll(
                      audioPlayer.getCurrentAudioTitle,
                      delayBefore: Duration(milliseconds: 500),
                      textAlign: TextAlign.center,
                      selectable: true,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(width: 45),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: GestureDetector(
                      onTap: () {
                        if (realtime.isPlaying) {
                          audioPlayer.pause();
                          iconController.reverse();
                        } else {
                          audioPlayer.play();
                          iconController.forward();
                        }
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: iconController,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
