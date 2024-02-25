import 'package:flutter/material.dart';

class Tutorial1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Tutorial2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
