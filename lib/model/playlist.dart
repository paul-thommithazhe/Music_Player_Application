import 'package:flutter/material.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlayList extends ChangeNotifier {
  final onAudioRoom = OnAudioRoom();

  createPlaylist(String playlistName) {
    onAudioRoom.createPlaylist(playlistName);
    notifyListeners();
  }

  deletePlayListKey(playlistKey) {
    onAudioRoom.deletePlaylist(playlistKey);
    notifyListeners();
  }

  // deletePlaylist(context, playlistKey) {
  //   return showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: Column(children: [
  //         Lottie.asset('assets/lottie/delete.json', height: 130, width: 100),
  //         Text(
  //           'Delete the Playlist!! ?',
  //         )
  //       ]),
  //       actions: [
  //         OutlinedButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();

  //             Provider.of<PlayList>(context, listen: false)
  //                 .deletePlayListKey(playlistKey);
  //           },
  //           child: Text(
  //             'Delete',
  //             style: TextStyle(
  //                 color: Color.fromARGB(255, 109, 58, 190), fontSize: 16),
  //           ),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               primary: Color.fromARGB(255, 109, 58, 190)),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text("Cancel",
  //               style: TextStyle(color: Colors.white, fontSize: 16)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  notifyListeners();
}
