import 'package:flutter/material.dart';

class ActivityShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("back"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityList'); },
            ),
            ElevatedButton(
              child: Text("delete"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityList'); },
            ),
            ElevatedButton(
              child: Text("edit"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityAdd'); },
            ),
          ],
        ),
      ),
    );
  }
}