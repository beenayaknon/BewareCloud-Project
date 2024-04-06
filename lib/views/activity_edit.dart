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
        Navigator.pushReplacementNamed(context, '/Activity');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating activity: $error')));
        Navigator.pushReplacementNamed(context, '/Activity');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double fem = 1.0;
    const double ffem = 1.0;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text('Edit Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
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
                    return 'Please enter an activity name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20 * ffem),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black45,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  onTap: () => _selectDate(context),
                  leading: Icon(Icons.calendar_today, color: Colors.black),
                  title: Text(
                      'Selected date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                ),
              ),
              SizedBox(height: 20 * ffem),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description_outlined, size: 30 * fem, color: Colors.black),
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
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20 * ffem),
              TextFormField(
                controller: _locationController,
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
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 50 * ffem),
              TextButton(
                onPressed: () => _updateActivity(context),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xff18378C),
                  minimumSize: Size(350.0, 60.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50 * fem),
                  ),
                ),
                child: Text(
                  'Update Activity',
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
      /*
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFffffff),
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
      */
    );
  }
}
