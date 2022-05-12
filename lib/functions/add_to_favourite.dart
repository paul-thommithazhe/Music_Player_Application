import 'package:flutter/material.dart';
import 'package:on_audio_room/on_audio_room.dart';
import '../screens/music_list.dart';
import '../widgets/list_of_playlist.dart';

addtoFavourtie(
  BuildContext context,
  int index,
) async {
  onAudioRoom.addTo(RoomType.FAVORITES, songs[index].getMap.toFavoritesEntity(),
      ignoreDuplicate: true);

  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Song is added to Favourite ${songs[index].title}',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 67, 181, 97),
      ),
    );
}
