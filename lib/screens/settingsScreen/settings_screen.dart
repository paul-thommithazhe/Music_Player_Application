import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF181722),
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap: () => null,
                title: Text(
                  "Notification",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Switch(
                  onChanged: (value) => null,
                  value: true,
                ),
              ),
              ListTile(
                onTap: () => null,
                title: Text(
                  "Share App",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                title: Text('About'),
              ),
            ]),
      ),
    );
  }
}
