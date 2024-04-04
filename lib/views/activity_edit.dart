import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityEditPage extends StatefulWidget {
  final Map<String, dynamic> activityData;
  final String activityId;

  const ActivityEditPage({
    Key? key,
    required this.activityData,
    required this.activityId,
  }) : super(key: key);

  @override
  _ActivityEditPageState createState() => _ActivityEditPageState();
}

class _ActivityEditPageState extends State<ActivityEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.activityData['activityName']);
    _descriptionController =
        TextEditingController(text: widget.activityData['description']);
    _locationController =
        TextEditingController(text: widget.activityData['location']);
    _selectedDate = DateTime.parse(widget.activityData['selectedDate']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _updateActivity(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        String userId = FirebaseAuth.instance.currentUser!.uid;
        DocumentReference activityDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('activities')
            .doc(widget.activityId);

        await activityDoc.update({
          'activityName': _nameController.text,
          'description': _descriptionController.text,
          'location': _locationController.text,
          'selectedDate': _selectedDate.toIso8601String(),
          'userId': userId,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Activity updated successfully')));
        Navigator.pushReplacementNamed(context, '/ActivityList');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating activity: $error')));
        Navigator.pushReplacementNamed(context, '/ActivityList');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Activity Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an activity name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(
                    'Selected date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => _updateActivity(context),
                  child: Text('Update Activity'),
                ),
              ),
            ],
          ),
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
