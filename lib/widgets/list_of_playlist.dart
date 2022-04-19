import 'package:flutter/material.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/functions/deletePlaylist/delete_playlist.dart';

class ListOfPlaylist extends StatelessWidget {
  String title;
  ListOfPlaylist({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 9.0),
        child: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image1),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      trailing: IconButton(
        onPressed: () {
          deleteAlert(context);
        },
        icon: Icon(
          Icons.delete,
        ),
        color: Colors.red,
      ),
    );
  }
}
