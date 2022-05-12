import 'package:flutter/material.dart';
import 'package:music_player/model/playlist.dart';
import 'package:music_player/provider/home_controller.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:provider/provider.dart';
import 'package:music_player/provider/provider.dart';
import 'package:music_player/screens/home_page.dart';

void main() async {
  await OnAudioRoom().initRoom();
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  MusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => PlayList()),
        ChangeNotifierProvider(create: (context) => IncrementIndex())
      ],
      child: MaterialApp(
        title: "Music",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color:Color(0xFF181722) ),
          bottomSheetTheme: BottomSheetThemeData(),
          iconTheme: IconThemeData(color: Colors.white),
          primaryColor: Color(0xFF070A0A),
          highlightColor: Color.fromARGB(255, 95, 102, 100),
          scaffoldBackgroundColor: Color(0xFF181722),
          textTheme: TextTheme(
            titleMedium: TextStyle(color: Colors.white),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
