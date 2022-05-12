import 'package:flutter/foundation.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../screens/music_list.dart';

class HomeController extends ChangeNotifier {
  bool isList = true;
  static int selectedIndex = 0;
  int get getIndex {
    return selectedIndex;
  }

  changeListView() {
    isList = !isList;
    notifyListeners();
  }

  void update(int currentIndex) {
    selectedIndex = currentIndex;
    notifyListeners();
  }

  Future sortingMethod() async {
    getIndex == 0
        ? songs = await audioQuery.querySongs(sortType: SongSortType.TITLE)
        : songs =
            await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED);
    // songs = await audioQuery.querySongs();

    List<SongModel> reversedSongs =
        getIndex == 1 ? List.from(songs.reversed) : songs;
    songs = reversedSongs;

    notifyListeners();
  }

  Future requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await audioQuery.permissionsRequest();
        songs = await audioQuery.querySongs();

        // return songs;
      } else {
        getIndex == 0
            ? songs = await audioQuery.querySongs(sortType: SongSortType.TITLE)
            : songs =
                await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED);
        // songs = await audioQuery.querySongs();

        List<SongModel> reversedSongs =
            getIndex == 1 ? List.from(songs.reversed) : songs;

        songs = reversedSongs;
      }
    }
    notifyListeners();

    // return [];
  }
}
