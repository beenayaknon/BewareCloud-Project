import 'package:bewarecloud/views/activity_confirmadd.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  void _submitForm() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Activity'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Activity Name'),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _selectedDate,
                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
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
                  decoration: InputDecoration(labelText: 'Location (City)'),
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
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/Activity');
                },
              ),
              ElevatedButton(
                child: Text("Add New Activity"),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
