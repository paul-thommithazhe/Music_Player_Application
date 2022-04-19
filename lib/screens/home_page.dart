import 'package:flutter/material.dart';
import 'package:music_player/provider/provider.dart';
import 'package:music_player/screens/musicHomeScreen/music_list.dart';
import 'package:music_player/screens/searchScreen/search_screen.dart';
import 'package:provider/provider.dart';

import 'playlistScreen/playlist_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  List screens = [
    const MusicList(),
    SearchScreen(),
    const PlaylistScreen(),
  ];
  final pages = [
    MusicList(),
    SearchScreen(),
    PlaylistScreen(),
  ];
  IncrementIndex indexValue = IncrementIndex();

  List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "search"),
    BottomNavigationBarItem(
        icon: Icon(Icons.playlist_add_outlined), label: "playlist")
  ];

  @override
  Widget build(BuildContext context) {
    print('home page build');
    var currentIndex = Provider.of<IncrementIndex>(context).getIndex;
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: (index) {
          pageController.jumpToPage(index);
          context.read<IncrementIndex>().increment(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.jumpToPage(index);
          context.read<IncrementIndex>().increment(index);
        },
        items: [
          ...bottomNavigationItems,
        ],
      ),
    );
  }
}
