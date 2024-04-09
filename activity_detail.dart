import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'activity_edit.dart'; // Adjust the path based on your project structure

class ActivityDetailPage extends StatelessWidget {
  final Map<String, dynamic> activityData;
  final Map<String, dynamic>? weatherData;
  final String activityId;

  const ActivityDetailPage({
    Key? key,
    required this.activityData,
    this.weatherData,
    required this.activityId,
  }) : super(key: key);

  void _deleteActivity(BuildContext context) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('activities')
          .doc(activityId)
          .delete();

      Navigator.pushReplacementNamed(context, '/Activity');
    } catch (error) {
      print(error); // For debugging purposes
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error deleting activity. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime activityDate = DateTime.parse(activityData['selectedDate']);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    String displayDate = formatter.format(activityDate);

    String weatherInfo = 'No weather forecast data';
/*
    if (weatherData != null) {
      weatherInfo =
      "${weatherData!['current']['condition']['text']}, "
          "Temp: ${weatherData!['current']['temp_c']}°C, "
          "Wind: ${weatherData!['current']['wind_kph']} kph, "
          "Pressure: ${weatherData!['current']['pressure_mb']} mb, "
          "Humidity: ${weatherData!['current']['humidity']}%";
    }
*/
    var condition = weatherData?['current']['condition']['text'] ?? 'Not available';
    var temp = '${weatherData?['current']['temp_c']?.toString() ?? '--'}°';
    var feelsLike = '${weatherData?['current']['feelslike_c']?.toString() ?? '--'}°';
    var humidity = '${weatherData?['current']['humidity']?.toString() ?? '--'}%';
    var visibility = '${weatherData?['current']['vis_km']?.toString() ?? '--'} km';
    var pressure = '${weatherData?['current']['pressure_mb']?.toString() ?? '--'} mb';

    String iconUrl = weatherData?['current']['condition']['icon'] ?? '//cdn.weatherapi.com/weather/64x64/day/113.png';
    iconUrl = iconUrl.startsWith('http') ? iconUrl : 'http:$iconUrl';


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
            Navigator.pushReplacementNamed(context, '/Activity');
          },
        ),
        title: Text('Activity'),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 32 * ffem,
          fontWeight: FontWeight.w700,
          color: Color(0xff000000),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(activityData['activityName'] ?? 'Activity Details',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize:26 * ffem,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  )),
            ),
            SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 1),
                  Text(temp,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 34 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff000000),
                      )
                  ),
                  SizedBox(width: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Color(0xff000000), size: 20 * fem,),
                            SizedBox(width: 5),
                            Text('${activityData['location']}',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('$displayDate',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            )
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.network(iconUrl, width: 30, // Set the size as needed
                                height: 30,
                                fit: BoxFit.cover),
                            SizedBox(width: 5),
                            Text('$condition',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                )
                            ),
                          ],
                        ),
                      ]
                  ),
                  SizedBox(width: 1),
                ]
            ),
            SizedBox(height: 20),
            Text('Description:',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff000000),
                )
            ),
            Text(activityData['description'] ?? 'No description provided',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                )
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5 * ffem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Color(0xffF0F0F0), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                    child: Container(
                      width: 150.0 * fem,
                      height: 100.0 * ffem,
                      padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'HUMIDITY',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9d9d9d),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text('$humidity',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              )
                          ),
                        ],
                      ),
                    ),
                    elevation: 0,
                  ),

                  // Next Button
                  Card(
                    color: Color(0xffF0F0F0), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                    child: Container(
                      width: 150.0 * fem,
                      height: 100.0 * ffem,
                      padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'FEELSLIKE',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9d9d9d),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text('$feelsLike',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),)
                          ),
                        ],
                      ),
                    ),
                    elevation: 0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5 * ffem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    color: Color(0xffF0F0F0), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                    child: Container(
                      width: 150.0 * fem,
                      height: 100.0 * ffem,
                      padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'VISIBILITY',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9d9d9d),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text('$visibility',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),
                              )
                          ),
                        ],
                      ),
                    ),
                    elevation: 0,
                  ),

                  // Next Button
                  Card(
                    color: Color(0xffF0F0F0), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                    child: Container(
                      width: 150.0 * fem,
                      height: 100.0 * ffem,
                      padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'PRESSURE',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff9d9d9d),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text('$pressure',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),)
                          ),
                        ],
                      ),
                    ),
                    elevation: 0,
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20 * ffem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActivityEditPage(
                            activityData: activityData,
                            activityId: activityId,
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffE8E8E8),
                      minimumSize: Size(150.0 * fem, 60.0 * ffem), // Adjust the size as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50 * fem),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Color(0xff000000)),
                        SizedBox(width: 10.0),
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Next Button
                  TextButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Activity'),
                          content: Text(
                              'Are you sure you want to delete this activity?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteActivity(context);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffBAD6EB),
                      minimumSize: Size(150.0 * fem, 60.0 * ffem), // Adjust the size as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50 * fem),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Color(0xff000000)),
                        SizedBox(width: 10.0),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      /*
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFffffff),
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
      */
    );
  }
}
