import 'package:on_audio_room/on_audio_room.dart';

deleteSong(int songKey, {int? playListKey}) {
  if (playListKey == null) {
    OnAudioRoom().deleteFrom(
      RoomType.FAVORITES,
      songKey,

      //playlistKey,
    );
  } else {
    OnAudioRoom().deleteFrom(
      RoomType.PLAYLIST,
      songKey,
      playlistKey: playListKey,

      //playlistKey,
    );
  }
}
