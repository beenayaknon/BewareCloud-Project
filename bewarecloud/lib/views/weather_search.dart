import 'package:flutter/material.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Weather'),
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
              child: Text("back"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/Weather'); },
            ),
            ElevatedButton(
              child: Text("WeatherSearchShow Page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/WeatherSearchShow'); },
            ),
          ],
        ),
      ),
    );
  }
}