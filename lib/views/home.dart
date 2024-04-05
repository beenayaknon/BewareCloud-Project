import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'activity_detail.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String apiKey = 'dbc6ddcf06754a25bd1134032242002';
  String _locationInfo = 'Fetching location...';
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchLocationAndWeather();
  }

  Future<void> _fetchLocationAndWeather() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _fetchWeather("Bangkok");
        return;
      }
    }

    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      _fetchWeather("Bangkok");
      return;
    }

    locationData = await location.getLocation();
    _fetchWeather(await _getCityNameFromLocation(locationData));
  }

  Future<String> _getCityNameFromLocation(LocationData locationData) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );
      return placemarks.isNotEmpty
          ? placemarks.first.locality ?? "Bangkok"
          : "Bangkok";
    } catch (e) {
      print("Failed to get city name: $e");
      return "Bangkok";
    }
  }

  Future<void> _fetchWeather(String location) async {
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=no');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body);
          _locationInfo = location;
        });
      } else {
        _locationInfo = "Error fetching weather";
      }
    } catch (e) {
      _locationInfo = "Error fetching weather";
    }
  }

  Future<List<DocumentSnapshot>> _getActivities() async {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activities')
        .get();
    return querySnapshot.docs;
  }

  Future<Map<String, dynamic>?> _fetchWeatherForActivity(
      String location, DateTime date) async {
    // Format the date as required by your weather API, assuming 'yyyy-MM-dd'
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$location&dt=$formattedDate');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Failed to fetch weather data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      return null;
    }
  }

  Widget _buildWeatherCard(double fem, double ffem) {
    if (_weatherData == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      String condition =
          _weatherData!["current"]["condition"]["text"] ?? 'Not available';
      String tempC = "${_weatherData!["current"]["temp_c"]}°C";
      String cityName = _weatherData!["location"]["name"] ?? 'Unknown location';

      return Card(
        color: Color(0xffffffff),
        margin: EdgeInsets.symmetric(vertical: 10.0 * ffem),
        child: Padding(
          padding: EdgeInsets.all(16.0 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weather in $cityName',
                style: TextStyle(
                  fontSize: 20 * ffem,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff484848),
                ),
              ),
              SizedBox(height: 8.0 * ffem),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.wb_sunny, size: 24 * fem),
                      SizedBox(width: 8 * fem),
                      Text(
                        condition,
                        style: TextStyle(
                          fontSize: 18 * ffem,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff484848),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    tempC,
                    style: TextStyle(
                      fontSize: 18 * ffem,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
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
        elevation: 0,
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
                        )),
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
              _buildWeatherCard(fem, ffem),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20 * ffem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Activities',
                        style: TextStyle(
                          fontSize: 24 * ffem,
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff484848),
                        )),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/Activity');
                      },
                      child: Text('Activity List >',
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
              FutureBuilder<List<DocumentSnapshot>>(
                future: _getActivities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return Text("No activity", style: TextStyle(fontSize: 20));
                  } else {
                    // Ensure this list is built correctly with data in scope
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = snapshot.data![index];
                        Map<String, dynamic> activityData =
                            document.data() as Map<String, dynamic>;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivityDetailPage(
                                  activityData: activityData,
                                  activityId: document.id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activityData['activityName'] ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    '${activityData['location'] ?? 'No Location'} - ${DateFormat('dd/MM/yy').format(DateTime.parse(activityData['selectedDate']))}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )
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
