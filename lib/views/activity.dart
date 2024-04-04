import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'activity_detail.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final kFirstDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month - 3,
    DateTime.now().day,
  );
  final kLastDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month + 3,
    DateTime.now().day,
  );

  String get year => '${(_focusedDay.year)}';

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
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final double buttonHeight = 60.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_EN',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration:
                    BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 18),
                titleTextFormatter: (date, locale) =>
                    '${DateFormat.yMMMM(locale).format(date)}',
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add New Activity'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ActivityAdd');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<DocumentSnapshot>>(
              future: _getActivities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Text("No activities found",
                      style: TextStyle(fontSize: 20));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data![index];
                      Map<String, dynamic> activityData =
                          document.data() as Map<String, dynamic>;
                      DateTime activityDate =
                          DateTime.parse(activityData['selectedDate']);

                      return FutureBuilder<Map<String, dynamic>?>(
                        future: _fetchWeather(
                            activityData['location'], activityDate),
                        builder: (context, weatherSnapshot) {
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: ListTile(
                              title: Text(
                                  activityData['activityName'] ?? 'No Title',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  '${activityData['location'] ?? 'No Location'} - ${DateFormat('dd/MM/yyyy').format(activityDate)}'),
                              trailing: Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ActivityDetailPage(
                                      activityData: activityData,
                                      weatherData: weatherSnapshot.data,
                                      activityId: document.id,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
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
