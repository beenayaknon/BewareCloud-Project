import 'package:bewarecloud/views/activity_confirmadd.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityAddPage extends StatefulWidget {
  @override
  _ActivityAddPageState createState() => _ActivityAddPageState();
}

class _ActivityAddPageState extends State<ActivityAddPage> {
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String _activityName = '';
  String _description = '';
  String _location = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityConfirmPage(
            activityName: _activityName,
            description: _description,
            location: _location,
            selectedDate: _selectedDate,
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
        title: Text('Add Activity'),
        titleTextStyle: TextStyle(
          fontFamily: 'Heebo',
          fontSize: 34 * ffem,
          fontWeight: FontWeight.w800,
          color: Color(0xff000000),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0 * fem),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Activity Name',
                    prefixIcon: Icon(Icons.label_outline_rounded, size: 30 * fem, color: Colors.black), // Use your custom icon
                    labelStyle: TextStyle(
                      fontFamily: 'Heebo',
                      fontSize: 16 * ffem,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1 * fem),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Activity name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _activityName = value!;
                  },
                ),
              ),
              SizedBox(height: 5 * ffem),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _selectedDate,
                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay
                        .isBefore(DateTime.now().subtract(Duration(days: 1)))) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cannot select this date."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                ),
              ),
              SizedBox(height: 5 * ffem),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.description_outlined, size: 30 * fem, color: Colors.black), // Use your custom icon
                    labelStyle: TextStyle(
                      fontFamily: 'Heebo',
                      fontSize: 16 * ffem,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1 * fem),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Lacation',
                    prefixIcon: Icon(Icons.location_on_outlined, size: 30 * fem, color: Colors.black), // Use your custom icon
                    labelStyle: TextStyle(
                      fontFamily: 'Heebo',
                      fontSize: 16 * ffem,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 1 * fem),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF000000), width: 2 * fem),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bangkok';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _location = value!;
                  },
                ),
              ),
              SizedBox(height: 10 * ffem),
              TextButton(
                onPressed: _submitForm,
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff18378C),
                  minimumSize: Size(350.0, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                child: Text(
                  'Add New Activity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16 * ffem,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
