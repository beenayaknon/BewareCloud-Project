import 'package:flutter/material.dart';

class WeatherShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Weather'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("back"),
          onPressed: () { Navigator.pushReplacementNamed(context, '/Weather'); },
        ),
      ),
    );
  }
}