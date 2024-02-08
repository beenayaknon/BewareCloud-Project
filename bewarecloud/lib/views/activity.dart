import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("activity list page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityList'); },
            ),
            ElevatedButton(
              child: Text("add activity page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityAdd'); },
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