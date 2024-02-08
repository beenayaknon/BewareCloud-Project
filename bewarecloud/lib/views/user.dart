import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("setting page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/UserSetting'); },
            ),
            ElevatedButton(
              child: Text("log out"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/'); },
            ),
            ElevatedButton(
              child: Text("activity page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/Activity'); },
            ),
            ElevatedButton(
              child: Text("home page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/Home'); },
            ),
            ElevatedButton(
              child: Text("weather page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/Weather'); },
            ),
            ElevatedButton(
              child: Text("user page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/User'); },
            ),
          ],
        ),
      ),
    );
  }
}