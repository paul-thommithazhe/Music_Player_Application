import 'package:flutter/material.dart';
import 'package:music_player/provider/provider.dart';
import 'package:music_player/screens/music_list.dart';
import 'package:music_player/screens/playlist_screen.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  List<Widget> screens = [
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
    var currentIndex = Provider.of<IncrementIndex>(context).getIndex;
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.read<IncrementIndex>().update(index);
          pageController.animateToPage(index,
              duration: Duration(seconds: 1), curve: Curves.ease);
        },
        items: [
          ...bottomNavigationItems,
        ],
      ),
    );
  }
}
