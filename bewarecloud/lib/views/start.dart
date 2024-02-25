import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, size: 24.0),
                  SizedBox(width: 10),
                  Text("BewareCloud", style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
            ),
            SizedBox(height: 20),
            Text("Don't have an account?"),
            ElevatedButton(
              child: Text("Register"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
