import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    final permission = await location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await location.requestService();
      if (!result) {
        throw Exception('GPS service not enabled');
      }
    }

    final locationData = await location.getLocation();
    return locationData;
  }

  Future<String> getCityNameFromLocation(LocationData locationData) async {
    try {
      if (locationData.latitude == null || locationData.longitude == null) {
        return "Bangkok"; // Default to "Bangkok" if location data is incomplete
      }

      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        return "${place.locality}, ${place.country}";
      } else {
        return "Bangkok";
      }
    } catch (e) {
      return "Bangkok";
    }
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final String apiKey = 'dbc6ddcf06754a25bd1134032242002';
  final LocationService _locationService = LocationService();
  LocationData? _currentLocation;
  String _locationInfo = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _fetchLocationAndCity();
  }

  Future<void> _fetchLocationAndCity() async {
    bool permissionGranted = await _locationService.requestPermission();
    if (permissionGranted) {
      try {
        LocationData locationData = await _locationService.getCurrentLocation();
        // Check if latitude and longitude are not null
        if (locationData.latitude != null && locationData.longitude != null) {
          String cityName;
          try {
            cityName =
                await _locationService.getCityNameFromLocation(locationData);
          } catch (e) {
            cityName = "Bangkok";
          }
          setState(() {
            _currentLocation = locationData;
            _locationInfo = cityName;
          });
        } else {
          setState(() {
            _locationInfo = "Bangkok";
          });
        }
      } catch (e) {
        setState(() {
          _locationInfo = "Bangkok";
        });
      }
    } else {
      setState(() {
        _locationInfo = "Bangkok";
      });
    }
  }

  Future<Map<String, dynamic>> fetchCurrentWeather() async {
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$_locationInfo&aqi=no');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load current weather data');
    }
  }

  // Fetch weather forecast data
  Future<Map<String, dynamic>> fetchWeatherForecast() async {
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=$_locationInfo&days=3&aqi=no');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather forecast data');
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
        backgroundColor: Color(0xFFF8FAFB),
        appBar: AppBar(
          title: Text('Weather'),
          titleTextStyle: TextStyle(
            fontFamily: 'Heebo',
            fontSize: 36 * ffem,
            fontWeight: FontWeight.w700,
            color: Color(0xff000000),
          ),
          backgroundColor: Color(0xfffafafb),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Text(_locationInfo),
              FutureBuilder<Map<String, dynamic>>(
                future: fetchCurrentWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error fetching current weather: ${snapshot.error}');
                  } else {
                    var currentWeather = snapshot.data!;
                    var location = currentWeather['location']['name'];
                    var tempC = currentWeather['current']['temp_c'];
                    var windKph = currentWeather['current']['wind_kph'];
                    var pressureMb = currentWeather['current']['pressure_mb'];
                    var humidity = currentWeather['current']['humidity'];
                    var feelslike = currentWeather['current']['feelslike_c'];
                    var condition =
                        currentWeather['current']['condition']['text'];
                    var iconUrl =
                    currentWeather['current']['condition']['icon'];
                    if (!iconUrl.startsWith('http')) {
                      iconUrl = 'http:$iconUrl';
                    }

                    return Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text('$location',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),)
                          ),
                          SizedBox(height: 5),
                          Text('$tempC°C',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 26 * ffem,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff000000),)
                          ),
                          SizedBox(height: 5),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(iconUrl, width: 35,
                                    height: 35,
                                    fit: BoxFit.cover),
                                Text('$condition',
                                    style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000),)
                                ),
                              ]
                          ),
                          SizedBox(height: 25),
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
                                    width: 160.0 * fem,
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
                                        Text('$humidity%',
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
                                    width: 160.0 * fem,
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
                                        Text('$feelslike°C',
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
                                    width: 160.0 * fem,
                                    height: 100.0 * ffem,
                                    padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('WIND',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9d9d9d),)
                                          ),
                                          SizedBox(height: 15),
                                          Text('$windKph kph',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 24 * ffem,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff000000),)
                                          ),
                                        ]
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
                                    width: 160.0 * fem,
                                    height: 100.0 * ffem,
                                    padding: EdgeInsets.all(10 * fem), // Inner padding of Card
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('PRESSURE',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff9d9d9d),)
                                          ),
                                          SizedBox(height: 15),
                                          Text('$pressureMb mb',
                                              style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 24 * ffem,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff000000),)
                                          ),
                                        ]
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Card(
                            color: Color(0xffF0F0F0).withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Weather Forecast',
                                    style: TextStyle(
                                      fontSize: 16 * ffem,
                                      fontFamily: 'Nunito',
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20 * ffem,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                      context, '/WeatherForecast');
                                      },
                                  ),
                                ],
                              ),
                            ),
                            elevation: 0,
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: BottomNavigationBar(
            backgroundColor: Color(0xFFffffff),
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
        ));
  }
}
