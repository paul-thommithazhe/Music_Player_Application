import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('search build method');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title:const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search Here....",
            hintStyle: TextStyle(color: Colors.white),
           border: InputBorder.none
          ),
        ),
      ),
      body: Center(
          child: Text(
        "No data",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
