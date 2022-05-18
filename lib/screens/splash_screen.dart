import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:music_player/images.dart';
import 'package:music_player/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
    
      child: AnimatedSplashScreen(
        splash: Image.asset(
          image8,
        ),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Color(0xFf04141D),
        splashIconSize: 400.0,
        nextScreen: HomePage(),
      ),
    );
  }
}
