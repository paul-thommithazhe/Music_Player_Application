import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/functions/delete_songs.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../images.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final onAudioRoom = OnAudioRoom();

  List<Audio> songAudio = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favourite Songs'),
          centerTitle: true,
          backgroundColor: Color(0xFF181722),
        ),
        body: FutureBuilder<List<FavoritesEntity>>(
          future: onAudioRoom.queryFavorites(),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (item.data!.isEmpty) {
              return Center(
                child: Text(
                  'No Songs',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            List<FavoritesEntity> favorites = item.data!;
            return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (contex, favindex) {
                  return ListTile(
                    leading: QueryArtworkWidget(
                      id: favorites[favindex].id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: 50,
                      artworkHeight: 70,
                      artworkBorder: BorderRadius.circular(3),
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(image6), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(3)),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    onTap: () {
                      for (var item in favorites) {
                        songAudio.add(Audio.file(item.lastData.toString(),
                                metas: Metas(
                                  title: item.title,
                                  id: item.id.toString(),
                                ))
                            //  page navigating and song playing in music detailed page

                            );
                      }

                      // int currentIndex = songs.indexWhere((element) =>
                      //     element.id.toString() ==
                      //     favorites[favindex].id.toString());

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicDetailedPage(
                            audio: songAudio,
                            index: favindex,
                            songs: songs,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      favorites[favindex].title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      favorites[favindex].album ?? 'Unknown',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            deleteSong(
                              favorites[favindex].key,
                            );
                          });
                        }),
                  );
                });
          },
        ));
  }
}
