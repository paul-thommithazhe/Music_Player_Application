import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../../images.dart';

class PlayListScreen extends StatefulWidget {
  PlayListScreen({
    Key? key,
    required this.songIndex,
  }) : super(key: key);
  int songIndex;
  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  OnAudioRoom onAudioRoom = OnAudioRoom();
  final formKey = GlobalKey<FormState>();

  bool isSongAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  addedOrNot(
    int playListKey,
  ) async {
    bool isAdded = await onAudioRoom.checkIn(
      RoomType.PLAYLIST,
      songs[widget.songIndex].id,
      playlistKey: playListKey,
    );
    setState(() {
      isSongAdded = isAdded;
    });

    if (isAdded) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('! Song already added in the playlist',
                textAlign: TextAlign.center),
            backgroundColor: Color.fromARGB(255, 120, 84, 248)));
    } else {
      onAudioRoom.addTo(
        RoomType.PLAYLIST,
        songs[widget.songIndex].getMap.toSongEntity(),
        playlistKey: playListKey,
        ignoreDuplicate: false,
      );
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            duration: Duration(seconds: 2),
            content:
                Text('Song added to playlist', textAlign: TextAlign.center),
            backgroundColor: Color.fromARGB(255, 67, 181, 97)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181722),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF181722),
        title: Text(
          "Playlist",
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 70),
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              creatingPlayList(context);
            },
            child: Text("New Playlist"),
          ),
        ),
        SizedBox(height: 5),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(height: 15),
        FutureBuilder<List<PlaylistEntity>>(
            future: onAudioRoom.queryPlaylists(),
            builder: (context, item) {
              if (item.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No playlist',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              List<PlaylistEntity> playLists = item.data!;
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        addedOrNot(playLists[index].key);
                      },
                      leading: Padding(
                          padding: const EdgeInsets.only(left: 9.0),
                          child: Lottie.asset(
                              'assets/lottie/music-animation.json')),
                      title: Text(
                        playLists[index].playlistName,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: item.data!.length,
                ),
              );
            }),
      ]),
    );
  }

  creatingPlayList(ctx) {
    return showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text("Create your playlist"),
        content: Form(
          key: formKey,
          child: TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*required';
              }
              return null;
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Add to playlist',
            ),
            controller: textController,
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              textController.clear();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 109, 58, 190)),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    onAudioRoom.createPlaylist(textController.text);
                    textController.clear();
                    Navigator.pop(ctx);
                    textController.clear();
                  });
                }
              },
              child: Text(
                'Create',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
