import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/functions/add_to_favourite.dart';
import 'package:music_player/images.dart';
import 'package:music_player/provider/home_controller.dart';
import 'package:music_player/screens/add_playlist.dart';
import 'package:music_player/screens/music_detailed.dart';
import 'package:music_player/screens/settings_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/list_of_playlist.dart';

var sortType = SongSortType.TITLE;

List<SongModel> songs = [];

// int currentIndex = 0;

class MusicList extends StatefulWidget {
  MusicList({Key? key}) : super(key: key);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final player = AssetsAudioPlayer.withId('music');
  final audioQuery = OnAudioQuery();
  final onAudioRoom = OnAudioRoom();

  late HomeController homeController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var controller = Provider.of<HomeController>(context, listen: false);
      controller.requestPermission();
      print(controller.isNotify);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF181722),
          title: Text(
            'All Songs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<HomeController>(context, listen: false)
                    .changeListView();
              },
              icon: Icon(Icons.grid_view),
              iconSize: 23,
              color: Colors.white,
            ),
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: EdgeInsets.all(0),
                  child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        simpleDialog(
                          context,
                        );
                      },
                      title: Text(
                        'Sorting',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.sort_outlined,
                        color: Colors.black,
                      )),
                ),
                PopupMenuItem(
                    padding: EdgeInsets.all(0),
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                      title: Text(
                        'Settings',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                    )),
              ];
            }),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        body: Consumer<HomeController>(builder: (context, value, child) {
          return FutureBuilder<List<SongModel>>(
            future: OnAudioQuery().querySongs(),
            builder: (context, AsyncSnapshot<List<SongModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 49, 216, 55),
                ));
              }
              if (snapshot.data!.isEmpty)
                return const Center(
                    child: Text(
                  "Nothing found!",
                  style: TextStyle(color: Colors.white),
                ));

              return CupertinoScrollbar(
                child: value.isList
                    ? ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          SongModel song = songs[index];

                          List<Audio> audio = [];

                          return ListTile(
                            onTap: () {
                              for (var item in songs) {
                                audio.add(
                                  Audio.file(
                                    item.uri!,
                                    metas: Metas(
                                      id: item.id.toString(),
                                      title: item.title,
                                    ),
                                  ),
                                );
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicDetailedPage(
                                    audio: audio,
                                    index: index,
                                    songs: songs,
                                  ),
                                ),
                              );
                            },
                            leading: leadingImage(songs[index].id, value),
                            title: Text(
                              song.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(song.album ?? 'Unknown',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey.shade400)),
                            trailing: IconButton(
                              onPressed: () {
                                bottomSheet(context, index, audio);
                              },
                              icon: Icon(
                                Icons.more_vert_outlined,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          );
                        },
                        itemCount: songs.length,
                      )
                    : GridView.builder(
                        itemCount: songs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          List<Audio> audio = [];
                          return Container(
                            padding: EdgeInsets.all(10),
                            // color: Colors.green,
                            child: GestureDetector(
                              onTap: () {
                                for (var item in songs) {
                                  audio.add(
                                    Audio.file(
                                      item.uri!,
                                      metas: Metas(
                                        id: item.id.toString(),
                                        title: item.title,
                                      ),
                                    ),
                                  );
                                }
                                print(audio.map((e) => e.networkHeaders));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicDetailedPage(
                                      audio: audio,
                                      index: index,
                                      songs: songs,
                                    ),
                                  ),
                                );
                              },
                              child: GridTile(
                                header: leadingImage(songs[index].id, value),
                                footer: Text(
                                  songs[index].title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                                child: Text(
                                  songs[index].album!,
                                  style: TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              );
            },
          );
        }));
  }

  querysongsWithTitle() async {
    print('hello');
    songs = await onAudioQuery.querySongs(sortType: SongSortType.TITLE);
  }

  querysongsWithDate() async {
    songs = await onAudioQuery.querySongs(sortType: SongSortType.DATE_ADDED);
  }

  simpleDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return CustomDialogContent(
          context1: context,
        );
      },
    );
  }

  bottomSheet(context, index, List<Audio> audio) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Color(0xFF181722),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromARGB(255, 34, 33, 44)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  addtoFavourtie(context, index);
                },
                leading: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
                title: Text('Add to Favourite',
                    style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => (PlayListScreen(songIndex: index)),
                    ),
                  );
                },
                leading: Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                title: Text('Add to Playlist'),
              ),
              ListTile(
                onTap: () {
                  List<Audio> audios = [];
                  for (var item in songs) {
                    audios.add(
                      Audio.file(
                        item.uri!,
                        metas: Metas(
                          id: item.id.toString(),
                          title: item.title,
                        ),
                      ),
                    );
                  }
                  Navigator.of(context).pop();

                  print(songs[index].data);
                  Share.shareFiles(["${songs[index].data}"]);
                },
                leading: Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 21,
                ),
                title: Text(
                  'Share Song',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  leadingImage(int id, value) {
    return QueryArtworkWidget(
      id: id,
      type: ArtworkType.AUDIO,
      artworkWidth: 50,
      artworkHeight: value.isList ? 70 : 120,
      artworkBorder: BorderRadius.circular(3),
      nullArtworkWidget: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image6), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(3)),
        height: value.isList ? 60 : 120,
        width: 60,
      ),
    );
  }
}

class CustomDialogContent extends StatelessWidget {
  CustomDialogContent({required this.context1, Key? key}) : super(key: key);
  BuildContext context1;

  @override
  Widget build(BuildContext context) {
    final currentValue = Provider.of<HomeController>(context).getIndex;
    final controller = Provider.of<HomeController>(context);
    return SimpleDialog(
      backgroundColor: Color.fromARGB(255, 58, 56, 56),
      title: Text(
        'Sorting',
        style: TextStyle(color: Colors.white),
      ),
      children: [
        RadioListTile(
            title: Text('By Name'),
            value: 0,
            groupValue: currentValue,
            onChanged: (int? index) {
              Navigator.pop(context);
              Provider.of<HomeController>(context, listen: false)
                  .update(index!);
              controller.sortingMethod();
            }),
        RadioListTile(
            title: Text('By Latest'),
            value: 1,
            groupValue: currentValue,
            onChanged: (int? index) {
              Navigator.pop(context);
              Provider.of<HomeController>(context, listen: false)
                  .update(index!);
              controller.sortingMethod();
            })
      ],
    );
  }
}
