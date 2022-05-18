import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/provider/provider.dart';
import 'package:music_player/screens/mini_player.dart';
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

  List<CustomNavigationBarItem> bottomNavigationItems = [
    CustomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        )),
    CustomNavigationBarItem(
        icon: Icon(Icons.search_outlined),
        title: Text("Search", style: TextStyle(color: Colors.white))),
    CustomNavigationBarItem(
        icon: Icon(Icons.playlist_add_outlined),
        title: Text("Playlist", style: TextStyle(color: Colors.white)))
  ];

  @override
  Widget build(BuildContext context) {
    var currentIndex = Provider.of<IncrementIndex>(context).getIndex;
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: screens[currentIndex]),
          MiniPlayer(),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        bubbleCurve: Curves.linear,
        selectedColor: Color.fromRGBO(6, 246, 14, 1),
        strokeColor: Color.fromARGB(255, 3, 239, 3),
        blurEffect: true,
        unSelectedColor: Colors.grey,
        backgroundColor: Colors.black,
        scaleFactor: 0.5,
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
