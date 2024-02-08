import 'package:flutter/material.dart';

class WeatherSearchShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Search Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("cancle"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/WeatherSearch'); },
            ),
            ElevatedButton(
              child: Text("pin"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/Weather'); },
            ),
          ],
        ),
      ),
    );
  }
}