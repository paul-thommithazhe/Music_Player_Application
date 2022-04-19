import 'package:flutter/material.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/functions/addPlaylistFunctionScreen/add_to_playlist_alertbox.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181722),
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: Text("Playlist"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 20),
        child: ListView(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                addToPlayList(context);
              },
              child: Text("New Playlist"),
            ),
            SizedBox(height: 40),
            ListTile(
              onTap: (() => null),
              leading: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  image2,
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                "Favourite 1",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
