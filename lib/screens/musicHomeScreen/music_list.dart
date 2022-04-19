import 'package:flutter/material.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/musicDetaildScreen/music_detailed.dart';
import 'package:music_player/screens/settingsScreen/settings_screen.dart';

class MusicList extends StatelessWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('music list  build');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: Text('Music'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MusicDetailedPage()));
          },
          leading: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image1), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(3)),
            height: 60,
            width: 60,
          ),
          title: Text(
            'Baby Boo',
            style: TextStyle(color: Colors.white),
          ),
          subtitle:
              Text('Zephyrtone', style: TextStyle(color: Colors.grey.shade400)),
          trailing: IconButton(
            onPressed: () {
              bottomSheet(context);
            },
            icon: Icon(
              Icons.more_vert_outlined,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        itemCount: 15,
      ),
    );
  }

  bottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color:  Color(0xFF181722),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromARGB(255, 34, 33, 44) ),
          child: Column(
            mainAxisSize:MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => null,
                leading: Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                ),
                title: Text('Add to Favourite',style:TextStyle(color: Colors.white)),
              ),
              ListTile(
                onTap: () => null,
                leading: Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                title: Text('Add to Playlist'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
