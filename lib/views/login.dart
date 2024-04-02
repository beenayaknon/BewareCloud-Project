import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>(); // Global key for the form

  @override

  Widget build(BuildContext context) {
    // Constants for scaling. Replace with actual values from your design if needed.
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text('Log in'),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 34 * ffem,
          fontWeight: FontWeight.w800,
          color: Color(0xff000000),
        ),
        backgroundColor: Color(0xfffafafb),
        elevation: 0, // No shadow
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(45 * fem, 35 * fem, 45 * fem, 0 * fem),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Username',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 5 * ffem),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    fontFamily: 'Nunito', // Styling for the label
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20 * ffem),
              Text(
                'Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff000000),
                ),
              ),
              SizedBox(height: 5 * ffem),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30 * ffem),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Home');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffbad6eb),
                  minimumSize: Size(350.0, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                child: Text(
                  'Register',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.3625 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 15 * ffem),
              Center( // This will ensure the text is centered in its own line.
                child: Text(
                  'Don’t have an account?',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffb8b8b8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffe8e8e8),
                  minimumSize: Size(350.0, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                child: Text(
                  'Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}