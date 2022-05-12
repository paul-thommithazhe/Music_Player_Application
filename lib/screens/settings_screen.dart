import 'package:flutter/material.dart';

import '../images.dart';

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Theme(
                          data: Theme.of(context).copyWith(
                            scaffoldBackgroundColor: const Color(0xFF181722),
                          ),
                          child: LicensePage(
                            applicationName: 'Music Booster',
                            applicationVersion: '1.0.0',
                            applicationIcon: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  image6,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )),
                          )),
                    ),
                  );
                },
                title: Text('Privcy and Policy'),
              ),
            ]),
      ),
    );
  }
}
