import 'package:flutter/material.dart';

class UserSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("back"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/User');
                },
              ),
              ElevatedButton(
                child: Text("notification"),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/UserSettingNotification');
                },
              ),
              ElevatedButton(
                child: Text("language"),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/UserSettingLanguage');
                },
              ),
              ElevatedButton(
                child: Text("celcius"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/UserSetting');
                },
              ),
              ElevatedButton(
                child: Text("fahrenheit"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/UserSetting');
                },
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
        ));
  }
}
