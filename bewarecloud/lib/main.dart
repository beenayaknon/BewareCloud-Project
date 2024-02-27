import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';


import 'views/activity_addactivity.dart';
import 'views/activity_list.dart';
import 'views/activity_show.dart';
import 'views/activity.dart';
import 'views/home.dart';
import 'views/login.dart';
import 'views/register.dart';
import 'views/user_setting.dart';
import 'views/tutorial_1.dart';
import 'views/weather.dart';
import 'views/weather_forecast.dart';
import 'views/start.dart';
import 'views/aboutus.dart';
import 'views/tutorial_1.dart';
import 'views/tutorial_2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("An error occurred while initializing Firebase: $e");
    // Consider handling the error perhaps by showing an error message
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BewareCloud',
      initialRoute: '/',
      routes: {
        '/': (context) => StartPage(),
        '/ActivityAdd': (context) => ActivityAddPage(),
        '/ActivityList': (context) => ActivityListPage(),
        '/ActivityShow': (context) => ActivityShowPage(),
        '/Activity': (context) => ActivityPage(),
        '/Home': (context) => HomePage(),
        '/Login': (context) => LoginPage(),
        '/UserSetting': (context) => UserSettingPage(),
        '/Tutorial1': (context) => Tutorial1Page(),
        '/Weather': (context) => WeatherPage(),
        '/WeatherForecast': (context) => WeatherForecast(),
        '/Register': (context) => RegisterPage(),
        '/Aboutus': (context) => AboutusPage(),
        '/Tutorial1': (context) => Tutorial1Page(),
        '/Tutorial2': (context) => Tutorial2Page(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
