import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("search bar"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/WeatherSearch'); },
            ),
            ElevatedButton(
              child: Text("weather show"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/WeatherShow'); },
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