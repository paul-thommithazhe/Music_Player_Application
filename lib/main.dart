import 'package:music_player/provider/provider.dart';
import 'package:music_player/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MusicApp());
}

class MusicApp extends StatelessWidget {
  MusicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IncrementIndex(),
      child: MaterialApp(
        
        title: "Music",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(),
          iconTheme: IconThemeData(color: Colors.white),
          primaryColor: Color(0xFF070A0A),
          scaffoldBackgroundColor: Color(0xFF181722),
          textTheme: TextTheme(titleMedium:TextStyle(color: Colors.white),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
