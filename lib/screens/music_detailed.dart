import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/functions/delete_songs.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/add_playlist.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../../functions/add_to_favourite.dart';

final OnAudioQuery audioQuery = OnAudioQuery();
final OnAudioRoom audioRoom = OnAudioRoom();

class MusicDetailedPage extends StatefulWidget {
  MusicDetailedPage(
      {required this.audio, required this.index, this.songs, Key? key})
      : super(key: key);
  List<Audio> audio = [];

  List<SongModel>? songs = [];
  int index;

  @override
  State<MusicDetailedPage> createState() => _MusicDetailedPageState();
}

class _MusicDetailedPageState extends State<MusicDetailedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  final player = AssetsAudioPlayer.withId('music');
  bool isButtonDisabled = false;
  final playlists = OnAudioRoom().queryPlaylists();
  bool isSongAdded = false;

  bool play = false;

  @override
  void initState() {
    super.initState();

    if (player.isPlaying.value &&
        player.getCurrentAudioTitle == widget.audio[widget.index].metas.title) {
      null;
    } else {
      player.open(Playlist(audios: widget.audio, startIndex: widget.index),
          loopMode: LoopMode.playlist,
          autoStart: true,
          showNotification: true,
          notificationSettings:
              NotificationSettings(customPlayPauseAction: (players) {
            if (players.isPlaying.value) {
              player.pause();
              iconController.reverse();
            } else {
              player.play();
              iconController.forward();
            }
          }, customNextAction: (player) {
            if (player.isPlaying.value) {
              iconController.forward();
              player.next();
              player.play();
            }
          }, customPrevAction: (player) {
            if (player.isPlaying.value) {
              iconController.forward();
              player.previous();
            }
          }));
    }

    iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));

    adddedtoFavOrNot(widget.index);
  }

  adddedtoFavOrNot(int index) async {
    isSongAdded = await onAudioRoom.checkIn(
      RoomType.FAVORITES,
      widget.songs![index].id,
    );
    setState(() {});
  }

  // int compareIndex = 0;
  bool onPressedPrevValue = true;
  bool onPressedNextValue = true;
  @override
  Widget build(BuildContext context) {
    List<PlaylistEntity> playlists = [];

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.expand_more_outlined),
                  iconSize: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 213),
                player.builderRealtimePlayingInfos(
                  builder: (context, realtimePlayingInfos) => IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayListScreen(
                            songIndex: realtimePlayingInfos.current!.index,
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 33,
                  ),
                ),
              ],
            ),
          ),
          player.builderRealtimePlayingInfos(
              builder: (context, RealtimePlayingInfos realtimePlayingInfos) {
            int currentIndex = realtimePlayingInfos.current!.index;

            adddedtoFavOrNot(currentIndex);
            return Container(
              margin: EdgeInsets.only(left: 26, top: 20, right: 26),
              child: Column(
                children: [
                  leadingImage(widget.songs![currentIndex].id),
                  SizedBox(height: 30),
                  
                  SizedBox(
                    height: 25,
                    width: 260,
                    child: player.isPlaying.value
                        ? Marquee(
                            text: player.getCurrentAudioTitle,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            // pauseAfterRound: Duration(seconds: 1),
                            crossAxisAlignment: CrossAxisAlignment.center,
                            blankSpace: 23,
                            startPadding: 100,
                          )
                        : Text(
                            player.getCurrentAudioTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                  SizedBox(height: 16),
                  // Lottie.asset('assets/lottie/visualizer.json',
                  //     animate: player.isPlaying.value ? true : false),
                  slider(context, realtimePlayingInfos),
                  SizedBox(
                    height: 40,
                  ),
                  buildNextAndPausePreviousButton(currentIndex),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (realtimePlayingInfos.loopMode ==
                              LoopMode.single) {
                            player.setLoopMode(LoopMode.none);
                          } else {
                            player.setLoopMode(LoopMode.single);
                          }
                        },
                        icon: Icon(
                          Icons.repeat_rounded,
                          color:
                              realtimePlayingInfos.loopMode == LoopMode.single
                                  ? Colors.green
                                  : Colors.white,
                        ),
                        iconSize: 28,
                      ),
                      IconButton(
                        onPressed: () {
                          // int songINdex = songs.indexWhere((element) =>
                          //     element.title == songs[currentIndex].title);

                          if (isSongAdded) {
                            deleteSong(widget.songs![currentIndex].id);

                            ScaffoldMessenger.of(context)
                              ..removeCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(
                                    'Song removed from Favourite ${songs[currentIndex].title}',
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 213, 27, 27),
                                ),
                              );
                          } else {
                            setState(() {
                              addtoFavourtie(context, currentIndex);
                            });
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: isSongAdded ? Colors.pink : Colors.white,
                        ),
                        iconSize: 28,
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ]),
      ),
    );
  }

  Row buildNextAndPausePreviousButton(int currentIndex) {
    return Row(children: [
      SizedBox(width: 45),
      IconButton(
        onPressed: onPressedPrevValue
            ? () {
                iconController.forward();
                setState(() {
                  onPressedPrevValue = false;
                  player.previous();
                });
                Timer(Duration(milliseconds: 1200), () {
                  setState(() {
                    onPressedPrevValue = true;
                    iconController.reverse();
                  });
                });
              }
            : () {
                // print('ddddddddddddddddd');
              },
        icon: Icon(Icons.skip_previous),
        iconSize: 48,
      ),
      const SizedBox(
        width: 20,
      ),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color.fromRGBO(255, 255, 255, 1)),
        child:
            player.builderRealtimePlayingInfos(builder: (contex, realTimeInfo) {
          if (realTimeInfo.isPlaying) {
            iconController.forward();
          }

          return GestureDetector(
            onTap: () {
              if (realTimeInfo.isPlaying) {
                player.pause();
                iconController.reverse();
              } else {
                player.play();
                iconController.forward();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: iconController,
              color: Colors.black,
              size: 55,
            ),
          );
        }),
      ),
      const SizedBox(
        width: 20,
      ),
      IconButton(
        onPressed: onPressedNextValue
            ? () {
                iconController.forward();
                setState(() {
                  onPressedNextValue = false;
                  player.next();
                });
                Timer(Duration(milliseconds: 1200), () {
                  setState(() {
                    onPressedNextValue = true;
                    iconController.reverse();
                  });
                });
              }
            : () {},
        icon: Icon(Icons.skip_next),
        iconSize: 48,
      ),
    ]);
  }

  Widget slider(context, realtime) {
    return Column(children: [
      greenSlider(realtime.currentPosition.inSeconds.toDouble(),
          realtime.duration.inSeconds.toDouble()),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            player.builderCurrentPosition(builder: (context, duration) {
              return Text(
                getTimeString(duration.inMilliseconds),
                style: TextStyle(color: Colors.white),
              );
            }),
            Text(
              getTimeString(realtime.duration.inMilliseconds),
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      )
    ]);
  }

  greenSlider(double value1, double value2) {
    // value2 > 0 ? value2 : 0;
    // value1 > 0 ? value1 : 0;

    try {
      return Slider(
          thumbColor: Color.fromARGB(255, 22, 181, 27),
          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          value: value1,
          min: 0,
          max: value2,
          onChanged: (value1) {
            seektoseconds(value1.toDouble());
          });
    } catch (e) {
      return Slider(
          thumbColor: Color.fromARGB(255, 22, 181, 27),
          activeColor: Colors.green,
          inactiveColor: Colors.grey,
          value: 0,
          min: 0,
          max: 0,
          onChanged: (value1) {
            // seektoseconds(value1.toDouble());
          });
    }
  }

  seektoseconds(double sec) {
    Duration pos = Duration(seconds: sec.toInt());
    player.seek(pos);
  }

  getTimeString(int millisecond) {
    if (millisecond == null) millisecond = 0;
    String minute =
        "${(millisecond / 60000).floor() < 10 ? 0 : ''}${(millisecond / 60000).floor()}";

    String second =
        "${(millisecond / 1000).floor() % 60 < 10 ? 0 : ''}${(millisecond / 1000).floor() % 60}";

    return "$minute:$second";
  }

  leadingImage(int id) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: QueryArtworkWidget(
          id: id,
          type: ArtworkType.AUDIO,
          artworkWidth: 260,
          artworkHeight: 250,
          keepOldArtwork: true,
          artworkBorder: BorderRadius.circular(0),
          nullArtworkWidget: SizedBox(
            height: 250,
            width: 260,
            child: Image.asset(
              image2,
              fit: BoxFit.fill,
            ),
          )),
    );
  }
}
