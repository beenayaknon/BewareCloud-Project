import 'package:flutter/material.dart';
import 'activity.dart';
import 'user.dart';
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
              padding: EdgeInsets.only(
                  bottom: 20.0), // Adds space below the welcome text
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, size: 24.0), // Cloud icon
                  SizedBox(width: 10), // Space between icon and text
                  Text("Welcome",
                      style: TextStyle(fontSize: 20.0)), // Welcome text
                ],
              ),
            ),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.directions_run), // Icon for Activity
                label: Text("Activity"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Activity');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0)), // Reduced border radius
                ),
              ),
            ),
            SizedBox(height: 10), // Adds space between buttons
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.cloud), // Icon for Check weather
                label: Text("Check weather"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Weather');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0)), // Reduced border radius
                ),
              ),
            ),
            SizedBox(height: 10), // Adds space between buttons
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.settings), // Icon for Setting
                label: Text("Setting"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/User');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.0)), // Reduced border radius
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
          type: BottomNavigationBarType
              .fixed, // Ensure all text labels are visible
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
