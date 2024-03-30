import 'package:flutter/material.dart';

class Tutorial2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Tutorial1');
              },
            ),
            ElevatedButton(
              child: Text("Finish"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/UserSetting');
              },
            ),
          ],
        ),
      ),
    );
  }
}
