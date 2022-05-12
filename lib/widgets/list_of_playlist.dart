import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

final onAudioQuery = OnAudioQuery();
final onAudioRoom = OnAudioRoom();

class ListOfPlaylist extends StatefulWidget {
  int playlistKey;
  String title;
  int? songIndex;
  ListOfPlaylist({
    Key? key,
    required this.title,
    required this.playlistKey,
    this.songIndex,
  }) : super(key: key);

  @override
  State<ListOfPlaylist> createState() => _ListOfPlaylistState();
}

class _ListOfPlaylistState extends State<ListOfPlaylist> {
  OnAudioRoom onAudioRoom = OnAudioRoom();

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }

  deletingPlaylist(context, playlistKey) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(title: Text("Delete Playlist"), actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              onAudioRoom.deletePlaylist(playlistKey);
              print(playlistKey);
            });
          },
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:
              Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 16)),
        ),
      ]),
    );
  }
}
