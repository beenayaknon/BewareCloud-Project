import 'package:flutter/material.dart';

class UserSettingNotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("back"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSetting'); },
            ),
          ],
        ),
      ),
    );
  }
}