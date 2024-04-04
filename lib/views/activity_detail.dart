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
      await FirebaseFirestore.instance
          .collection('activities')
          .doc(activityId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Activity deleted successfully')));
      Navigator.of(context).pop(); // Go back to the previous screen
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
    if (weatherData != null) {
      weatherInfo =
          "${weatherData!['current']['condition']['text']}, Temp: ${weatherData!['current']['temp_c']}°C, Wind: ${weatherData!['current']['wind_kph']} kph, Pressure: ${weatherData!['current']['pressure_mb']} mb, Humidity: ${weatherData!['current']['humidity']}%";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activityData['activityName'] ?? 'Activity Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Date: $displayDate', style: TextStyle(fontSize: 20)),
            Text('Location: ${activityData['location']}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('Description:', style: TextStyle(fontSize: 24)),
            Text(activityData['description'] ?? 'No description provided',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Weather Info:', style: TextStyle(fontSize: 24)),
            Text(weatherInfo, style: TextStyle(fontSize: 18)),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
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
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                ),
                ElevatedButton.icon(
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
                              Navigator.of(context).pop(); // Dismiss the dialog
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  ),
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                ),
              ],
            )
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
