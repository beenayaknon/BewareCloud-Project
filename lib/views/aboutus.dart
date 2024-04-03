import 'package:flutter/material.dart';

class AboutusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
              'assets/icon/back.png',
              width:25 * fem,
              height: 25 * fem,
              fit: BoxFit.cover
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/UserSetting');
          },
        ),
        title: Text("About us"),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 34 * ffem,
          fontWeight: FontWeight.w800,
          color: Color(0xff000000),
        ),
        backgroundColor: Color(0xfffafafb),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 45 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xfffafafb),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60 * fem),
            Image.asset(
              'assets/logo/bewareclouddy.png',
              width: 202 * fem,
              height: 202 * fem,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40 * fem),
            Text(
              'BewareCloud',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 32 * ffem,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0 * fem),
              child: Text(
                "Design by: Duang Duean Team\nChanikarn\nSushawapak\nTanawat\nIttikorn",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w600,
                  height: 2 * ffem / fem,
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
