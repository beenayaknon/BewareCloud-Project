import 'package:flutter/material.dart';
import 'activity.dart';
import 'user.dart';
import 'weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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