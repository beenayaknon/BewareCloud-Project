import 'package:flutter/material.dart';

class ActivityAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("back"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/ActivityList');
              },
            ),
            ElevatedButton(
              child: Text("add activity"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Activity');
              },
            ),
          ],
        ),
      ),
    );
  }
}
