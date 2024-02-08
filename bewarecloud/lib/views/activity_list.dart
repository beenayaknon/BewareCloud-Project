import 'package:flutter/material.dart';

class ActivityListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Activity'),
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
              child: Text("add activity page"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityAdd'); },
            ),
            ElevatedButton(
              child: Text("activity show"),
              onPressed: () { Navigator.pushReplacementNamed(context, '/ActivityShow'); },
            ),
          ],
        ),
      ),
    );
  }
}