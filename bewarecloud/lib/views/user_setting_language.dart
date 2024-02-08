import 'package:flutter/material.dart';

class UserSettingLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Language'),
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