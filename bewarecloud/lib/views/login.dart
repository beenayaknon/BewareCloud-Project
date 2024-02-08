import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Continue with Google"),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())),
        ),
        
      ),
    );
  }
}
