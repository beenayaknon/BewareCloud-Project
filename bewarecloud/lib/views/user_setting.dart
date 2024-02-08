import 'package:flutter/material.dart';

class UserSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("back"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/User'); },
            ),
            ElevatedButton(
              child: Text("notification"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSettingNotification'); },
            ),
            ElevatedButton(
              child: Text("language"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSettingLanguage'); },
            ),
            ElevatedButton(
              child: Text("celcius"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSetting'); },
            ),
            ElevatedButton(
              child: Text("fahrenheit"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSetting'); },
            ),
          ],
        ),
      ),
    );
  }
}