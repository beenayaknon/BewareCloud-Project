import 'package:flutter/material.dart';
import 'activity.dart';
import 'tutorial_1.dart';
import 'weather.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determining the button size based on screen size
    // Adjust these values as needed
    final double buttonWidth =
        MediaQuery.of(context).size.width * 0.8; // 80% of screen width
    final double buttonHeight = 60.0; // Fixed height

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
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
                  Text("Welcome", style: TextStyle(fontSize: 20.0)),
                ],
              ),
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.directions_run),
                label: Text("Activity"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Activity');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.cloud),
                label: Text("Check weather"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Weather');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.settings),
                label: Text("Setting"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/User');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
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
