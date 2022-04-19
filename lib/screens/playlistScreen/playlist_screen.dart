import 'package:flutter/material.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/functions/addPlaylistFunctionScreen/add_to_playlist_alertbox.dart';
import 'package:music_player/widgets/list_of_playlist.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('playlist build ');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: Text('My library'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: () {
              addToPlayList(context);
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 55,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(image1), fit: BoxFit.fill),borderRadius: BorderRadius.circular(3)),
              
            ),
            title: Text("Liked Songs", style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        PlayLists()
      ]),
    );
  }
}

class PlayLists extends StatelessWidget {
  PlayLists({Key? key}) : super(key: key);
  List<String> playlistList = [
    "favourite 1",
    "favourite 2",
    "favourite 3",
  ];
  @override
  Widget build(BuildContext context) {
    return playlistList.isEmpty
        ? Center(
            child: Text(
              "No Playlist Create one",
              style: TextStyle(color: Colors.white),
            ),
          )
        : Column(
            children: [
              ListOfPlaylist(
                title: 'favourite 1',
              ),
              SizedBox(
                height: 20,
              ),
              ListOfPlaylist(
                title: 'favourite 2',
              ),
              SizedBox(
                height: 20,
              ),
              ListOfPlaylist(title: 'favourite 3'),
            ],
          );
  }
}
