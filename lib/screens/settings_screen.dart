import 'package:flutter/material.dart';
import 'package:music_player/provider/home_controller.dart';
import 'package:provider/provider.dart';

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
              // ListTile(
              //   title: Text(
              //     "Notification",
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   trailing: Switch(
              //     onChanged: (value) {
              //       Provider.of<HomeController>(context,listen: false)
              //           .changeNotification();
              //     },
              //     value: Provider.of<HomeController>(context).isNotify,
              //   ),
              // ),
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
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('TuneNation '),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'TuneNation Music Player App',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                          Text('Version 1.0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                title: Text('About'),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicencePageSimple(),
                    ),
                  );
                },
                title: Text('Privcy and Policy'),
              )
            ]),
      ),
    );
  }
}

class LicencePageSimple extends StatelessWidget {
  const LicencePageSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: LicensePage(
        applicationName: 'TuneNation',
        applicationVersion: '2.0 ',
        applicationIcon: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              image7,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
