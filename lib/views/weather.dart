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

  // Use this method to get the city name from location data
  Future<String> getCityNameFromLocation(LocationData locationData) async {
    try {
      // Check if latitude and longitude are not null
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
        return "Bangkok"; // Default to "Bangkok" if no placemark is found
      }
    } catch (e) {
      // Log the error if needed
      // print("Failed to get city name: $e");
      return "Bangkok"; // Default to "Bangkok" in case of any exception
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
            // If an error occurs while getting the city name, use "Bangkok" as default
            cityName = "Bangkok";
          }
          setState(() {
            _currentLocation = locationData;
            _locationInfo =
                cityName; // Now storing the city name or "Bangkok" if an error occurred
          });
        } else {
          setState(() {
            _locationInfo =
                "Bangkok"; // Default to "Bangkok" if location data is incomplete
          });
        }
      } catch (e) {
        setState(() {
          _locationInfo =
              "Bangkok"; // Default to "Bangkok" on failure to get location
        });
      }
    } else {
      setState(() {
        _locationInfo =
            "Bangkok"; // Default to "Bangkok" if location permission not granted
      });
    }
  }

  // final String city = 'Bangkok';
  // Fetch current weather data
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Weather Info'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(_locationInfo),
              FutureBuilder<Map<String, dynamic>>(
                future: fetchCurrentWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error fetching current weather: ${snapshot.error}');
                  } else {
                    // Assuming data is returned in the desired format
                    var currentWeather = snapshot.data!;
                    var location = currentWeather['location']['name'];
                    var tempC = currentWeather['current']['temp_c'];
                    var windKph = currentWeather['current']['wind_kph'];
                    var pressureMb = currentWeather['current']['pressure_mb'];
                    var humidity = currentWeather['current']['humidity'];
                    var condition =
                        currentWeather['current']['condition']['text'];

// Displaying the current weather data
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Location: $location',
                              style: TextStyle(fontSize: 20)),
                          Text('Temperature: $tempC°C',
                              style: TextStyle(fontSize: 20)),
                          Text('Wind: $windKph kph',
                              style: TextStyle(fontSize: 20)),
                          Text('Pressure: $pressureMb mb',
                              style: TextStyle(fontSize: 20)),
                          Text('Humidity: $humidity%',
                              style: TextStyle(fontSize: 20)),
                          Text('$condition', style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: double.infinity,
                            height: 50.0,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.directions_run),
                              label: Text("Weather Forecast"),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/WeatherForecast');
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
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
