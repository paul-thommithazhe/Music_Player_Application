import 'package:flutter/material.dart';

class IncrementIndex with ChangeNotifier {
  static int selectedIndex =0;
  int get getIndex {
    return selectedIndex;
  }

  void update(int currentIndex) {
   
    selectedIndex = currentIndex;
    notifyListeners();
  }
}
