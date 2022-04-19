import 'package:flutter/material.dart';

class IncrementIndex extends ChangeNotifier  {

  
 
  
  static int selectedIndex = 0;
  int get getIndex {
    return selectedIndex;
  }

  void increment(currentIndex) {
     selectedIndex = currentIndex;
    notifyListeners();
    
  }
  
}

