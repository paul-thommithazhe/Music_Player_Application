import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/images.dart';
import 'package:music_player/model/playlist.dart';
import 'package:music_player/screens/created_playlist_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:provider/provider.dart';

import 'favourite_page_screen.dart';

final textController = TextEditingController();
final onAudioQuery = OnAudioQuery();
final onAudioRoom = OnAudioRoom();

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: Text('My library'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () {
              creatingPlayList(context, formKey, textController);
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavouritePage()));
              },
              leading: Lottie.asset('assets/lottie/flying-heart.json'),
              title: Text("Favourite Songs",
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 5),
            Divider(thickness: 1, color: Color.fromARGB(255, 156, 156, 156)),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<PlayList>(
                  builder: (context, playlist, child) =>
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
                          return ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contex) =>
                                            CreatedPlaylistPage(
                                          playlistKey: playLists[index].key,
                                        ),
                                      ));
                                },
                                leading: SizedBox(
                                  child: Lottie.asset(
                                      'assets/lottie/music-animation.json',
                                      repeat: false,
                                      height: 70),
                                ),
                                title: Text(
                                  playLists[index].playlistName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    deletePlaylist(
                                        context, playLists[index].key);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                  color: Colors.red,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20),
                            itemCount: item.data!.length,
                          );
                        },
                      )),
            ),
          ],
        ),
      ),
    );
  }

  creatingPlayList(ctx, formKey, TextEditingController textController) {
    return showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text("Create your playlist"),
        content: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*required';
              }
              return null;
            },
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(hintText: 'Add to playlist'),
            controller: textController,
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              textController.clear();
              Navigator.of(ctx).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 109, 58, 190),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Provider.of<PlayList>(ctx, listen: false)
                      .createPlaylist(textController.text);
                  textController.clear();
                  Navigator.pop(ctx);
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

  deletePlaylist(context, playlistKey) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Column(children: [
          Lottie.asset('assets/lottie/delete-bubble.json', repeat: false),
          Text(
            'Delete the Playlist!! ?',
          )
        ]),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  color: Color.fromARGB(255, 109, 58, 190), fontSize: 16),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 109, 58, 190)),
            onPressed: () {
              Navigator.pop(context);
              Provider.of<PlayList>(context, listen: false)
                  .deletePlayListKey(playlistKey);
            },
            child: Text("Delete",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
