import 'package:flutter/material.dart';
import 'activity.dart';
import 'tutorial_1.dart';
import 'weather.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> _getActivities() async {
    QuerySnapshot querySnapshot = await _firestore.collection('Activity').get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.black)),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 34 * ffem,
          fontWeight: FontWeight.w800,
          color: Color(0xff000000),
        ),
        backgroundColor: Color(0xFFF1F1F1),
        actions: [
          IconButton(
            icon: Image.asset(
                'assets/icon/settings.png',
                width: 30 * fem,
                height: 30 * fem,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/UserSetting');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * ffem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Button
                    Text('Weather', style: TextStyle(fontSize: 24 * ffem)),
                    Spacer(),
                    // Next Button
                    TextButton(
                      onPressed: () {},
                      child: Text('Check weather >'),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4 * ffem),
                      Row(
                        children: [
                          Icon(Icons.cloud, size: 24 * fem),
                          SizedBox(width: 8 * fem),
                          Text('26/02/2024', style: TextStyle(fontSize: 18 * ffem)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('45°', style: TextStyle(fontSize: 64 * ffem)),
                          Text('Cloudy\n30 / 50 °C', textAlign: TextAlign.right),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16 * ffem),

              // Activity Card
              Text('Today Activity', style: TextStyle(fontSize: 24 * ffem)),
              SizedBox(height: 8 * ffem),
              FutureBuilder(
                future: _getActivities(),
                builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Build a list view of all activities
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                      children: snapshot.data!.map((doc) {
                        return ListTile(
                          leading: Icon(Icons.directions_run),
                          title: Text(doc['Act_title']),
                          subtitle: Text(doc['Act_desc']),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
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
