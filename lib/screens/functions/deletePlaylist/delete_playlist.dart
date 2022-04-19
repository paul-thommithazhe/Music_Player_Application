import 'package:flutter/material.dart';

deleteAlert(context) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(title: Text("Delete Playlist"), actions: [
      OutlinedButton(
        onPressed: () {},
        child: Text(
          'Delete',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
      OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child:
            Text("Cancel", style: TextStyle(color: Colors.red, fontSize: 16)),
      ),
    ]),
  );
}
