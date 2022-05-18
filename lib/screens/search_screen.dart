import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:music_player/screens/music_list.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchValue = '';

  List searchSongs = [];
  List<Audio> searchedSongs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: TextField(
          cursorHeight: 22.0,
           cursorColor: Colors.white,
          onChanged: (value) {
            setState(() {
              searchValue = value;
              print(value);
              print(searchValue);
              print('=============================================================================================');
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: "Search Here....",
              
              hintStyle: TextStyle(
                  color: Colors.white,
                  
                  fontWeight: FontWeight.w700,fontSize: 19),
              border: InputBorder.none),
        ),
      ),
      body: Builder(builder: (context) {
        List searchSongs = songs
            .where((element) =>
                element.title.toLowerCase().contains(searchValue.toLowerCase()))
            .toList();

        return searchSongs.isEmpty
            ? Center(
                child: Text(
                  'No songs',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : ListView.separated(
              physics: BouncingScrollPhysics(),
                itemCount: searchSongs.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 0.1,
                  height: 0,
                ),
                itemBuilder: (context, index) {
                  int currrentIndex = songs.indexWhere(
                      (element) => element.title == searchSongs[index].title);

                  return ListTile(
                    onTap: () {
                      for (var item in songs) {
                        searchedSongs.add(
                          Audio.file(
                            item.uri!,
                            metas: Metas(
                                id: item.id.toString(), title: item.title),
                          ),
                        );
                      }
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MusicDetailedPage(
                              audio: searchedSongs,
                              index: currrentIndex,
                              songs: songs),
                        ),
                      );
                    },
                    title: Text(
                      searchSongs[index].title,
                      style:
                          TextStyle(color: Color.fromARGB(255, 225, 215, 215)),
                    ),
                  );
                },
              );
      }),
    );
  }
}
