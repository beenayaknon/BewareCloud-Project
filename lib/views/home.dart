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
                    Text('Weather',
                      style: TextStyle(
                        fontSize: 24 * ffem,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff484848),
                      ),),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Weather');
                      },
                      child: Text('Check weather >',
                        style: TextStyle(
                          fontSize: 14 * ffem,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w600,
                          color: Color(0xffB8B8B8),
                        )),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color(0xffFAFAFB),
                child: Padding(
                  padding: EdgeInsets.all(8.0 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5 * fem),
                      Row(
                        children: [
                          SizedBox(width: 20 * fem),
                          Text('26/02/2024',
                              style: TextStyle(
                                fontSize: 18 * ffem,
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 85 * ffem),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(width: 20 * fem),
                                  Icon(Icons.cloud, size: 30 * fem),
                                  SizedBox(width: 10 * fem),
                                  Text('Cloudy', textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 20 * ffem,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff000000),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('45°', textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 64 * ffem,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff000000),
                                  )
                              ),
                              Text('30 / 50 °C', textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 14 * ffem,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5 * ffem),
                    ],
                  ),
                ),
              ),

              // Activity Card
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * ffem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Today Activity',
                      style: TextStyle(
                        fontSize: 24 * ffem,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        color: Color(0xff484848),
                      ),),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Activity');
                      },
                      child: Text('Activity >',
                          style: TextStyle(
                            fontSize: 14 * ffem,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w600,
                            color: Color(0xffB8B8B8),
                          )),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color(0xffFAFAFB),
                child: Padding(
                  padding: EdgeInsets.all(8.0 * fem),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20 * ffem),
                          Image.asset(
                            'assets/icon/calendar.png',
                            width: 40 * fem,
                            height: 40 * fem,
                          ),
                          SizedBox(width: 25 * ffem),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 5 * ffem),
                              Text('Camping', textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20 * ffem,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff000000),
                                  )
                              ),
                              Text('Mae Sot', textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000),
                                  )
                              ),
                              SizedBox(height: 5 * ffem),
                              // Text('30 / 50 °C', textAlign: TextAlign.right),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
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
