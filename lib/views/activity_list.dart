import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'activity_detail.dart';

class ActivityListPage extends StatefulWidget {
  @override
  _ActivityListPageState createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DocumentSnapshot>> _getActivities() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .get();
    return querySnapshot.docs;
  }

  Future<Map<String, dynamic>?> _fetchWeather(
      String location, DateTime activityDate) async {
    final DateTime now = DateTime.now();
    final DateTime threeDaysFromNow = now.add(Duration(days: 3));
    if (activityDate.isAfter(now) && activityDate.isBefore(threeDaysFromNow)) {
      final String apiKey = 'dbc6ddcf06754a25bd1134032242002';
      final url = Uri.parse(
          'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=no');
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          return json.decode(response.body);
        }
      } catch (e) {
        print("Error fetching weather data: $e");
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Activities'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: _getActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data!.isEmpty) {
            return Text("No activity", style: TextStyle(fontSize: 20));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data![index];
                String documentId = document.id;
                Map<String, dynamic> activityData =
                    document.data() as Map<String, dynamic>;
                DateTime activityDate =
                    DateTime.parse(activityData['selectedDate']);

                return FutureBuilder<Map<String, dynamic>?>(
                  future: _fetchWeather(activityData['location'], activityDate),
                  builder: (context, weatherSnapshot) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailPage(
                              activityData: activityData,
                              weatherData: weatherSnapshot.data,
                              activityId: documentId,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: ListTile(
                          title:
                              Text(activityData['activityName'] ?? 'No Title'),
                          subtitle: Text(
                              '${activityData['location'] ?? 'No Location'} - ${DateFormat('dd/MM/yy').format(activityDate)}'),
                          trailing: Text('View Details'),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
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
