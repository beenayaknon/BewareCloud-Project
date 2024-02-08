import 'package:flutter/material.dart';
import 'activity.dart';
import 'user.dart';
import 'weather.dart';

class LoginPage extends StatelessWidget {
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
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ActivityPage())),
            ),
            ElevatedButton(
              child: Text("user page"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage())),
            ),
            ElevatedButton(
              child: Text("weather page"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherPage())),
            ),
          ],
        ),
      ),
    );
  }
}