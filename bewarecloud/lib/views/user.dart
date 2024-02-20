import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("setting page"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/UserSetting');
                },
              ),
              ElevatedButton(
                child: Text("log out"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              ElevatedButton(
                child: Text("activity page"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Activity');
                },
              ),
              ElevatedButton(
                child: Text("home page"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Home');
                },
              ),
              ElevatedButton(
                child: Text("weather page"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Weather');
                },
              ),
              ElevatedButton(
                child: Text("user page"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/User');
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
