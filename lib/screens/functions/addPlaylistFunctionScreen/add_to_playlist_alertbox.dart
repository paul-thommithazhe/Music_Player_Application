import 'package:flutter/material.dart';

addToPlayList(context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Create your playlist"),
        content: TextField(decoration: InputDecoration(hintText: 'Add to playlist')),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {},
            child: Text("create",style: TextStyle(color: Colors.green,fontSize: 16),),
          ),
          OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('cancel',style: TextStyle(color: Colors.red,fontSize: 16),))
        ],
      ),
    );
  }