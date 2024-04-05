import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with actual values from your Figma design.
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      body: Container(
        padding: EdgeInsets.fromLTRB(45 * fem, 170 * fem, 45 * fem, 0 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xfffafafb),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Assuming this is a placeholder for an image from the network
            Text(
              'BewareCloud',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Heebo',
                fontSize: 32 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.4675 * ffem / fem,
                color: Color(0xff091f5b),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(41.5 * fem, 0 * fem, 38.5 * fem, 5.53 * fem),
              width: double.infinity,
              height: 202 * fem,
              // Replace with actual image URL
              child: Image.asset(
                'assets/logo/bewareclouddy.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20), // Adjust space as needed
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff18378C),
                minimumSize: Size(350.0, 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50 * fem),
                ),
              ),
              child: Text(
                'Sign in',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.3625 * ffem / fem,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Don’t have an account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.4675 * ffem / fem,
                color: Color(0xffb8b8b8),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Register');
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xffe8e8e8),
                minimumSize: Size(350.0, 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50 * fem),
                ),
              ),
              child: Text(
                'Sign up',
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
          ],
        ),
      ),
    );
  }
}
