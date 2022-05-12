import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/functions/delete_songs.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:on_audio_room/on_audio_room.dart';

class CreatedPlaylistPage extends StatefulWidget {
  CreatedPlaylistPage({Key? key, required this.playlistKey}) : super(key: key);

  final int playlistKey;

  @override
  State<CreatedPlaylistPage> createState() => _CreatedPlaylistPageState();
}

class _CreatedPlaylistPageState extends State<CreatedPlaylistPage> {
  List<Audio> songAudio = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Created Playlist page'),
        backgroundColor: Color(0xFF181722),
      ),
      body: FutureBuilder<List<SongEntity>>(
          future: OnAudioRoom()
              .queryAllFromPlaylist(widget.playlistKey, sortType: null),
          builder: (context, item) {
            if (item.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return item.data!.isEmpty
                ? Center(
                    child: Text(
                      'No songs',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.separated(
                    itemCount: item.data!.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      thickness: 0.1,
                    ),
                    itemBuilder: (contex, index) {
                      List<SongEntity> playlist = item.data!;
                      return ListTile(
                        onTap: () {
                          for (var item in playlist) {
                            songAudio.add(
                                //TODO
                                Audio.file(item.lastData.toString(),
                                    metas: Metas(
                                        title: item.title,
                                        id: item.id.toString()))
                                //  page navigating and song playing in music detailed page

                                );
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicDetailedPage(
                                      audio: songAudio,
                                      index: index,
                                      songs: songs)));
                        },
                        title: Text(
                          item.data![index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            int songKey = item.data![index].id;

                            setState(() {
                              deleteSong(songKey,
                                  playListKey: widget.playlistKey);
                            });
                          },
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
