import 'package:flutter/material.dart';

class UserSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text('Setting'),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 36 * ffem,
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ),
        backgroundColor: Color(0xfffafafb),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(45 * fem, 170 * fem, 45 * fem, 0 * fem),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Tutorial"),
              titleTextStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Tutorial1');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20 * fem),
              ),
              tileColor: Color(0xffE8E8E8),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 10 * fem),
            ListTile(
              title: Text("About us"),
              titleTextStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Aboutus');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20 * fem),
              ),
              tileColor: Color(0xffE8E8E8),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 10 * fem),
            ListTile(
              title: Text("Log out"),
              titleTextStyle: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w700,
                color: Color(0xff000000),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20 * fem),
              ),
              tileColor: Color(0xffE8E8E8),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFffffff),
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/Home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/Activity');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/Weather');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/UserSetting');
                break;
            }
          },
        ),
      ),
    );
  }
}
