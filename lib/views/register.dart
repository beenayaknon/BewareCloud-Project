import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Constants for scaling based on your design system
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
        backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text('Register'),
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
              //SizedBox(height: 24 * ffem),
              Text(
                'Email',
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
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20 * ffem),
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
                controller: usernameController,
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
                controller: passwordController,
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
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * ffem / fem,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 30 * ffem),
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
